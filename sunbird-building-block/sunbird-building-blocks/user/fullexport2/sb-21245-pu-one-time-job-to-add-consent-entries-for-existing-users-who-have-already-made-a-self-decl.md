# SB-21245-PU---One-time-job-to-add-consent-entries-for-existing-users-who-have-already-made-a-self-de

As a part of the task [SB-21245](https://project-sunbird.atlassian.net/browse/SB-21245), following steps need to be executed on the requirement basis.

### Steps for data Migration from user\_declarations to **user\_consent**

1. Bring down the learner service
2. Count the number of records in user\_declarations and user\_consent, post running the job the records should be of equal count.
3. If spark is available, login to spark machine. Else, download spark from [here](https://www.apache.org/dyn/closer.lua/spark/spark-3.0.0/spark-3.0.0-bin-hadoop2.7.tgz), to the preferred instance.
4. validate data count in respective table
5. Job printing the total records before and after the migration.

Follow the below mentioned steps for data migration:

```
vi SelfDeclarationToConsentMigration.scala 
copy data from below SelfDeclarationToConsentMigration.scala file  and paste it to  SelfDeclarationToConsentMigration.scala
cd to the spark directory
bin/spark-shell --master local[*] --packages com.datastax.spark:spark-cassandra-connector_2.11:2.5.0
:load {{absolute path of SelfDeclarationToConsentMigration.scala}}
SelfDeclarationToConsentMigration.main("{cassandra ip}")
```

&#x20;

```scala
import com.typesafe.config.{Config, ConfigFactory}
import org.apache.spark.sql.functions._
import org.apache.spark.sql.{DataFrame, SaveMode, SparkSession}
import org.apache.spark.storage.StorageLevel

object SelfDeclarationToConsentMigration extends Serializable {
    private val config: Config = ConfigFactory.load

    def main(cassandraIp: String): Unit = {
        implicit val spark: SparkSession =
            SparkSession
                .builder()
                .appName("SelfDeclarationToConsentMigration")
                .config("spark.master", "local[*]")
                .config("spark.cassandra.connection.host", cassandraIp)
                .config("spark.cassandra.output.batch.size.rows", "5000")
                .config("spark.cassandra.read.timeoutMS", "6000")
                .getOrCreate()
        val res = time(migrateSelfDeclaredToConsent());
        Console.println("Time taken to execute script", res._1);
        spark.stop();
    }

    def migrateSelfDeclaredToConsent()(implicit spark: SparkSession): Unit = {
        val userConsentdDF = spark.read.format("org.apache.spark.sql.cassandra").option("keyspace", "sunbird").option("table", "user_consent").load().persist(StorageLevel.MEMORY_ONLY)
        val userConsentObjectTypedDF = userConsentdDF.where(col("object_type").isin("global", "Organisation")).persist(StorageLevel.MEMORY_ONLY)
        println("user_consent data Count : " + userConsentObjectTypedDF.count())
        val userDeclaredDF = spark.read.format("org.apache.spark.sql.cassandra").option("keyspace", "sunbird").option("table", "user_declarations").load().persist(StorageLevel.MEMORY_ONLY)
        println("user_declarations data Count : " + userDeclaredDF.count())
        val userDeclaredWithOutConstentDtlDF = userDeclaredDF.join(userConsentdDF, userDeclaredDF.col("userid") === userConsentObjectTypedDF.col("user_id"), "leftanti").persist();
        println("userDeclaredDF after join latest data Count : " + userDeclaredWithOutConstentDtlDF.count())
        val savedConsentDF = convertSelfDeclaredToConsentDF(userDeclaredWithOutConstentDtlDF)
        println("user_consent data inserted Count : " + savedConsentDF.count())
    }
    
    def convertSelfDeclaredToConsentDF(userDeclaredWithOutConstentDtlDF: DataFrame): DataFrame = {
        val savedConsentDF = userDeclaredWithOutConstentDtlDF.select(col("userid").as("user_id"),col("orgid").as("consumer_id"),col("orgid").as("object_id"),
            col("createdon").as("created_on"),
            col("updatedon").as("last_updated_on")).
            withColumn("consumer_type", lit("ORGANISATION")).
            withColumn("object_type", lit("Organisation")).
            withColumn("id", concat_ws(":", lit("usr-consent"), col("user_id"),col("consumer_id"), col("consumer_id"))).
            withColumn("status", lit("ACTIVE")).
            withColumn("expiry", date_format(from_utc_timestamp(date_add(col("created_on"), 100), "Asia/Kolkata"), "yyyy-MM-dd'T'HH:mm:ss'Z'"))
        savedConsentDF.write.format("org.apache.spark.sql.cassandra").option("keyspace", "sunbird").option("table", "user_consent").
            mode(SaveMode.Append).save()
        savedConsentDF
    }

    def time[R](block: => R): (Long, R) = {
        val t0 = System.currentTimeMillis()
        val result = block
        val t1 = System.currentTimeMillis()
        ((t1 - t0), result)
    }
}    
```

**Prod-data in pre-prod test env execution output samples:**

![](<../../../../User/Fullexport2/images/storage/Screenshot 2021-01-22 at 8.51.06 PM.png>) ![](<../../../../User/Fullexport2/images/storage/Screenshot 2021-01-22 at 8.52.40 PM.png>) ![](<../../../../User/Fullexport2/images/storage/Screenshot 2021-01-22 at 8.52.02 PM.png>) ![](<../../../../User/Fullexport2/images/storage/Screenshot 2021-01-22 at 8.50.34 PM.png>)

***

\[\[category.storage-team]] \[\[category.confluence]]
