In this ticket we are adding usertype, usersubstype to profileusertype and locationids to profilelocation columns in the user table.


```
vi UserLocationAndUserTypeMigration.scala
copy data from below UserLocationAndUserTypeMigration.scala file  and paste it to  UserLocationAndUserTypeMigration.scala
cd to the spark directory
bin/spark-shell --master local[*] --packages com.datastax.spark:spark-cassandra-connector_2.11:2.5.0
:load {{absolute path of UserLocationAndUserTypeMigration.scala}}
UserLocationAndUserTypeMigration.main("{cassandra ip}")
```



```scala
import java.io.{File, PrintWriter}
import org.apache.spark.SparkContext
import org.apache.spark.sql.functions.{col}
import org.apache.spark.sql._
import org.apache.spark.sql.functions._
import org.apache.spark.sql.{ SparkSession}

/*
*   UserLocationSubtype: Schema for User table while reading
*   UserProfileLocation:  Schema for User table while updating userprofile location
*   UserType: Schema for user table while updating userprofiletype  
*/

case class UserLocationSubtype(id: String, locationids: Option[List[String]] , usertype: Option[String], usersubtype: Option[String])
case class UserProfileLocation(id: String, profilelocation: Option[String])
case class UserType(id: String, profileusertype: Option[String])
case class UserUpdatedLocationSubtype(id: String, profilelocation: Option[String], profileusertype: Option[String])

object UserLocationAndUserTypeMigration extends Serializable {

  //private val config: Config = ConfigFactory.load

  def main(cassandraIp: String): Unit = {
    implicit val spark: SparkSession =
      SparkSession
        .builder()
        .appName("UserLocationAndUserTypeMigration")
        .config("spark.master", "local[*]")
        .config("spark.cassandra.connection.host",cassandraIp)
        .config("spark.cassandra.output.batch.size.rows", "10000")
        .config("spark.cassandra.output.consistency.level","LOCAL_QUORUM")
        .config("spark.cassandra.input.consistency.level","LOCAL_QUORUM")
        .config("spark.cassandra.read.timeoutMS","12000")
        .getOrCreate()

     
    val res = time(migrateData());

    Console.println("Time taken to execute script", res._1);
    spark.stop();
  }

def migrateData()(implicit spark: SparkSession) {
    
    import spark.implicits._
    
     val userLocationSubtypeSchema = Encoders.product[UserLocationSubtype].schema
     val userdata = spark.read.format("org.apache.spark.sql.cassandra").schema(userLocationSubtypeSchema).option("keyspace", "sunbird").option("table", "user").load();
     //val userDfWithLoc = userdata.where(col("locationids").isNotNull)
      val locationDF = spark.read.format("org.apache.spark.sql.cassandra").option("keyspace", "sunbird").option("table", "location").load().
          select(
              col("id").as("locid"),
              col("code").as("loccode"),
              col("name").as("locname"),
              col("parentid").as("locparentid"),
              col("type").as("loctype")).cache()
      val userDenormDF = userdata.withColumn("exploded_location", explode_outer(col("locationids")))
          .join(locationDF, col("exploded_location") === locationDF.col("locid") && (locationDF.col("loctype") === "cluster" || locationDF.col("loctype") === "block" || locationDF.col("loctype") === "district" || locationDF.col("loctype") === "state"), "left_outer")
      //userDenormDF.show(10, false)
      val userDenormLocationDF = userDenormDF.groupBy("id", "usertype", "usersubtype").pivot("loctype").agg(first("locid").as("locid"))
      //userDenormLocationDF.show(10, false)
       val userProfileTypeDF = userDenormLocationDF.map((row) => {
            var userTypeValue = ""
            val usertype = if(row.getAs[String]("usertype") != null) row.getAs[String]("usertype") else ""
            if(!usertype.isEmpty) {
                userTypeValue += "{\"type\" : \""+usertype+"\""
                val usersubtype = if(row.getAs[String]("usersubtype") != null) row.getAs[String]("usersubtype") else ""
                if(!usersubtype.isEmpty){
                    userTypeValue += ", \"subType\" : \""+usersubtype+"\"}"
                } else {
                    userTypeValue += "}"
                }
            }
            if (!userTypeValue.isEmpty) {
               UserType(row.getAs[String]("id"), Option(userTypeValue))
            } else {
               UserType(row.getAs[String]("id"), null)
            }
        })
      userProfileTypeDF.write.format("org.apache.spark.sql.cassandra").option("keyspace", "sunbird").option("table", "user").mode(SaveMode.Append).save(); 

      val isState = userDenormLocationDF.columns.contains("state")
      val isDistrict = userDenormLocationDF.columns.contains("district")
      val isCluster = userDenormLocationDF.columns.contains("cluster")
      val isblock = userDenormLocationDF.columns.contains("block")
      val userProfileLocationDF = userDenormLocationDF.map(row =>
            {
                var location = "";
                val statevalue = if(isState && row.getAs[String]("state") == null) "" else row.getAs[String]("state");
                if(!statevalue.isEmpty) {
                    location = "{\"type\" : \"state\", \"id\": \""+statevalue+"\"}";
                    val districtvalue = if (isDistrict && row.getAs[String]("district") != null) row.getAs[String]("district") else ""
                    if (!districtvalue.isEmpty) {
                        location += ", {\"type\" : \"district\", \"id\":\""+districtvalue+"\"}";
                        val blockvalue = if(isblock && row.getAs[String]("block") != null) row.getAs[String]("block") else ""
                        if(!blockvalue.isEmpty) {
                            location += ", {\"type\" : \"block\", \"id\":\""+blockvalue+"\"}";
                            val clustervalue = if(isCluster && row.getAs[String]("cluster") != null) row.getAs[String]("cluster") else ""
                            if( !clustervalue.isEmpty) {
                                location += ", {\"type\" : \"cluster\", \"id\":\""+clustervalue+"\"}";
                            }
                        }
                    }
                }
                UserProfileLocation(
                    row.getAs[String]("id"), if(location.isEmpty) null  else Option("["+location+"]"))
            })
      //userProfileTypeDF.show(10, false)
      //userProfileLocationDF.toDF().show(10, false)
      //println(userProfileLocationDF.schema)
      userProfileLocationDF.write.format("org.apache.spark.sql.cassandra").option("keyspace", "sunbird").option("table", "user").mode(SaveMode.Append).save();
      val file = new File("userprofile.txt" )
      val print_Writer = new PrintWriter(file)
      print_Writer.write("\nuser profilelocation updated records count: "+ userProfileLocationDF.count())
      print_Writer.write("\nuser profileusertype updated records count: "+ userProfileTypeDF.count())
      print_Writer.close()
}
  
  def loadData(spark: SparkSession, settings: Map[String, String]): DataFrame = {
    spark
      .read
      .format("org.apache.spark.sql.cassandra")
      .options(settings)
      .load()
  }


  def time[R](block: => R): (Long, R) = {
    val t0 = System.currentTimeMillis()
    val result = block // call-by-name
    val t1 = System.currentTimeMillis()
    ((t1 - t0), result)
  }
}

```


*****

[[category.storage-team]] 
[[category.confluence]] 
