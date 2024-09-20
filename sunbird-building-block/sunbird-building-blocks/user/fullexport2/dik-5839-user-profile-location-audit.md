Before running the script create a csv with “userIds.csv” with id as header and provide the user-id's as values. And update the location of this file in below script at line number 31.



Steps to run


```
vi UserProfileLocationAudit.scala
copy data from below UserProfileLocationAudit.scala file and paste it.
cd to the spark directory
bin/spark-shell --master local[*] --packages com.datastax.spark:spark-cassandra-connector_2.11:2.5.0
:load {{absolute path of UserProfileLocationAudit.scala}}
UserProfileLocationAudit.main("{cassandra ip}")
```



```
import org.apache.spark.sql.functions.{col, _}
import org.apache.spark.sql.{Encoders, SparkSession}
import org.apache.spark.storage.StorageLevel
import com.datastax.spark.connector.cql.CassandraConnector

case class UserProfile(id: String, profilelocation: String);

object UserProfileLocationAudit extends Serializable {
    
    def main(cassandra: String): Unit = {
        implicit val spark: SparkSession =
            SparkSession
                .builder()
                .appName("UserProfileLocationAudit")
                .config("spark.master", "local[*]")
                .config("spark.cassandra.connection.host", cassandra)
                .config("spark.cassandra.output.batch.size.rows", "10000")
                .config("spark.cassandra.read.timeoutMS", "60000")
                .getOrCreate()
        
        val res = time(checkUserRecords());
        
        Console.println("Time taken to execute script", res._1);
        spark.stop();
    }
    
    def checkUserRecords()(implicit spark: SparkSession) {
        import spark.implicits._
        val sparkContext = spark.sparkContext
        val cassandraConnector = CassandraConnector.apply(sparkContext.getConf)
        val userIdDF = spark.read.format("com.databricks.spark.csv").option("header","true").load("/Users/amit/userIds.csv");
        val userSet = userIdDF.select("id").collect().map(_(0)).toSeq
        val userSchema = Encoders.product[UserProfile].schema
        val userDF = spark.read.format("org.apache.spark.sql.cassandra").schema(userSchema).option("keyspace", "sunbird").option("table", "user").load().persist(StorageLevel.MEMORY_ONLY)
        val filteredUserDF = userDF.filter(col("id").isin(userSet:_*));
        val filteredUserDFWithProfileLocation = filteredUserDF.where(col("profilelocation").isNotNull || col("profilelocation") =!= "")
        filteredUserDFWithProfileLocation.coalesce(1).write.format("com.databricks.spark.csv").option("header", "true").save("audit_active_parent_user_having_profilelocation.csv")
        
        filteredUserDF.coalesce(1).write.format("com.databricks.spark.csv").option("header", "true").save("complete_user_data_from_csv")
        
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
