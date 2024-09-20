Release: 4.4.0

SB-ticket: [https://project-sunbird.atlassian.net/browse/SB-26424](https://project-sunbird.atlassian.net/browse/SB-26424)

For sso-users the external-id in user-declarations is properly aligned according to usr_external_identity entries

Consent status to be updated for custodian users with missing entries in user_consent table(which are present in user_declarations)

In this script we are correcting the user_consent data.

Recently release-4.4.0 we done design changes to user_consent table, now at organisation level user can revoke consent, so according existing data for sso and custodain users who have multiple and wrong data in user_consent are modified accordingly.

The below script deals with sso users details for correcting right externalid in the user_declaration which is matching from usr_external_identity entries


```
vi SSOUserDeclarationUpdate.scala
copy data from below SSOUserDeclarationUpdate.scala file  and paste it to  SSOUserDeclarationUpdate.scala
cd to the spark directory
bin/spark-shell --master local[*] --driver-memory 100g --packages com.datastax.spark:spark-cassandra-connector_2.11:2.5.0
:load {{absolute path of SSOUserDeclarationUpdate.scala}}
SSOUserDeclarationUpdate.main("{cassandra ip}");
```

```
import org.apache.spark.sql.functions.{col, _}
import org.apache.spark.sql.{Encoders, SaveMode, SparkSession}
import org.apache.spark.storage.StorageLevel
import java.io.File
import java.io.PrintWriter
import java.sql.Timestamp
import java.util.{Calendar}

import scala.collection.immutable.HashMap

case class UserConsent(user_id: String, consumer_id: String, object_id: String, consumer_type: String, object_type: String, status: String)
case class UserExtIdt(userid: String, idtype: String, provider: String, originalexternalid: String, originalidtype: String)
case class SelfDeclaredUser(userid: String, orgid: String, persona: String,
                            status: String, userinfo: Map[String, String])
object SSOUserDeclarationUpdate extends Serializable {
    
    def main(cassandraIp: String): Unit = {
        implicit val spark: SparkSession =
            SparkSession
                .builder()
                .appName("SSOUserDeclarationUpdate")
                .config("spark.master", "local[*]")
                .config("spark.cassandra.connection.host", cassandraIp)
                .config("spark.cassandra.output.batch.size.rows", "10000")
                .config("spark.cassandra.read.timeoutMS", "60000")
                .getOrCreate()
        
        val res = time(updateSSODeclExternalId());
        
        Console.println("Time taken to execute script", res._1);
        spark.stop();
    }
    
    def updateSSODeclExternalId()(implicit spark: SparkSession) {
        val sparkContext = spark.sparkContext
        val file = new File("ssouserdeclextidupdation_audit.txt")
        val print_Writer = new PrintWriter(file)
        val userConsentSchema = Encoders.product[UserConsent].schema
        val userExtIdtSchema = Encoders.product[UserExtIdt].schema
        val selfDeclaredUserSchema = Encoders.product[SelfDeclaredUser].schema
        //user-consent table data frame
        val userConsentDF = spark.read.format("org.apache.spark.sql.cassandra").schema(userConsentSchema).option("keyspace", "sunbird").option("table", "user_consent").load().persist(StorageLevel.MEMORY_ONLY).where(lower(col("object_type")) === "organisation" && lower(col("status")) === "active")
        print_Writer.write("\n users with active status and object_type as org count =" + userConsentDF.count())
        //usr_external_identity table data frame
        val userExtIdtDF = spark.read.format("org.apache.spark.sql.cassandra").schema(userExtIdtSchema).option("keyspace", "sunbird").option("table", "usr_external_identity").load().persist(StorageLevel.MEMORY_ONLY)
        //user_declarations table data frame
        val userDeclarationtDF = spark.read.format("org.apache.spark.sql.cassandra").schema(selfDeclaredUserSchema).option("keyspace", "sunbird").option("table", "user_declarations").load().persist(StorageLevel.MEMORY_ONLY).
            select(col("userid"), col("orgid"), col("userinfo"), col("userinfo").getItem("declared-ext-id").as("declared-ext-id"), col("persona")).na.fill("",Array("declared-ext-id"))
        //getting dataframe which contains user details after joining usr_external_identity and user_consent tables
        val ssoUserConsentDF = userExtIdtDF.join(userConsentDF, userExtIdtDF.col("userid") === userConsentDF.col("user_id") && userExtIdtDF.col("provider") === userConsentDF.col("object_id"), "inner").
            select(userConsentDF.col("*"), userExtIdtDF.col("originalexternalid"))
        print_Writer.write("\n ssoUserConsent user data count =" + ssoUserConsentDF.count())
        //filtering out users where external-id is mismatching with user_declaration table user data
        val userUnMatchingExternalIDDF = ssoUserConsentDF.join(userDeclarationtDF, ssoUserConsentDF.col("user_id") === userDeclarationtDF.col("userid") && ssoUserConsentDF.col("object_id") === userDeclarationtDF.col("orgid") &&
            ssoUserConsentDF.col("originalexternalid") =!= userDeclarationtDF.col("declared-ext-id"), "inner").
            select(userDeclarationtDF.col("*"), ssoUserConsentDF.col("originalexternalid"))
        userUnMatchingExternalIDDF.show(10, false)
        print_Writer.write("\n userUnMatchingExternalIDDF data count =" + userUnMatchingExternalIDDF.count())
        val finalSSODeclaredDF = userUnMatchingExternalIDDF.withColumn("userinfo", updateUserInfo(col("userinfo"), col("originalexternalid"))).
            withColumn("updatedon", updateDateTimestamp()).
            select(col("userid"), col("orgid"), col("persona"), col("userinfo"), col("updatedon")).persist(StorageLevel.MEMORY_ONLY)
        finalSSODeclaredDF.show(10, false)
        val finalSSODeclaredDFCSV = finalSSODeclaredDF.select(col("userid"), col("orgid"), col("persona"), col("userinfo").getItem("declared-ext-id").as("declared-ext-id"))
        finalSSODeclaredDFCSV.coalesce(1).write.format("com.databricks.spark.csv").option("header", "true").save("/tmp/SSOUserDeclarationExtIdUpdation")
        finalSSODeclaredDF.write.format("org.apache.spark.sql.cassandra").option("keyspace", "sunbird").option("table", "user_declarations").mode(SaveMode.Append).save();
        
        //for finding usr_external_identity which containes "declarated" key entries
        val filterDeclaredDF = userExtIdtDF.filter(col("originalidtype").contains("declared"))
        val filterUserDecDF = filterDeclaredDF.dropDuplicates("userid")
        print_Writer.write("\n usr_external table with declared count =" + filterUserDecDF.count())
        filterUserDecDF.coalesce(1).write.format("com.databricks.spark.csv").option("header", "true").save("/tmp/ExtIdDeclaredRecords")
        
        print_Writer.close
    }
    
    def updateDateTimestampFunction(): Timestamp = {
        val declUpdateDate = new Timestamp(Calendar.getInstance.getTime.getTime)
        declUpdateDate
    }
    val updateDateTimestamp = udf[Timestamp](updateDateTimestampFunction)
    
    def time[R](block: => R): (Long, R) = {
        val t0 = System.currentTimeMillis()
        val result = block // call-by-name
        val t1 = System.currentTimeMillis()
        ((t1 - t0), result)
    }
    
    def updateUserInfoFunction(oldUserInfo: Map[String, String], originalExternalId: String): Map[String, String] = {
        var userInfo = new HashMap[String, String]()
        oldUserInfo.foreach(keyValue =>
            if(keyValue._1.equals("declared-ext-id")) {
                userInfo += ("declared-ext-id" -> originalExternalId)
            } else {
                userInfo += (keyValue._1 -> keyValue._2)
            })
        if(!userInfo.contains("declared-ext-id")) {
            userInfo += ("declared-ext-id" -> originalExternalId)
        }
        return userInfo
    }
    
    val updateUserInfo = udf[Map[String, String], Map[String, String], String](updateUserInfoFunction)
}
```
Tested the above in test-cluster with prod-data

Time taken to run this script: 138130 ms

Total number of  entries updated into user_declaration: 70554



This below script deals with custodian users for revoking invalid consent entries and inserting proper details based on user_declaration data.


```
vi UserConsentRevokeUpdate.scala
copy data from below UserConsentRevokeUpdate.scala file  and paste it to  UserConsentRevokeUpdate.scala
cd to the spark directory
bin/spark-shell --master local[*] --driver-memory 100g --packages com.datastax.spark:spark-cassandra-connector_2.11:2.5.0
:load {{absolute path of UserConsentRevokeUpdate.scala}}
UserConsentRevokeUpdate.main(Array("{cassandra ip}","{custodian-orgid}"));
```

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
        print_Writer.write("\n filtered active-users that are already revocked  =" + inserActiveCheckWithExistRecokedDF.count())
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
Tested the above in test-cluster with prod-data

Time taken to run this script: 11736175 ms

Total number of new entries made into user_consent: 341436



Note: Tested the prod-data in test-cluster environment with ram capacity 120g and allocated spark-driver memory -100g

The machine took almost around 127.3222 minutes to execute the script.



*****

[[category.storage-team]] 
[[category.confluence]] 
