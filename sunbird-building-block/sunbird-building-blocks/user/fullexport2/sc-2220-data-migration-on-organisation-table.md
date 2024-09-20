In this ticket we are doing the following data migration on the organisation table


* Data migration to update isRootOrg flag to istenant flag


* Data migration to update org type


* Data migration to restructure location ids in organisation table

    




```
vi OrgLocationAndOrgTypeMigration.scala
copy data from below OrgLocationAndOrgTypeMigration.scala file  and paste it to  OrgLocationAndOrgTypeMigration.scala
cd to the spark directory
bin/spark-shell --master local[*] --packages com.datastax.spark:spark-cassandra-connector_2.11:2.5.0 com.databricks:spark-csv_2.10:1.4.0
:load {{absolute path of OrgLocationAndOrgTypeMigration.scala}}
OrgLocationAndOrgTypeMigration.main("{cassandra ip}")
```

```scala
import java.io.{File, PrintWriter}

import org.apache.spark.SparkContext
import org.apache.spark.sql.{_}
import org.apache.spark.sql.functions._
import org.apache.spark.sql.{ SparkSession}

/*
*   Organisation: Schema for User table
*   OrgWithLocations:  Schema for organisation table
*   OrgProfileLocation: Schema for saving to organisation table   
*/

case class OrgWithLocations(id: String, locationids: Option[List[String]] , isrootorg: Boolean, channel: String)
case class OrgProfileLocation(id: String, orglocation: Option[String], istenant: Boolean, organisationtype: Int)

object OrgLocationAndOrgTypeMigration extends Serializable {

  //private val config: Config = ConfigFactory.load

  def main(cassandraId: String): Unit = {
    implicit val spark: SparkSession =
      SparkSession
        .builder()
        .appName("OrgLocationAndOrgTypeMigration")
        .config("spark.master", "local[*]")
        .config("spark.cassandra.connection.host",cassandraId)
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
    
    val orgWithLocationsSchema = Encoders.product[OrgWithLocations].schema
    
      var orgdata = spark.read.format("org.apache.spark.sql.cassandra").schema(orgWithLocationsSchema).option("keyspace", "sunbird").option("table", "organisation").load();
      //orgdata = orgdata.where(col("id").isin("0125544230477578242096", "01255443508084736022181"))
      //orgdata = orgdata.filter(col("channel") === "tn")
      val locationDF = spark.read.format("org.apache.spark.sql.cassandra").option("keyspace", "sunbird").option("table", "location").load().
          select(
              col("id").as("locid"),
              col("code").as("loccode"),
              col("name").as("locname"),
              col("parentid").as("locparentid"),
              col("type").as("loctype")).cache()
      val orgDenormDF = orgdata.withColumn("exploded_location", explode_outer(col("locationids")))
          .join(locationDF, col("exploded_location") === locationDF.col("locid") && (locationDF.col("loctype") === "cluster" || locationDF.col("loctype") === "block" || locationDF.col("loctype") === "district" || locationDF.col("loctype") === "state"), "left_outer")
      //orgDenormDF.show(10, false)
      val orgDenormLocationDF = orgDenormDF.groupBy("id", "isrootorg" ).pivot("loctype").agg(first("locid").as("locid"))
      //orgDenormLocationDF.show(10, false)
  
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
                row.getAs[String](0), if(location.isEmpty) null else Option("["+location+"]"),
                istenant, orgtype)
        })
      //orgProfile.show(10, false)
      val file = new File("orglocation.txt" )
      val print_Writer = new PrintWriter(file)
      orgProfile.write.format("org.apache.spark.sql.cassandra").option("keyspace", "sunbird").option("table", "organisation").mode(SaveMode.Append).save();
      print_Writer.write("\nOrganisation Table Row Count after Update: "+ orgProfile.count())
      //printing updated orgs to csv
      orgProfile.coalesce(1).write.format("com.databricks.spark.csv").option("header", "true").save("/tmp/orglocationmigratedinfo")
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


 **Verification of migration script data:** 

After migrating both user and organisation scripts, we are creating script for verifying the data:


```
vi UserOrgMigrationDataCheck.scala
copy data from below UserOrgMigrationDataCheck.scala file  and paste it to  OrgLocationAndOrgTypeMigration.scala
cd to the spark directory
bin/spark-shell --master local[*] --packages com.datastax.spark:spark-cassandra-connector_2.11:2.5.0
:load {{absolute path of UserOrgMigrationDataCheck.scala}}
UserOrgMigrationDataCheck.main("{cassandra ip}")
```



```scala
import java.io.{File, PrintWriter}

import org.apache.spark.SparkContext
import org.apache.spark.sql.{_}
import org.apache.spark.sql.functions._
import org.apache.spark.sql.{ SparkSession}

/*
*   UserUpdatedLocationSubtype: Schema for User table
*   OrgUpdatedDTO:  Schema for organisation table 
*/

case class UserUpdatedLocationSubtype(id: String, profilelocation: String, profileusertype: String, usertype: String, locationids: List[String])
case class OrgUpdatedDTO(id: String, orglocation: String, istenant: Boolean, isrootorg: Boolean, locationids: List[String], organisationtype: Int)

object UserOrgMigrationDataCheck extends Serializable {

  //private val config: Config = ConfigFactory.load

  def main(cassandraId: String): Unit = {
    implicit val spark: SparkSession =
      SparkSession
        .builder()
        .appName("UserOrgMigrationDataCheck")
        .config("spark.master", "local[*]")
        .config("spark.cassandra.connection.host",cassandraId)
        .config("spark.cassandra.output.batch.size.rows", "10000")
        .config("spark.cassandra.output.consistency.level","LOCAL_QUORUM")
        .config("spark.cassandra.input.consistency.level","LOCAL_QUORUM")
        .config("spark.cassandra.read.timeoutMS","12000")
        .getOrCreate()

     
    val res = time(verifyMigratedData());

    Console.println("Time taken to execute script", res._1);
    spark.stop();
  }

def verifyMigratedData()(implicit spark: SparkSession) {
    
    import spark.implicits._
    
    val userUpdatedLocationSubtypeSchema = Encoders.product[UserUpdatedLocationSubtype].schema
    var userFinalDF = spark.read.format("org.apache.spark.sql.cassandra").schema(userUpdatedLocationSubtypeSchema).option("keyspace", "sunbird").option("table", "user").load();
    userFinalDF = userFinalDF.filter(col("id").isin("3150aa06-333e-4d6d-8d81-3d8e14e7b245", "6d8269de-c6ca-4106-9b63-305382d46175"))
    val userfile = new File("userupdateddetails.txt" )
    val user_print_Writer = new PrintWriter(userfile)
    val profileLocationDf = userFinalDF.where(col("profilelocation").isNull and size(col("locationids")) > 0)
    val profileUserTypenDf = userFinalDF.where(col("profileusertype")==="" and col("usertype").isNotNull)
    user_print_Writer.write("\nuser locations count where locationids present but profilelocation is null: "+profileLocationDf.count)
    user_print_Writer.write("\nuser locations count where usertype present but profileusertype is empty: "+profileUserTypenDf.count)
    user_print_Writer.close()

    val orgUpdatedSchema = Encoders.product[OrgUpdatedDTO].schema
    val orgFinalDF = spark.read.format("org.apache.spark.sql.cassandra").schema(orgUpdatedSchema).option("keyspace", "sunbird").option("table", "organisation").load();
    val orgfile = new File("orgupdateddetails.txt" )
    val org_print_Writer = new PrintWriter(orgfile)
    val orgNullLocation = orgFinalDF.where(col("orglocation").isNull and size(col("locationids")) > 0)
    val orgIsTenantMismatch = orgFinalDF.where(col("istenant") === false and col("isrootorg") === true)
    val organisationTypeMismatch = orgFinalDF.where(col("isrootorg") === true and col("organisationtype") === 2)
    org_print_Writer.write("\norg locations count where locationids present and orglocation is null: "+orgNullLocation.count)
    org_print_Writer.write("\norg isrootorg is true where istenant is false count: "+orgIsTenantMismatch.count)
    org_print_Writer.write("\norg isrootorg is true where organisationtype is school count: "+organisationTypeMismatch.count)
    org_print_Writer.close()
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
