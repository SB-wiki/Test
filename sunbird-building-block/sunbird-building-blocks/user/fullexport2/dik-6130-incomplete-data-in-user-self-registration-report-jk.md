Release: 4.4.0

Ticket: [https://project-diksha.atlassian.net/browse/DIK-6130a](https://project-diksha.atlassian.net/browse/DIK-6130a)

In this script we are correcting the org consent data. Consent status to be updated to ACTIVE for users with missing entries in user_consent table(which are present in user_declarations). Consent status to be updated to REVOKED for users which has ACTIVE consent entry, but missing user_declarations entry.

From release-4.4.0, we are considering 2 tables user_declaration and user_consent in report generation, also checking the consent status is ACTIVE or not. 

Due to some gap in UI implementation, data was inserted only to user_declaration. So those records are not shown in report now. We are running this migration to correct those records. 

So if ACTIVE consent is existing and no matching user_declaration , the script will revoke consent. And if user_declaration is existing, but no consent, then script will add new entry in consent table.


```
vi UserConsentRevokeUpdate.scala
copy data from below UserConsentRevokeUpdate.scala file  and paste it to  UserConsentRevokeUpdate.scala
cd to the spark directory
bin/spark-shell --master local[*] --driver-memory 100g --packages com.datastax.spark:spark-cassandra-connector_2.11:2.5.0
:load {{absolute path of UserConsentRevokeUpdate.scala}}
UserConsentRevokeUpdate.main(Array("{cassandra ip}","{custodian-orgid}"));
```
Get the custodian-orgid value from system_settings table:

select \* from sunbird.systemsettings where id='custodianRootOrgId';


```
import org.apache.spark.sql.functions.{col, _}
import org.apache.spark.sql.{Encoders, SaveMode, SparkSession}
import org.apache.spark.storage.StorageLevel
import java.io.File
import java.io.PrintWriter
import java.sql.Timestamp
import java.util.{Calendar, Date}

import org.apache.spark.sql.expressions.Window

case class UserConsent(user_id: String, consumer_id: String, object_id: String, consumer_type: String, object_type: String, status: String)
case class SelfDeclaredUser(userid: String, orgid: String, persona: String,
                            status: String, userinfo: Map[String, String])
object UserConsentRevokeUpdate extends Serializable {

    def main(args: Array[String]): Unit = {
        implicit val spark: SparkSession =
            SparkSession
                .builder()
                .appName("UserConsentRevokeUpdate")
                .config("spark.master", "local[*]")
                .config("spark.cassandra.connection.host", args(0))
                .config("spark.cassandra.output.batch.size.rows", "10000")
                .config("spark.cassandra.read.timeoutMS", "60000")
                .getOrCreate()

        val res = time(checkUserConsentRecords(args(1)));

        Console.println("Time taken to execute script", res._1);
        spark.stop();
    }

    def checkUserConsentRecords(custOrgId: String)(implicit spark: SparkSession) {
        import spark.implicits._
        val sparkContext = spark.sparkContext
        val file = new File("custuserorgconsent_audit.txt")
        val print_Writer = new PrintWriter(file)
        val userConsentSchema = Encoders.product[UserConsent].schema
        val selfDeclaredUserSchema = Encoders.product[SelfDeclaredUser].schema
        //user-consent table data frame
	 val userConsentDF = spark.read.format("org.apache.spark.sql.cassandra").schema(userConsentSchema).option("keyspace", "sunbird").option("table", "user_consent").load().persist(StorageLevel.MEMORY_ONLY).where(lower(col("object_type")) === "organisation")
        val userActiveConsentDF = userConsentDF.where(lower(col("status")) === "active")
        print_Writer.write("\n users with active status and object_type as org count =" + userActiveConsentDF.count())
        //user_declarations table data frame
        val userDeclarationtDF = spark.read.format("org.apache.spark.sql.cassandra").schema(selfDeclaredUserSchema).option("keyspace", "sunbird").option("table", "user_declarations").load().persist(StorageLevel.MEMORY_ONLY).
            select(col("userid"), col("orgid"))


        //filtering out custodian-orgid from user-declaration df
        val userDeclarationNonCustDF = userDeclarationtDF.filter(col("orgid") =!= custOrgId)
        //filtering out custodian-orgid from user_consent df
        val userConsentNonCustDF = userActiveConsentDF.filter(col("object_id") =!= custOrgId)
        //filtering out duplicate orgid wrto personas
        val userDeclNonCustDropDupOrgIdDF = userDeclarationNonCustDF.dropDuplicates("userid","orgid")
        //remove common declaration and consent entry
        val commonUserOrgDF = userConsentNonCustDF.join(userDeclNonCustDropDupOrgIdDF, userConsentNonCustDF.col("user_id") === userDeclNonCustDropDupOrgIdDF.col("userid") &&
            userConsentNonCustDF.col("object_id") === userDeclNonCustDropDupOrgIdDF.col("orgid"), "inner").
            select("userid", "orgid")
        print_Writer.write("\n users entries common in both tables count =" + commonUserOrgDF.count())

        val userConsentSelectedColDF = userConsentNonCustDF.select("user_id", "object_id", "consumer_id")
        val revokedUserDF = userConsentSelectedColDF.except(commonUserOrgDF.select(col("userid").as("user_id"), col("orgid").as("object_id"), col("orgid").as("consumer_id")))
        val finalRevokedUserDF = revokedUserDF.withColumn("status", lit("REVOKED")).
            withColumn("last_updated_on", createConsentDate())
        finalRevokedUserDF.coalesce(1).write.format("com.databricks.spark.csv").option("header", "true").save("/tmp/UserRevokedStatus")
        finalRevokedUserDF.write.format("org.apache.spark.sql.cassandra").option("keyspace","sunbird").option("table","user_consent").mode(SaveMode.Append).save()
        print_Writer.write("\n userconsent count that are revoked =" + finalRevokedUserDF.count())

        val userDeclarationSelectedColDF = userDeclNonCustDropDupOrgIdDF.select(col("userid"), col("orgid"))
        val insertActiveUserDF = userDeclarationSelectedColDF.except(commonUserOrgDF)
        val finalInsertUserActiveDF = insertActiveUserDF.select(col("userid").as("user_id"), col("orgid").as("object_id"), col("orgid").as("consumer_id"))
        .withColumn("status", lit("ACTIVE")).withColumn("object_type", lit("Organisation")).withColumn("consumer_type",lit("ORGANISATION")).
            withColumn("id", updateConsentId(col("user_id"),col("object_id"))).withColumn("created_on", createConsentDate()).
            withColumn("expiry", createExpirtDate())
	val userRevokedConsentDF = userConsentDF.where(lower(col("status")) === "revoked")
        val inserActiveCheckWithExistRecokedDF = finalInsertUserActiveDF.join(userRevokedConsentDF, finalInsertUserActiveDF.col("user_id") === userRevokedConsentDF.col("user_id") &&
            finalInsertUserActiveDF.col("object_id") === userRevokedConsentDF.col("object_id"), "inner").
            select(finalInsertUserActiveDF.col("*"))
        print_Writer.write("\n filtered active-users that are already revoked  =" + inserActiveCheckWithExistRecokedDF.count())
        val activeConsentDF = finalInsertUserActiveDF.except(inserActiveCheckWithExistRecokedDF)

        activeConsentDF.coalesce(1).write.format("com.databricks.spark.csv").option("header", "true").save("/tmp/InsertUserConsent")
	activeConsentDF.write.format("org.apache.spark.sql.cassandra").option("keyspace","sunbird").option("table","user_consent").mode(SaveMode.Append).save()
        print_Writer.write("\n final active-user consent count =" + activeConsentDF.count())
	print_Writer.close
    }

    def updateConsentIdFunction(userid: String, orgId: String): String = {
        val consentId = "usr-consent:"+userid+":"+orgId+":"+orgId
        consentId
    }

    val updateConsentId = udf[String, String, String](updateConsentIdFunction)

    def consentCreateDateFunction(): Timestamp = {
        val consentDate = new Timestamp(Calendar.getInstance.getTime.getTime)
        consentDate
    }
    val createConsentDate = udf[Timestamp](consentCreateDateFunction)

    def createExpirtDateFunction(): Timestamp = {
        val consentExpiryId = Calendar.getInstance
        consentExpiryId.setTime(new Date)
        // manipulate date
        consentExpiryId.add(Calendar.DATE, 100)
        // convert calendar to date
        new Timestamp(consentExpiryId.getTime.getTime)
    }
    val createExpirtDate = udf[Timestamp](createExpirtDateFunction)

    def time[R](block: => R): (Long, R) = {
        val t0 = System.currentTimeMillis()
        val result = block // call-by-name
        val t1 = System.currentTimeMillis()
        ((t1 - t0), result)
    }
}
```
Time taken to run this script without saving to DB: 2.63578333 minutes



Output from pre-prod with test cluster custuserorgconsent_audit file:

users with active status and object_type as org count =4181271

users entries common in both tables count =3291384

userconsent count that are revoked =14985

filtered active-users that are already revoked  =8

final active-user consent count =1428661



Output from pre-prod cluster custuserorgconsent_audit file:


```
 users with active status and object_type as org count =1461
 users entries common in both tables count =1350
 userconsent count that are revoked =62
 filtered active-users that are already revoked  =14
 final active-user consent count =3725
```


Output from pre-prod test cluster dry run with prod-data:

Time taken to run the script 4.21898333 minutes


```
users with active status and object_type as org count =4323976
 users entries common in both tables count =3433763
 userconsent count that are revoked =13260
 filtered active-users that are already revoked  =12
 final active-user consent count =1398523
```
 **Note** : After running the script please save the below paths to secure azure blob

paths: /tmp/InsertUserConsent/tmp/UserRevokedStatus





*****

[[category.storage-team]] 
[[category.confluence]] 
