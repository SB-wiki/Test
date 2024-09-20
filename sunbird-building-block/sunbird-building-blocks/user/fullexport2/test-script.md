Test script for checking csv output.


```
vi OrgLocationAndOrgTypeMigration.scala
copy data from below OrgLocationAndOrgTypeMigration.scala file  and paste it to  OrgLocationAndOrgTypeMigration.scala
cd to the spark directory
bin/spark-shell --master local[*] --packages com.datastax.spark:spark-cassandra-connector_2.11:2.5.0 com.databricks:spark-csv_2.10:1.4.0
:load {{absolute path of OrgLocationAndOrgTypeMigration.scala}}
OrgLocationAndOrgTypeMigration.main("{cassandra ip}")
```



```
import java.io.{File, PrintWriter}
import org.apache.spark.SparkContext
import org.apache.spark.sql._
import org.apache.spark.sql.functions._
import org.apache.spark.sql.SparkSession
import org.apache.spark.storage.StorageLevel
/*
*   Organisation: Schema for User table
*   OrgWithLocations:  Schema for organisation table
*   OrgProfileLocation: Schema for saving to organisation table   
*/
case class OrgWithLocations(id: String, locationids: List[String], isrootorg: Boolean, channel: String)
case class OrgProfileLocation(id: String, orglocation: String, istenant: Boolean, organisationtype: Int)
case class OrgUpdatedWithLocations(id: String, orglocation: String)
object OrgLocationAndOrgTypeMigration extends Serializable {
  //private val config: Config = ConfigFactory.load
  def main(cassandraId: String): Unit = {
    implicit val spark: SparkSession =
      SparkSession
        .builder()
        .appName("OrgLocationAndOrgTypeMigration")
        .config("spark.master", "local[1]")
        .config("spark.cassandra.connection.host",cassandraId)
        .config("spark.cassandra.output.batch.size.rows", "10000")
        //.config("spark.cassandra.output.consistency.level","LOCAL_ONE")
        //.config("spark.cassandra.input.consistency.level","LOCAL_ONE")
        .config("spark.cassandra.read.timeoutMS","12000")
        .getOrCreate()
    val res = time(migrateData());
    Console.println("Time taken to execute script", res._1);
    spark.stop();
  }
def migrateData()(implicit spark: SparkSession) {
    import spark.implicits._
    val orgWithLocationsSchema = Encoders.product[OrgWithLocations].schema
      var orgdata = spark.read.format("org.apache.spark.sql.cassandra").schema(orgWithLocationsSchema).option("keyspace", "sunbird").option("table", "organisation").load().persist(StorageLevel.MEMORY_ONLY);
      val locationDF = spark.read.format("org.apache.spark.sql.cassandra").option("keyspace", "sunbird").option("table", "location").load().
          select(
              col("id").as("locid"),
              col("code").as("loccode"),
              col("name").as("locname"),
              col("parentid").as("locparentid"),
              col("type").as("loctype")).cache()
      val orgDenormDF = orgdata.withColumn("exploded_location", explode_outer(col("locationids")))
          .join(locationDF, col("exploded_location") === locationDF.col("locid") && (locationDF.col("loctype") === "cluster" || locationDF.col("loctype") === "block" || locationDF.col("loctype") === "district" || locationDF.col("loctype") === "state"), "left_outer")
      val orgDenormLocationDF = orgDenormDF.groupBy("id", "isrootorg").pivot("loctype").agg(first("locid").as("locid"))
      val isState = orgDenormLocationDF.columns.contains("state")
      val isDistrict = orgDenormLocationDF.columns.contains("district")
      val isBlock = orgDenormLocationDF.columns.contains("block")
      val isCluster = orgDenormLocationDF.columns.contains("cluster")
      val orgProfile = orgDenormLocationDF.map((row) => {
            var location = "";
            val state = if(isState && row.getAs[String]("state") != null) row.getAs[String]("state") else ""
            if(!state.isEmpty) {
                location = "{\"type\" : \"state\", \"id\": \""+state+"\"}";
                val district = if (isDistrict && row.getAs[String]("district") != null) row.getAs[String]("district") else ""
                if (!district.isEmpty) {
                    location += ", {\"type\" : \"district\", \"id\":\""+district+"\"}";
                    val block = if(isBlock && row.getAs[String]("block") != null) row.getAs[String]("block") else ""
                    if(!block.isEmpty) {
                        location += ", {\"type\" : \"block\", \"id\":\""+block+"\"}";
                        val cluster = if(isCluster && row.getAs[String]("cluster") != null) row.getAs[String]("cluster") else ""
                        if(!cluster.isEmpty) {
                            location += ", {\"type\" : \"cluster\", \"id\":\""+cluster+"\"}";
                        }
                    }
                }
            }
            val istenant = row.getAs[Boolean]("isrootorg")
            val orgtype = if(!istenant) 2 else 5
            OrgProfileLocation(
                row.getAs[String](0), if(location.isEmpty) ""  else "["+location+"]",
                istenant, orgtype)
        })
      val joinedData = orgdata.select(col("id").as("orgid"), col("locationids"))
        .withColumn("locationids", col("locationids").cast("string"))
        .join(orgProfile, col("orgid") === orgProfile.col("id"), "inner")
      joinedData.coalesce(1).write.format("com.databricks.spark.csv")
        .option("header", "true").save("/home/analytics/haritesting")
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
