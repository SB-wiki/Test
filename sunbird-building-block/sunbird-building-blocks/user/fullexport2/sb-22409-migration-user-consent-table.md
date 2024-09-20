As discussed organisation level consent needs to updates ‘Organisation’ from ‘global’.




```
vi ConsentMigration.scala
copy data from below ConsentMigration.scala file  and paste it to  ConsentMigration.scala
cd to the spark directory
bin/spark-shell --master local[*] --packages com.datastax.spark:spark-cassandra-connector_2.11:2.5.0
:load {{absolute path of ConsentMigration.scala}}
ConsentMigration.main("{cassandra ip}")
```

```
import com.typesafe.config.{Config, ConfigFactory}
import org.apache.spark.sql.functions._
import org.apache.spark.sql.{DataFrame, SaveMode, SparkSession}
import org.apache.spark.storage.StorageLevel
import java.io.File 
import java.io.PrintWriter 
object ConsentMigration extends Serializable {
    def main(cassandra:String): Unit = {
        implicit val spark: SparkSession =
            SparkSession
                .builder()
                .appName("ConsentMigration")
                .config("spark.master", "local[*]")
                .config("spark.cassandra.connection.host",cassandra )
                .config("spark.cassandra.output.batch.size.rows", "10000")
                .config("spark.cassandra.read.timeoutMS", "60000")
                .getOrCreate()
        val res = time(updateConsentObjectTypeInConsent());
        Console.println("Time taken to execute script", res._1);
        spark.stop();
    }
    def updateConsentObjectType(userConsentdDF: DataFrame) : Unit = {	
        val objectTypeUpdateddDF = userConsentdDF.withColumn("object_type", when(col("object_type") === "global", "Organisation").otherwise(col("object_type")))
        objectTypeUpdateddDF.write.format("org.apache.spark.sql.cassandra").option("keyspace", "sunbird").option("table", "user_consent").mode(SaveMode.Append).save()
    }
    def updateConsentObjectTypeInConsent()(implicit spark: SparkSession): Unit = {
 	val file = new File("consent_validation_count.txt" ) 
    	val print_Writer = new PrintWriter(file)
        val userConsentdDF = spark.read.format("org.apache.spark.sql.cassandra").option("keyspace", "sunbird").option("table", "user_consent").load().persist(StorageLevel.MEMORY_ONLY)
    	print_Writer.write("\nConsent Table Row Count Before Update: "+ userConsentdDF.count() )
	val globalConsentDF = userConsentdDF.filter(col("object_type") === "global")
    	print_Writer.write("\nConsent Table Row Count Contains 'global': "+ globalConsentDF.count() )
        updateConsentObjectType(userConsentdDF);
        val userConsentdDFUpdated = spark.read.format("org.apache.spark.sql.cassandra").option("keyspace", "sunbird").option("table", "user_consent").load().persist(StorageLevel.MEMORY_ONLY)
        print_Writer.write("\nConsent Table Row Count After Update : " + userConsentdDFUpdated.count())
        print_Writer.close()

    }
    def time[R](block: => R): (Long, R) = {
        val t0 = System.currentTimeMillis()
        val result = block
        val t1 = System.currentTimeMillis()
        ((t1 - t0), result)
    }
}
```
Logs will be available in the path: /mount/data/analytics/spark-2.4.4-bin-hadoop2.7/consent_validation_count.txt

Dev Details are: 

Consent Table Row Count Before Update: 110

Consent Table Row Count Contains 'global': 43

Consent Table Row Count After Update : 110

Dev Logs:



Staging Details:

(Time taken to execute script,28930)

Consent Table Row Count Before Update: 1463

Consent Table Row Count Contains 'global': 217

Consent Table Row Count After Update : 1463



*****

[[category.storage-team]] 
[[category.confluence]] 
