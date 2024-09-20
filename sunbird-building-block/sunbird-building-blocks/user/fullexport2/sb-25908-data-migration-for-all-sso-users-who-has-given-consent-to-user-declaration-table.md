 **release-4.1.0** :

This script will insert missed sso user-declarations entries of the users from user-consent table.

we are doing based on organisation-id.


### Steps to add sso user-declarations of user-consent:



```
vi ConsentIssue.scala
copy data from below ConsentIssue.scala file  and paste it to  ConsentIssue.scala
cd to the spark directory
bin/spark-shell --master local[*] --packages com.datastax.spark:spark-cassandra-connector_2.11:2.5.0
:load {{absolute path of ConsentIssue.scala}}
ConsentIssue.main("{cassandra ip}")
```


Replace the organisation-id before running the script


```
import org.apache.spark.sql.functions.{col, _}
import org.apache.spark.sql.{Encoders, SaveMode, SparkSession}
import org.apache.spark.storage.StorageLevel
import java.io.File
import java.io.PrintWriter
 
import scala.collection.immutable.HashMap
 
case class UserDeclarations(userid: String, orgid: String, persona: String)
case class UserConsent(user_id: String, consumer_id: String, object_id: String, object_type: String)
case class UserExternalIdentity(userid: String, idtype: String, provider: String, originalprovider: String, originalexternalid: String)
 
object ConsentIssue extends Serializable {
     
    def main(cassandra: String): Unit = {
        implicit val spark: SparkSession =
            SparkSession
                .builder()
                .appName("Audit")
                .config("spark.master", "local[*]")
                .config("spark.cassandra.connection.host", cassandra)
                .config("spark.cassandra.output.batch.size.rows", "10000")
                .config("spark.cassandra.read.timeoutMS", "60000")
                .getOrCreate()
         
        val res = time(saveConsentToDeclaredTable());
         
        Console.println("Time taken to execute script", res._1);
        spark.stop();
    }
     
    def saveConsentToDeclaredTable()(implicit spark: SparkSession) {
         
        val file = new File("userdeclaration_audit_count.txt")
        val print_Writer = new PrintWriter(file)
         
        //User external identity
        val userExtIdSchema = Encoders.product[UserExternalIdentity].schema
        val userExtIdData = spark.read.format("org.apache.spark.sql.cassandra").schema(userExtIdSchema).option("keyspace", "sunbird").option("table", "usr_external_identity").load().persist(StorageLevel.MEMORY_ONLY)
         
        print_Writer.write("\nUser External Identity Records Count " + userExtIdData.count())
         
        //User consent
        val userConsentSchema = Encoders.product[UserConsent].schema
        val userConsentData = spark.read.format("org.apache.spark.sql.cassandra").schema(userConsentSchema).option("keyspace", "sunbird").option("table", "user_consent").load().persist(StorageLevel.MEMORY_ONLY);
        print_Writer.write("\nUser Consent Table Row Count: " + userConsentData.count());
         
        //User Declarations
        val userDeclarationsSchema = Encoders.product[UserDeclarations].schema
        val userDeclarationsData = spark.read.format("org.apache.spark.sql.cassandra").schema(userDeclarationsSchema).option("keyspace", "sunbird").option("table", "user_declarations").load().persist(StorageLevel.MEMORY_ONLY);
     
        val userDeclarationsDefaultPersona = userDeclarationsData.where(col("persona").isNotNull)
        //userDeclarationsDefaultPersona.show(10,false)
        print_Writer.write("\nUser Declarations Records Count With persona is not empty: " + userDeclarationsDefaultPersona.count())
        val userConsentFilteredDF = userConsentData.filter(col("object_type") =!= "Collection")
        val userConsentMissingDf = userConsentFilteredDF.join(userDeclarationsDefaultPersona, userConsentFilteredDF.col("user_id") === userDeclarationsDefaultPersona.col("userid")
            && userConsentFilteredDF.col("consumer_id") === userDeclarationsDefaultPersona.col("orgid")
            && userConsentFilteredDF.col("object_id") === userDeclarationsDefaultPersona.col("orgid"), "leftanti")
        //userConsentMissingDf.show(10,false)
        print_Writer.write("\nUser consent DF with new records count: " + userConsentMissingDf.count())
        val userConsentWithExternalId = userConsentMissingDf.join(userExtIdData, userConsentMissingDf.col("user_id") === userExtIdData.col("userid")
            && userConsentMissingDf.col("consumer_id") === userExtIdData.col("provider"), "left_outer").
            select(userConsentMissingDf.col("*"), userExtIdData.col("originalexternalid"))
        val userDeclaratedDF = userConsentWithExternalId.withColumn("userinfo", userInfoMap(col("originalexternalid"))).withColumn("persona", lit("default"))
        //userDeclaratedDF.show(10,false)
        val finaluserDeclaratedDF = userDeclaratedDF.select(col ("user_id").as("userid"),
            col("consumer_id").as("orgid"),
            col("persona"),
            col("userinfo"))
        //finaluserDeclaratedDF.show(10,false)
        finaluserDeclaratedDF.write.format("org.apache.spark.sql.cassandra").option("keyspace", "sunbird").option("table", "user_declarations").mode(SaveMode.Append).save();
        val globalUserConsent = userConsentData.where(col("object_type") === "global")
        val organisationUserConsent = globalUserConsent.withColumn("object_type", lit("Organisation"))
        organisationUserConsent.write.format("org.apache.spark.sql.cassandra").option("keyspace", "sunbird").option("table", "user_consent").mode(SaveMode.Append).save();
        print_Writer.write("\nUser consent object_type value updating to organisation count: " + organisationUserConsent.count())
        print_Writer.close()
        userConsentWithExternalId.coalesce(1).write.format("com.databricks.spark.csv").option("header", "true").save("/tmp/ssouserconsent")
    }
     
    def userInfoMapFunction(originalexternalid: String): Map[String, String] = {
        var userInfo = new HashMap[String, String]()
        if (originalexternalid != null && !originalexternalid.isEmpty) {
            userInfo += ("declared-ext-id" ->  originalexternalid)
            userInfo
        } else userInfo
    }
     
    val userInfoMap = udf[Map[String, String], String](userInfoMapFunction)
     
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
