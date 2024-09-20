Creating a spark script for removing users associated to UP related schools from user_organisation tables.

Before running the script create a csv with “organisationid.csv” with organisationid as header and provide the organisation-id's as values, for examples provided below.




```
vi UserOrgIssue.scala
copy data from below UserOrgIssue.scala file  and paste it to  UserOrgIssue.scala
cd to the spark directory
bin/spark-shell --master local[*] --packages com.datastax.spark:spark-cassandra-connector_2.11:2.5.0
:load {{absolute path of UserOrgIssue.scala}}
UserOrgIssue.main("{cassandra ip}")
```

```
import org.apache.spark.sql.functions.{col, _}
import org.apache.spark.sql.{ Encoders, SparkSession}
import org.apache.spark.storage.StorageLevel
import java.io.File
import java.io.PrintWriter

import com.datastax.spark.connector.cql.{CassandraConnector}

case class UserOrganisations(userid: String, organisationid: String);

object UserOrgIssue extends Serializable {

    def main(cassandra: String): Unit = {
        implicit val spark: SparkSession =
            SparkSession
                .builder()
                .appName("UserOrgIssue")
                .config("spark.master", "local[*]")
                .config("spark.cassandra.connection.host", cassandra)
                .config("spark.cassandra.output.batch.size.rows", "10000")
                .config("spark.cassandra.read.timeoutMS", "60000")
                .getOrCreate()

        val res = time(checkUserDeclarationsRecords());

        Console.println("Time taken to execute script", res._1);
        spark.stop();
    }

    def checkUserDeclarationsRecords()(implicit spark: SparkSession) {
        import spark.implicits._
        val sparkContext = spark.sparkContext
        val cassandraConnector = CassandraConnector.apply(sparkContext.getConf)
        val orgIdDF = spark.read.format("com.databricks.spark.csv").option("header","true")load("/home/harip/organisationid.csv");
        //orgIdDF.show(10,false)
        val orgSet = orgIdDF.select("organisationids").collect().map(_(0)).toSeq
        print_Writer.write("set:::"+orgSet)
        val userOrganisationsSchema = Encoders.product[UserOrganisations].schema
        val userOrgDF = spark.read.format("org.apache.spark.sql.cassandra").schema(userOrganisationsSchema).option("keyspace", "sunbird").option("table", "user_organisation").load().persist(StorageLevel.MEMORY_ONLY)
        //userOrgDF.show(10,false)
        val filteredUserOrgDF = userOrgDF.filter(col("organisationid").isin(orgSet:_*));
        //filteredUserOrgDF.show(10,false)
        filteredUserOrgDF.coalesce(1).write.format("com.databricks.spark.csv").option("header", "true").save("/tmp/userorganisationinfo")
	
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
