
## Overview
Notification service  has been redesigned to store in-app notification for the users .Hence all user notification will be stored in the notification_feed table in sunbird_notifications keyspace. Also to support the older mobile apps also the redirection of the api call to user feed creation has been moved to new notification_feed. So as a part of this change, the old notifications generated for a user will be moved to new notification table. The old user feed will be stored in new notification_feed table in both v1 and v2 format.


```
Validate keyspace and table exists
desc sunbird_notifications.notification_feed 

output :
CREATE TABLE sunbird_notifications.notification_feed(
    id text,
    action text,
    category text,
    createdby text,
    createdon timestamp,
    expireon timestamp,
    priority int,
    status text,
    updatedby text,
    updatedon timestamp,
    userid text,
    version text,
    primary key(userid,id)
);
```
Run Migration script:


```
vi UserFeedMigration.scala
copy data from below UserFeedMigration.scala file  and paste it to  UserFeedMigration.scala
cd to the spark directory
bin/spark-shell --master local[*] --packages com.datastax.spark:spark-cassandra-connector_2.11:2.5.0
:load {{absolute path of UserFeedMigration.scala}}
UserFeedMigration.main("{cassandra ip}")
```


Script :  


```scala
import com.typesafe.config.{Config, ConfigFactory}
import org.apache.spark.sql.Row
import org.apache.spark.sql.functions.{col, _}
import org.apache.spark.sql.{ DataFrame, SparkSession }
import org.apache.spark.sql.Encoders
import org.apache.spark.sql.SaveMode
import org.apache.spark.storage.StorageLevel
import org.apache.spark.sql.functions.{array_distinct, flatten}
import org.apache.spark.sql.expressions.Window
import org.apache.spark.rdd.RDD
import org.apache.spark.SparkContext
import org.apache.spark.SparkContext._
import org.apache.spark.broadcast.Broadcast
import org.apache.spark.sql.functions.typedLit
import org.apache.spark.sql.Column
import java.io.File 
import java.io.PrintWriter 
import java.sql.Timestamp
import org.apache.spark.sql.types.{MapType, StringType}
import org.apache.spark.sql.functions.{to_json, from_json}
import org.json4s._
import org.json4s.jackson.JsonMethods._
import scala.io._
import com.fasterxml.jackson.databind.ObjectMapper
import com.fasterxml.jackson.module.scala.DefaultScalaModule
import com.fasterxml.jackson.module.scala.experimental.ScalaObjectMapper
import scala.collection.mutable.HashMap
import org.apache.spark.sql.types.StructType

/*
*   
*   
*   Migrate Data from sunbird.user_feed table to sunbird_notification.notification_feed
*      
*/




object UserFeedMigration extends Serializable {



  def main(cassandra: String): Unit = {
    implicit val spark: SparkSession = SparkSession.builder().appName("UserFeedMigration").config("spark.master", "local[*]").config("spark.cassandra.connection.host",cassandra).config("spark.cassandra.read.timeoutMS","60000").getOrCreate()

    val res = time(migrateData());

    Console.println("Time taken to execute script", res._1);
    spark.stop();
  }

def migrateData()(implicit spark: SparkSession) {

    val file = new File("validation_count.txt" ) 
    val print_Writer = new PrintWriter(file)

    //Reading data from user_feed table
    val userFeedData = spark.read.format("org.apache.spark.sql.cassandra").option("keyspace", "sunbird").option("table", "user_feed").load();
    print_Writer.write("User Feed Table records:"+ userFeedData.count() );

    
    val userFeedV1 =   userFeedData.withColumnRenamed("data","action").withColumn("version",lit("v1"))   
    
    userFeedV1.persist()            
                              
    userFeedV1.write.format("org.apache.spark.sql.cassandra").option("keyspace", "sunbird_notifications").option("table", "notification_feed").mode(SaveMode.Append).save();   
    
    userFeedV1.unpersist()
    
    val json_schema = spark.read.json(userFeedData.select("data").as[String]).schema
    val datafields = json_schema.filter(p => !p.name.equals("actionData")).map(f => "data."+ f.name)

    val actionfields = json_schema.filter(c => c.name == "actionData").flatMap(_.dataType.asInstanceOf[StructType].fields).filter(p => !(p.name.equals("title") || p.name.equals("description"))).map(f => "data.actionData." + f.name)
    
    val finalfields = datafields ++ actionfields

    val userFeedWithNewUUID = userFeedData.withColumn("newId",expr("uuid()")).withColumn("data", from_json(col("data"), json_schema))


    val userFeedV2 = userFeedWithNewUUID.select($"newId".as("id"),$"category",$"createdby",$"createdon",$"expireon",$"priority", $"status",
     $"updatedby",$"updatedon",$"userid",to_json(
        struct(
          $"data.actionData.actionType".as("type"),
        $"category".as("category"),
        struct(to_json(struct($"data.actionData.title".as("title"), $"data.actionData.description".as("description"))).as("data"),lit("4.4.0").as("ver"),lit("JSON").as("type")).as("template"),
        struct(lit("System").as("type"), $"createdby".as("id")).as("createdBy"),
        struct(finalfields.head,finalfields.tail:_*).as("additionalInfo")
      )).as("action"))
    
   userFeedV2.persist()
   
   userFeedV2.write.format("org.apache.spark.sql.cassandra").option("keyspace", "sunbird_notifications").option("table", "notification_feed").mode(SaveMode.Append).save(); 
   
   userFeedV2.unpersist()
   
   
    val v1mapv2 = userFeedWithNewUUID.select(col("id"),col("newId"))
    val v1FeedVersionV2 = v1mapv2.withColumnRenamed("newId","feedid")
    
    v1FeedVersionV2.persist()
    
    print_Writer.write("Notification Feed Mapping V1 to V2:"+ v1FeedVersionV2.count() );
    
    v1FeedVersionV2.write.format("org.apache.spark.sql.cassandra").option("keyspace", "sunbird_notifications").option("table", "feed_version_map").mode(SaveMode.Append).save();
    
    v1FeedVersionV2.unpersist()
    
    val v2FeedVersionV1Temp = v1mapv2.withColumnRenamed("id","feedid")
    
    val v2FeedVersionV1 = v2FeedVersionV1Temp.withColumnRenamed("newId","id");
    
    print_Writer.write("Notification Feed Mapping V2 to V1:"+ v2FeedVersionV1.count() );

    v2FeedVersionV1.persist()
    
    v2FeedVersionV1.write.format("org.apache.spark.sql.cassandra").option("keyspace", "sunbird_notifications").option("table", "feed_version_map").mode(SaveMode.Append).save();
    
    v2FeedVersionV1.unpersist()  
    

    print_Writer.close()     


  }
  
  
  def time[R](block: => R): (Long, R) = {
    val t0 = System.currentTimeMillis()
    val result = block // call-by-name
    val t1 = System.currentTimeMillis()
    ((t1 - t0), result)
  }
}
```



## Analysis  :  

```
//Get one notification from user_feed table :
select * from sunbird.user_feed limit 1 ;

// Get the id of the result e.g 06c219da-14de-47d4-be26-c4dd147dca3e

POST Migration :
select * from sunbird_notifications.notification_feed where id="06c219da-14de-47d4-be26-c4dd147dca3e";
id                                   | action                                                                                                                                                                                                                 | category     | createdby | createdon                       | expireon | priority | status | updatedby | updatedon | userid                               | version
--------------------------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+-----------+---------------------------------+----------+----------+--------+-----------+-----------+--------------------------------------+---------
 06c219da-14de-47d4-be26-c4dd147dca3e | {"type":1,"actionData":{"actionType":"certificateUpdate","title":"4.0 trackable collbook","description":"You have earned a certificate! Download it from your profile page.","identifier":"do_213308763666866176115"}} | Notification |      null | 2021-07-30 14:41:39.447000+0000 |     null |        1 | unread |      null |      null | f3106628-d6d2-4aa6-b512-b4cbd57a8a45 |      v1


sunbird_notifications> select * from feed_version_map where id='06c219da-14de-47d4-be26-c4dd147dca3e';

 id                                   | feedid
--------------------------------------+--------------------------------------
 06c219da-14de-47d4-be26-c4dd147dca3e | 34e0832d-24c3-414c-9a92-e05e1bb66ceb


//Get the feed id of the response
select * from feed_version_map where id="34e0832d-24c3-414c-9a92-e05e1bb66ceb"

id                                   | feedid
--------------------------------------+--------------------------------------
34e0832d-24c3-414c-9a92-e05e1bb66ceb | 06c219da-14de-47d4-be26-c4dd147dca3e


 select * from notification_feed where id='34e0832d-24c3-414c-9a92-e05e1bb66ceb';
 
id                                   | action                                                                                                                                                                                                                                                                                                                                                                              | category     | createdby | createdon                       | expireon | priority | status | updatedby | updatedon | userid                               | version
--------------------------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+-----------+---------------------------------+----------+----------+--------+-----------+-----------+--------------------------------------+---------
 34e0832d-24c3-414c-9a92-e05e1bb66ceb | {"type":"certificateUpdate","category":"Notification","createdBy":{"type":"System","id":null},"template":{"type":"JSON","data":"{\"description\":\"You have earned a certificate! Download it from your profile page.\",\"title\":\"4.0 trackable collbook\"}","ver":"4.4.0"},"additionalInfo":{"type":1,"identifier":"do_213308763666866176115","actionType":"certificateUpdate"}} | Notification |      null | 2021-07-30 14:41:39.447000+0000 |     null |        1 | unread |      null |      null | f3106628-d6d2-4aa6-b512-b4cbd57a8a45 |    null





```


*****

[[category.storage-team]] 
[[category.confluence]] 
