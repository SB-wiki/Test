
## Overview
User Org data is always read based on userId , orgId and isDeleted which all are secondary indexed column in cassandra , which causing cpu usage spike on high load.

To reduce the cassandra cpu usage , we restructured the user org table to use userId as partition key and organisationId as cluster key.

Note: we created new table user_organisation with same column set in user_org.


### Old user_org table schema:



```
CREATE TABLE sunbird.user_org (
    id text PRIMARY KEY,
    addedby text,
    addedbyname text,
    approvaldate text,
    approvedby text,
    hashtagid text,
    isapproved boolean,
    isdeleted boolean,
    isrejected boolean,
    organisationid text,
    orgjoindate text,
    orgleftdate text,
    position text,
    roles list<text>,
    updatedby text,
    updateddate text,
    userid text
)
```



### New user_organisation schema:



```
CREATE TABLE sunbird.user_organisation (
    userid text,
    organisationid text,
    addedby text,
    addedbyname text,
    approvaldate text,
    approvedby text,
    hashtagid text,
    id text,
    isapproved boolean,
    isdeleted boolean,
    isrejected boolean,
    orgjoindate text,
    orgleftdate text,
    position text,
    roles list<text>,
    updatedby text,
    updateddate text,
    PRIMARY KEY (userid, organisationid)
) WITH CLUSTERING ORDER BY (organisationid ASC)
```



## Steps for data Migration from user_org table to user_organisation table



1. Run the cassandra migration job to create user_organisation table.


1. check for table in cassandra by running query :  **desc sunbird.user_organisation** 


1. bring down sunbird-lms-service 


1. validate data count in user_org table


1. If spark is available, login to spark machine. Else, download spark from [here](https://www.apache.org/dyn/closer.lua/spark/spark-3.0.0/spark-3.0.0-bin-hadoop2.7.tgz), to the preferred instance.



Follow the below mentioned steps for data migration.




```
vi UserOrgDataMigration.scala 
copy data from below UserOrgDataMigration.scala file  and paste it to  UserOrgDataMigration.scala
cd to the spark directory
bin/spark-shell --master local[*] --packages com.datastax.spark:spark-cassandra-connector_2.11:2.5.0
:load {{absolute path of UserOrgDataMigration.scala}}
UserOrgDataMigration.main("{{cassandra_host}}:{{cassandra_port}}")
```







```
UserOrgDataMigration.scala


import org.apache.spark.sql.functions.{col, _}
import org.apache.spark.sql.{ SparkSession }
import org.apache.spark.sql.Encoders
import org.apache.spark.sql.SaveMode
import org.apache.spark.storage.StorageLevel
import org.apache.spark.sql.functions.{array_distinct, flatten}
import org.apache.spark.sql.expressions.Window

case class UserOrganisation(userid: String, organisationid: String, addedby: Option[String], addedbyname: Option[String], approvaldate: Option[String],
                            approvedby: Option[String], hashtagid: Option[String], id: String, isapproved: Option[Boolean], isdeleted: Option[Boolean],
                            isrejected: Option[Boolean], orgjoindate: Option[String], orgleftdate: Option[String], position: Option[String],
                            roles: List[String], updatedby: Option[String], updateddate: Option[String])

object UserOrgDataMigration extends Serializable {
  def main(cassandraHost: String): Unit = {
    implicit val spark: SparkSession =
      SparkSession
        .builder()
        .appName("UserOrgDataMigration")
        .config("spark.master", "local[*]")
        .config("spark.cassandra.connection.host", cassandraHost)
        .config("spark.cassandra.output.batch.size.rows", "10000")
        .config("spark.cassandra.read.timeoutMS", "60000")
        .getOrCreate()
    val res = time(migrateData());
    Console.println("Time taken to execute script", res._1);
    spark.stop();
  }

def migrateData()(implicit spark: SparkSession) {
    val schema = Encoders.product[UserOrganisation].schema
    val data = spark.read.format("org.apache.spark.sql.cassandra").schema(schema).option("keyspace", "sunbird").option("table", "user_org").load();
    val filteredData = data.where(col("userid").isNotNull && col("organisationid").isNotNull).persist(StorageLevel.MEMORY_ONLY)
    println("user_org data Count : " + filteredData.count());
    val distinctRecords = filteredData.dropDuplicates("userid", "organisationid").persist();
    val dupRecords = filteredData.except(distinctRecords).select(col("userid"),col("organisationid"),col("roles")).persist(StorageLevel.MEMORY_ONLY);
    val distinctRecordsWithRoles = distinctRecords.select(col("userid"),col("organisationid"),col("roles"));
    val distinctRoleDF = distinctRecordsWithRoles.join(dupRecords, distinctRecordsWithRoles("userid") === dupRecords("userid") && distinctRecordsWithRoles("organisationid") === dupRecords("organisationid"), "leftsemi");
    val rolesDF = dupRecords.union(distinctRoleDF).withColumn("role", explode(col("roles"))).groupBy("userid","organisationid").agg(collect_set("role").as("roles"));
    distinctRecords.write.format("org.apache.spark.sql.cassandra").option("keyspace", "sunbird").option("table", "user_organisation").mode(SaveMode.Append).save()
    rolesDF.write.format("org.apache.spark.sql.cassandra").option("keyspace", "sunbird").option("table", "user_organisation").mode(SaveMode.Append).save()
    val newTableRecords = spark.read.format("org.apache.spark.sql.cassandra").schema(schema).option("keyspace", "sunbird").option("table", "user_organisation").load().count();
    println("user_organistaion count post migration: " + newTableRecords)
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
