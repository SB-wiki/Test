Jira ticket: [SB-28196 System JIRA](https:///browse/SB-28196)

release:4.5.0

Context: while user creation we use to map the user to the corresponding root-org id, but there is a issue in recent time where the mapping to user-organisation was missed, so records were missing in the user_organisation table. Now with this script we are adding the missing user-org association to the user_organisation table.


```
vi UserOrgMissingRecords.scala
copy data from below UserOrgMissingRecords.scala file and paste it.
cd to the spark directory
bin/spark-shell --master local[*] --packages com.datastax.spark:spark-cassandra-connector_2.11:2.5.0
:load {{absolute path of UserOrgMissingRecords.scala}}
UserOrgMissingRecords.main(Array("{cassandra ip}","{custodian-org-id}"))
```

```
import java.io.{File, PrintWriter, Serializable}
import java.sql.Timestamp
import java.util.concurrent.atomic.AtomicInteger
import java.util.{Calendar, Random}

import org.apache.spark.sql.functions.udf
import org.apache.spark.sql.{Encoders, SaveMode, SparkSession}
import org.apache.spark.storage.StorageLevel
import org.apache.spark.sql.functions.{col, lit, when, _}

case class UserSchema(userid: String, status: Int, isdeleted: Boolean, rootorgid: String, createddate: String)
case class UserOrganisationSchema(userid: String, organisationid: String)

object UserOrgMissingRecords extends Serializable {
    private val atomicInteger = new AtomicInteger
    private val random = new Random

    def main(args: Array[String]): Unit = {
        implicit val sparkSession: SparkSession = SparkSession.builder().
            appName("UserOrgMissingRecords").
            config("spark.master", "local[*]").
            config("spark.cassandra.connector.host", args(0)).
            config("spark.cassandra.output.batch.size.rows", "10000").
            config("spark.cassandra.read.timeoutMS", "60000").getOrCreate()
        val res = time(missingUserOrgRecords(args(1)))
        Console.println("Time taken to execute script", res._1);
        sparkSession.stop()
    }

    def missingUserOrgRecords(custOrgId: String) (implicit sparkSession: SparkSession) {
        val file = new File("missed_user_org_audit.txt" )
        val print_Writer = new PrintWriter(file)
        val userSchema = Encoders.product[UserSchema].schema
        val userOrgSchema = Encoders.product[UserOrganisationSchema].schema
        val userDF = sparkSession.read.format("org.apache.spark.sql.cassandra").schema(userSchema).option("keyspace", "sunbird").option("table", "user").
            load().persist(StorageLevel.MEMORY_ONLY)
        val userOrgDF = sparkSession.read.format("org.apache.spark.sql.cassandra").schema(userOrgSchema).option("keyspace","sunbird").option("table","user_organisation").
            load().persist(StorageLevel.MEMORY_ONLY)
        //finding out missed user-org associations with join operation b/n user and user-org Dataframes    
        val missedUserIdDF = userDF.join(userOrgDF, userDF.col("userid") === userOrgDF.col("userid") &&  userDF.col("rootorgid") === userOrgDF.col("organisationid"), "leftanti").
            select(userDF.col("userid"), userDF.col("rootorgid").as("organisationid"),  userDF.col("createddate").as("orgjoindate"))
        val missedUserOrgDF = missedUserIdDF.withColumn("associationtype", when(col("organisationid") === lit(custOrgId),lit(2)).otherwise(lit(1))).
            withColumn("hashtagid", col("organisationid")).withColumn("isdeleted",lit(false)).
            withColumn("id", userOrgId()).filter(col("organisationid").isNotNull && col("userid").isNotNull).persist(StorageLevel.MEMORY_ONLY)
        missedUserOrgDF.coalesce(1).write.format("com.databricks.spark.csv").option("header", "true").save("/tmp/misseduserorg/")
        missedUserOrgDF.write.format("org.apache.spark.sql.cassandra").option("keyspace","sunbird").option("table","user_organisation").mode(SaveMode.Append).save()
        print_Writer.write("total number of missing user-org records: "+ missedUserOrgDF.count())
        //missedUserOrgDF.show(10, false)
        val nonCustMissingDF = missedUserOrgDF.filter(col("organisationid") =!= custOrgId)
        nonCustMissingDF.coalesce(1).write.format("com.databricks.spark.csv").option("header", "true").save("/tmp/misseduserorgnoncust/")
        print_Writer.close
    }

    def userOrgIdFunction(): String = {
        val env = (1 + random.nextInt(99999)) / 10000000
        var uid = System.currentTimeMillis + random.nextInt(999999)
        uid = uid << 13
        return env + "" + uid + "" + atomicInteger.getAndIncrement
    }

    val userOrgId = udf[String](userOrgIdFunction)

    def time[R](block: => R): (Long, R) = {
        val t0 = System.currentTimeMillis()
        val result = block // call-by-name
        val t1 = System.currentTimeMillis()
        ((t1 - t0), result)
    }
}
```


Tested with prod data in test-cluster:

time taken: 5.2 min

Output file path: /tmp/misseduserorg/

Output from missed_user_org_audit.txt : total number of missing user-org records: 376253



In Production:

Time taken : 1.44 min

Total number of records : 4,93,065



*****

[[category.storage-team]] 
[[category.confluence]] 
