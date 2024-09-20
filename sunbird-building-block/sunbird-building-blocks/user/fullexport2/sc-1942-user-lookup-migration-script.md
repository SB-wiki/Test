
### Overview
To avoid the usage of secondary index and provide a better performance the user related identifiers are getting to a new table  _user_lookup._ As a part of this migration script it will externalId, email, phone and username will be moved to  _user_lookup_ table.




```sql
CREATE TABLE IF NOT EXISTS sunbird.user_lookup(
 type text,
 value text,
 userId text,
 primary key((type,value))
);
```
Follow the step to run manually:


```
check table exists: user_lookup
vi UserLookupMigration.scala
copy data from below UserLookupMigration.scala file  and paste it to  UserLookupMigration.scala
cd to the spark directory
bin/spark-shell --master local[*] --packages com.datastax.spark:spark-cassandra-connector_2.11:2.5.0
:load {{absolute path of UserLookupMigration.scala}}
UserLookupMigration.main("{cassandra ip}")
```

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
import org.apache.spark.SparkConf
import org.apache.spark.SparkContext
import org.apache.spark.SparkContext._
import org.apache.spark.broadcast.Broadcast
import org.apache.spark.sql.functions.typedLit
import org.apache.spark.sql.Column
import java.io.File 
import java.io.PrintWriter 

/*
*   User: Schema for User table
*   UserExternalIdentity : Schema for usr_external_identity table
*   UserOrg:  Schema for user_org table
*   UserLookup: Schema for user_lookup table   
*/

case class User(id: String, username: Option[String], phone: Option[String], email: Option[String],rootorgid:String)
case class UserExternalIdentity(userid: String, externalid: String, idtype: String, provider: String)
case class UserLookup(`type`: String, value: String, userid: String)




object UserLookupMigration extends Serializable {



  def main(cassandra: String): Unit = {
    implicit val spark: SparkSession =
      SparkSession
        .builder()
        .appName("UserLookupMigration")
        .config("spark.master", "local[*]")
        .config("spark.cassandra.connection.host",cassandra)
        .config("spark.cassandra.output.batch.size.rows", "10000")
        .config("spark.cassandra.read.timeoutMS","60000")
        .getOrCreate()


    val res = time(migrateData());

    Console.println("Time taken to execute script", res._1);
    spark.stop();
  }

def migrateData()(implicit spark: SparkSession) {
    val userschema = Encoders.product[User].schema
    val stateUserSchema = Encoders.product[UserExternalIdentity].schema
    val userLookupschema = Encoders.product[UserLookup].schema
    val file = new File("validation_count.txt" ) 
    val print_Writer = new PrintWriter(file)
    // Read user, user_org and usr_external identity table intot the memory 

    val userdata = spark.read.format("org.apache.spark.sql.cassandra").schema(userschema).option("keyspace", "sunbird").option("table", "user").load();
    val stateUserExternalIdData = spark.read.format("org.apache.spark.sql.cassandra").schema(stateUserSchema).option("keyspace","sunbird").option("table","usr_external_identity").load();

    //Total records upon loading from db
    print_Writer.write("User Table records:"+ userdata.count() );
    print_Writer.write("\nState Users Table records:"+ stateUserExternalIdData.count());

    // Filter out the user records where all of email, phone, username are null.

    val userFilterData = userdata.where(col("username").isNotNull || col("email").isNotNull || col("phone").isNotNull).persist(StorageLevel.MEMORY_ONLY);
    print_Writer.write("\nUser data contains either username, email or phone: "+userFilterData.count());
    val filteredUserData = userFilterData.where(col("rootorgid").isNotNull);
    print_Writer.write("\nValid User data Count : " + filteredUserData.count());

    //Remove records where userid, externalid are null and is not a state users

    val filteredStateUserData =stateUserExternalIdData.where(col("userid").isNotNull && col("externalid").isNotNull && col("idtype").isNotNull && col("provider").isNotNull && col("idtype") === col("provider")).persist(StorageLevel.MEMORY_ONLY);
    print_Writer.write("\nState Users:" +filteredStateUserData.count());

    //Extract email, phone, username user records 

     val emailRecords = filteredUserData.select(col("email"),col("id"),col("rootorgid")).where(col("email").isNotNull);
     val phoneRecords = filteredUserData.select(col("phone"),col("id"),col("rootorgid")).where(col("phone").isNotNull);
     val usernameRecords = filteredUserData.select(col("username"),col("id"),col("rootorgid")).where(col("username").isNotNull);
      

    //Join records

    //Update value as email, phone, username, externalid@orgId

    val stateUserLookupDF = filteredStateUserData.select(col("externalId"),col("userid"),col("provider")).withColumn("type",lit("externalid")).withColumn("value",concat(col("externalid"),lit("@"),col("provider"))).withColumn("userid",col("userid")).select(col("type"),col("value"),col("userid")).where(col("value").isNotNull);

    val emailUserLookupDF = emailRecords.withColumn("type",lit("email")).withColumn("value",col("email")).withColumnRenamed("id","userid").select(col("type"),col("value"),col("userid")).where(col("value").isNotNull);

    val phoneUserLookupDF = phoneRecords.withColumn("type",lit("phone")).withColumn("value",col("phone")).withColumnRenamed("id","userid").select(col("type"),col("value"),col("userid")).where(col("value").isNotNull);

    val usernameUserLookupDF = usernameRecords.withColumn("type",lit("username")).withColumn("value",col("username")).withColumnRenamed("id","userid").select(col("type"),col("value"),col("userid")).where(col("value").isNotNull);


    print_Writer.write("\nEmail Record Count:"+emailUserLookupDF.count());
    print_Writer.write("\nPhone Record Count:"+phoneUserLookupDF.count());
    print_Writer.write("\nUsername Record Count:"+usernameUserLookupDF.count());
    print_Writer.write("\nStat User Record Count:"+stateUserLookupDF.count());


    //Remove Duplication
    val uniqueEmailRecords = emailRecords.dropDuplicates(Seq("email"))
    val uniquePhoneRecords = phoneRecords.dropDuplicates(Seq("phone"))
    val uniqueUsernameRecords = usernameRecords.dropDuplicates(Seq("username"))
    val uniqueExternalIdRecords = filteredStateUserData.dropDuplicates(Seq("externalId"))
    
    print_Writer.write("\nTotal Duplicate Emails: "+(emailRecords.count() - uniqueEmailRecords.count()))
    print_Writer.write("\nTotal Duplicate phone: "+(phoneRecords.count() - uniquePhoneRecords.count()))
    print_Writer.write("\nTotal Duplicate username: "+(usernameRecords.count() - uniqueUsernameRecords.count()))
    print_Writer.write("\nTotal Duplicate externalids: "+(stateUserLookupDF.count() - uniqueExternalIdRecords.count()))


     //Merge records
    val userLookupDF= stateUserLookupDF.union(emailUserLookupDF).union(phoneUserLookupDF).union(usernameUserLookupDF)

    //Save records to the user_lookup table
    print_Writer.write("\nuser_lookup count  migration: " + userLookupDF.count());

    userLookupDF.write.format("org.apache.spark.sql.cassandra").option("keyspace", "sunbird").option("table", "user_lookup").mode(SaveMode.Append).save();
    userFilterData.unpersist();  
    filteredStateUserData.unpersist();
    
    val newTableRecords = spark.read.format("org.apache.spark.sql.cassandra").schema(userLookupschema).option("keyspace", "sunbird").option("table", "user_lookup").load();
    
    print_Writer.write("\nuser_lookup count post migration: " + newTableRecords.count());
    val userLookupWithEmail = newTableRecords.where(col("type") === "email")
    print_Writer.write("\nuser_lookup email count post migration: " + userLookupWithEmail.count());
    val userLookupWithPhone = newTableRecords.where(col("type") === "phone")
    print_Writer.write("\nuser_lookup phone count post migration: " + userLookupWithPhone.count());
    val userLookupWithUsername = newTableRecords.where(col("type") === "username")
    print_Writer.write("\nuser_lookup username count post migration: " + userLookupWithUsername.count());
    val userLookupWithExternalId = newTableRecords.where(col("type") === "externalid")
    print_Writer.write("\nuser_lookup externalid count post migration: " + userLookupWithExternalId.count());
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
Check for Analysis Files created




```
validation_count.txt
```


*****

[[category.storage-team]] 
[[category.confluence]] 
