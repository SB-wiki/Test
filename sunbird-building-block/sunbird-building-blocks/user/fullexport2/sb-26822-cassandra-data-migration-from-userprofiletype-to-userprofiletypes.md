This script will update the userProfileTypes from userProfileType data.




## Steps to run the script:



```
vi UserTypeMigration.scala
copy data from below file and paste it to UserTypeMigration.scala
cd to the spark directory
bin/spark-shell --master local[*] --packages com.datastax.spark:spark-cassandra-connector_2.11:2.5.0
:load {{absolute path of UserTypeMigration.scala}}
UserTypeMigration.main("{cassandra ip}")
```



```
import org.apache.spark.sql.functions.col
import org.apache.spark.sql._
import org.apache.spark.sql.functions._
import org.apache.spark.sql.SparkSession
import org.apache.spark.storage.StorageLevel


case class UserFilter(id: String, profileusertype: String, profileusertypes: String)

object UserTypeMigration extends Serializable {
        
    def main(cassandraIp: String): Unit = {
        implicit val spark: SparkSession =
            SparkSession
                .builder()
                .appName("UserTypeMigration")
                .config("spark.master", "local[*]")
                .config("spark.cassandra.connection.host",cassandraIp)
                .config("spark.cassandra.output.batch.size.rows", "10000")
                .config("spark.cassandra.read.timeoutMS","12000")
                .getOrCreate()
        val res = time(migrateData());
        Console.println("Time taken to execute script", res._1);
        spark.stop();
    }
    
    def migrateData()(implicit spark: SparkSession) {
        import spark.implicits._
        val userschema = Encoders.product[UserFilter].schema

        val userdata = spark.read.format("org.apache.spark.sql.cassandra").schema(userschema).option("keyspace", "sunbird").option("table", "user").load().persist(StorageLevel.MEMORY_ONLY);

        val updatedUserData = userdata.withColumn("profileusertypes", when(col("profileusertype").isNotNull , userProfileTypes(col("profileusertype"))));
            
        updatedUserData.write.format("org.apache.spark.sql.cassandra").option("keyspace", "sunbird").option("table", "user").mode(SaveMode.Append).save();
    }
    
    def userProfileTypesFunction(profileusertype: String): String = {
       "[" + profileusertype +"]"
    }
    
    val userProfileTypes = udf[String, String](userProfileTypesFunction)
    
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
