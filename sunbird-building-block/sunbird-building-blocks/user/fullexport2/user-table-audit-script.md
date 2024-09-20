OverviewThe purpose of this script to find the below details:


* Duplicate counts - email, phone, username


* Display which two users collide on this - createdOn, updatedOn timestamps can help which is active - not always correct, but gives a rough idea


* usernames blank is not expected at all


* How many users are in non-custodian org, but are not marked 'stateValidated' (true)? What are their details?



Steps to run:


```
vi UserAudit.scala
copy data from below UserAudit.scala file  and paste it to  UserAudit.scala
cd to the spark directory
bin/spark-shell --master local[*] --packages com.datastax.spark:spark-cassandra-connector_2.11:2.5.0
:load {{absolute path of UserAudit.scala}}
UserAudit.main("{cassandra ip}")
```



```scala
import com.typesafe.config.{Config, ConfigFactory}
import org.apache.spark.sql.Row
import org.apache.spark.sql.functions.{col, _}
import org.apache.spark.sql.{ DataFrame, SparkSession }
import org.apache.spark.sql.Encoders
import org.apache.spark.sql.SaveMode
import org.apache.spark.storage.StorageLevel
import org.apache.spark.sql.functions.{array_distinct, flatten}
import org.apache.spark.sql.expressions.Window
import org.apache.spark.rdd.RDD
import org.apache.spark.SparkConf
import org.apache.spark.SparkContext
import org.apache.spark.SparkContext._
import org.apache.spark.broadcast.Broadcast
import org.apache.spark.sql.functions.typedLit
import org.apache.spark.sql.Column
import java.io.File 
import java.io.PrintWriter 


case class User(id: String, accesscode: String, avatar: String, channel: String, countrycode: String, createdby: String, createddate: String, dob: String, email: String, emailverified:Boolean, firstname:String, flagsvalue: Int, gender: String,  isdeleted: Boolean, lastname: String, location: String, loginid:String, phone:String,phoneverified:Boolean,prevusedemail:String, prevusedphone:String,provider:String,recoveryemail:String, recoveryphone:String, rootorgid:String,status:Int,updatedby:String, updateddate:String,username:String, usertype:String)

object UserAudit extends Serializable {

 

  def main(cassandra: String): Unit = {
    implicit val spark: SparkSession =
      SparkSession
        .builder()
        .appName("UserAudit")
        .config("spark.master", "local[*]")
        .config("spark.cassandra.connection.host",cassandra)
        .config("spark.cassandra.output.batch.size.rows", "10000")
        .config("spark.cassandra.read.timeoutMS","60000")
        .getOrCreate()


    val res = time(auditData());

    Console.println("Time taken to execute script", res._1);
    spark.stop();
  }

def auditData()(implicit spark: SparkSession) {
   
    val file = new File("audit_count.txt" ) 
    val print_Writer = new PrintWriter(file)
    
    val userschema = Encoders.product[User].schema
    val userdata = spark.read.format("org.apache.spark.sql.cassandra").schema(userschema).option("keyspace", "sunbird").option("table", "user").load().persist(StorageLevel.MEMORY_ONLY);
  
    //Total records upon loading from db
    print_Writer.write("User Table Row Count: "+ userdata.count() );
    //Active  status = 0 and Inactive Users status =1 
    val activeUserData = userdata.where(col("status") === 1 && !col("isdeleted"))
    
    print_Writer.write("\nActive User Records: "+activeUserData.count())
    
    print_Writer.write("\nInActive User Records: "+ (userdata.count() - activeUserData.count()))
    //Extract email, phone, username user records 
    val userWithEmailId = userdata.where(col("email").isNotNull);
    val userWithPhone = userdata.where(col("phone").isNotNull);
 
    val userWithOnlyEmailId = userdata.where(col("email").isNotNull && col("phone").isNull);
    val userWithOnlyPhone = userdata.where(col("phone").isNotNull && col("email").isNull);
    val userWithUsername = userdata.where(col("username").isNotNull);
    val userWithEmailAndPhone = userdata.where(col("email").isNotNull && col("phone").isNotNull);
    
    print_Writer.write("\nUsers with Only EMAIL ID: "+ userWithOnlyEmailId.count() );
    print_Writer.write("\nUsers with Only Mobile No: "+ userWithOnlyPhone.count() );
    print_Writer.write("\nUsers with UserName: "+ userWithUsername.count() );
    print_Writer.write("\nUsers with Both Email and Phone: "+ userWithEmailAndPhone.count() );
   
    //User Without email, phone and username records
    val userWithoutEmailId = userdata.where(col("email").isNull && col("phone").isNull && col("prevusedemail").isNull);
    val userWithoutPhone = userdata.where(col("phone").isNull && col("email").isNull  && col("prevusedphone").isNull);
    val userWithoutUsername = userdata.where(col("username").isNull);

    print_Writer.write("\nUsers without EMAIL ID: "+ userWithoutEmailId.count() );
    print_Writer.write("\nUsers without Mobile No.: "+ userWithoutPhone.count() );
    print_Writer.write("\nUsers without UserName: "+ userWithoutUsername.count() );
    
    //find active and inactive in above records
    val activeUserWithoutEmailId = userWithoutEmailId.where(col("status") ===1 && !col("isdeleted"));
    val activeUserWithoutPhone = userWithoutPhone.where(col("status")===1 && !col("isdeleted"));
    val activeUserWithoutUsername = userWithoutUsername.where(col("status")===1 && !col("isdeleted"));
   
    print_Writer.write("\nActive Users without EMAIL ID: "+ activeUserWithoutEmailId.count());
    print_Writer.write("\nActive Users without Mobile No.: "+ activeUserWithoutPhone.count());
    print_Writer.write("\nActive Users without username.: "+ activeUserWithoutUsername.count());

    print_Writer.write("\nInActive Users without EMAIL ID: "+ (userWithoutEmailId.count()-activeUserWithoutEmailId.count()));
    print_Writer.write("\nInActive Users without Mobile No.: "+(userWithoutPhone.count() -activeUserWithoutPhone.count()));
   print_Writer.write("\nInActive Users without Username.: "+(userWithoutUsername.count() -activeUserWithoutUsername.count()));

    //Unique Records
    val uniqueEmailRecords = userWithEmailId.dropDuplicates(Seq("email"))
    val uniquePhoneRecords = userWithPhone.dropDuplicates(Seq("phone"))
    val uniqueUserNameRecords = userWithUsername.dropDuplicates(Seq("username"))

    print_Writer.write("\nUser With EMAIL ID: "+ userWithEmailId.count() );
    print_Writer.write("\nUser With Mobile No.: "+ userWithPhone.count() );
    print_Writer.write("\nUnique EMAIL ID: "+ uniqueEmailRecords.count() );
    print_Writer.write("\nUnique Mobile No.: "+ uniquePhoneRecords.count() );
    print_Writer.write("\nUnique UserName: "+ uniqueUserNameRecords.count() );
    
    
    // Duplicate records
    val duplicateEmailRecords = userWithEmailId.except(uniqueEmailRecords)
    val duplicatePhoneRecords = userWithPhone.except(uniquePhoneRecords)
    val duplicateUserNameRecords = userWithUsername.except(uniqueUserNameRecords)

    print_Writer.write("\nDuplicate EMAIL ID: "+ duplicateEmailRecords.count() );
    print_Writer.write("\nDuplicate Mobile No.: "+ duplicatePhoneRecords.count() );
    print_Writer.write("\nDuplicate UserName: "+ duplicateUserNameRecords.count() );
    
    
    //SB-20446 Issue: non-custodian org, but are not marked 'stateValidated' (true)

    val custodianOrgId = getCustodianOrgId();
    val tenantUser = userdata.where(col("rootorgid").isNotNull && !col("rootorgid").contains(custodianOrgId) && col("flagsvalue").isNotNull)
    val stateNonVerifiedData = tenantUser.where(col("flagsvalue") < 4)
    print_Writer.write("\nTotal SB-20446 Issue Impacted User: "+stateNonVerifiedData.count())
    stateNonVerifiedData.coalesce(1).write.format("com.databricks.spark.csv").option("header", "true").save("non_custodian_state_validated.csv")
        
    //Save duplicate Records
    activeUserWithoutEmailId.coalesce(1).write.format("com.databricks.spark.csv").option("header", "true").save("audit_active_user_without_email.csv")
    activeUserWithoutPhone.coalesce(1).write.format("com.databricks.spark.csv").option("header", "true").save("audit_active_user_without_phone.csv")
    userWithoutUsername.coalesce(1).write.format("com.databricks.spark.csv").option("header", "true").save("audit_active_user_without_username.csv")

    duplicateEmailRecords.coalesce(1).write.format("com.databricks.spark.csv").option("header", "true").save("audit_duplicate_email.csv")
    duplicatePhoneRecords.coalesce(1).write.format("com.databricks.spark.csv").option("header", "true").save("audit_duplicate_phone.csv")
    duplicateUserNameRecords.coalesce(1).write.format("com.databricks.spark.csv").option("header", "true").save("audit_duplicate_username.csv")
    userWithoutUsername.coalesce(1).write.format("com.databricks.spark.csv").option("header", "true").save("audit_users_without_username.csv")
    print_Writer.close()     
  }


  def getCustodianOrgId() (implicit sparkSession: SparkSession): String = {
        val systemSettingDF = loadData(sparkSession, Map("table" -> "system_settings", "keyspace" -> "sunbird")).where(col("id") === "custodianOrgId" && col("field") === "custodianOrgId")
        systemSettingDF.select(col("value")).persist().select("value").first().getString(0)
  }

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
Check for files audit_\*.txt or audit_\*.csv for analysis.



SB-21007 : Self declared User Issue Audit Scripts


```
import com.typesafe.config.{Config, ConfigFactory}
import org.apache.spark.sql.Row
import org.apache.spark.sql.functions.{col, _}
import org.apache.spark.sql.{ DataFrame, SparkSession }
import org.apache.spark.sql.Encoders
import org.apache.spark.sql.SaveMode
import org.apache.spark.storage.StorageLevel
import org.apache.spark.sql.functions.{array_distinct, flatten}
import org.apache.spark.sql.expressions.Window
import org.apache.spark.rdd.RDD
import org.apache.spark.SparkConf
import org.apache.spark.SparkContext
import org.apache.spark.SparkContext._
import org.apache.spark.broadcast.Broadcast
import org.apache.spark.sql.functions.typedLit
import org.apache.spark.sql.Column
import java.io.File 
import java.io.PrintWriter 


case class User(id: String, accesscode: String, avatar: String, channel: String, countrycode: String, createdby: String, createddate: String, dob: String, email: String, emailverified:Boolean, firstname:String, flagsvalue: Int, gender: String,  isdeleted: Boolean, lastname: String, location: String,locationids:List[String], loginid:String, phone:String,phoneverified:Boolean,prevusedemail:String, prevusedphone:String,provider:String,recoveryemail:String, recoveryphone:String, rootorgid:String,status:Int,updatedby:String, updateddate:String,username:String, usertype:String)

case class UserSelfDeclared(userid: String, orgid: String, persona: String, errortype: String,
                            status: String, userinfo: Map[String, String])


object UserAudit extends Serializable {

 

  def main(cassandra: String): Unit = {
    implicit val spark: SparkSession =
      SparkSession
        .builder()
        .appName("UserAudit")
        .config("spark.master", "local[*]")
        .config("spark.cassandra.connection.host",cassandra)
        .config("spark.cassandra.output.batch.size.rows", "10000")
        .config("spark.cassandra.read.timeoutMS","60000")
        .getOrCreate()


    val res = time(auditData());

    Console.println("Time taken to execute script", res._1);
    spark.stop();
  }

def auditData()(implicit spark: SparkSession) {
   
    val file = new File("audit_count.txt" ) 
    val print_Writer = new PrintWriter(file)
    
    val userschema = Encoders.product[User].schema
    val userSelfDeclaredEncoder = Encoders.product[UserSelfDeclared].schema

    var userdata = spark.read.format("org.apache.spark.sql.cassandra").schema(userschema).option("keyspace", "sunbird").option("table", "user").load().persist(StorageLevel.MEMORY_ONLY);
    var userSelfDeclaredDataDF = spark.read.format("org.apache.spark.sql.cassandra").schema(userSelfDeclaredEncoder).option("keyspace", "sunbird").option("table", "user_declarations").load().persist(StorageLevel.MEMORY_ONLY);

    userSelfDeclaredDataDF = userSelfDeclaredDataDF.select(col("userinfo").getItem("declared-email").as("declared-email"), col("userinfo").getItem("declared-phone").as("declared-phone"),
            col("userinfo").getItem("declared-school-name").as("declared-school-name"), col("userinfo").getItem("declared-school-udise-code").as("declared-school-udise-code"),col("userinfo").getItem("declared-ext-id").as("declared-ext-id"), col("status").as("declared_status"), col("userid").as("id")).drop("userinfo");

    //Count of User whose declaration status is validated and district is empty

    val user1 =  userdata.join(userSelfDeclaredDataDF,userdata.col("id").equalTo(userSelfDeclaredDataDF("id")));
    val user11 = user1.where(col("declared_status") === "VALIDATED" && size(col("locationids")) === 1)
    print_Writer.write("\ncount of district empty for declaration status is  VALIDATED (users): "+user11.count())

    //Count of User whose declaration status is pending and distric is empty

     val user12 = user1.where(col("declared_status") === "PENDING" && size(col("locationids")) === 1)
     print_Writer.write("\ncount of district empty for declaration status is PENDING (users): "+user12.count())

    //Count of User whose declaration status is null and district is empty
    val user13 = user1.where(col("declared_status").isNull && size(col("locationids")) === 1)
     print_Writer.write("\ncount of district empty for declaration is NULL status (users): "+user13.count())

    //Count of state empty and district empty for declaration validated users
    val user14 = user1.where(col("declared_status") === "VALIDATED" && (col("locationids").isNull || size(col("locationids")) === 0))
    print_Writer.write("\ncount of state empty and district empty for declaration is validated (users): "+user14.count())

    //Count of state empty and district for declarations is PENDING users
    val user15 = user1.where(col("declared_status") === "PENDING" && (col("locationids").isNull || size(col("locationids")) === 0))
    print_Writer.write("\ncount of state empty and district empty for declaration is PENDING (users): "+user15.count())

    //Count of state empty and district for declarations is NULL users
    val user16 = user1.where(col("declared_status").isNull && (col("locationids").isNull || size(col("locationids")) === 0))
    print_Writer.write("\ncount of state empty and district empty for declaration status is NULL (users): "+user16.count())
    
   //count of district empty for declaration empty users, ie, no link in user_declaration table
    val user2 = userdata.join(userSelfDeclaredDataDF, Seq("id"),"left_anti")
    val user21 = user2.where(size(col("locationids")) === 1)
    print_Writer.write("\ncount of district empty for declaration empty users, ie, no link in user_declaration table: "+user21.count())

   //count of state empty and district empty for declaration empty users, ie, no link in user_declaration table
    val user22 = user2.where(col("locationids").isNull || size(col("locationids")) === 0);
    print_Writer.write("\ncount of state empty and district empty for declaration empty users, ie, no link in user_declaration table: "+user22.count())

    //phone empty records for declaration validated users     
    val user31 = userSelfDeclaredDataDF.where(col("declared_status") === "VALIDATED" && !notNullAndEmpty(col("declared-phone")))
    print_Writer.write("\nphone empty records for declaration status is validated (users): "+user31.count())

   //phone empty records for  declaration status is NULL  users  	
    val user32 = userSelfDeclaredDataDF.where(col("declared_status").isNull && !notNullAndEmpty(col("declared-phone")))
    print_Writer.write("\nphone empty records for declaration status is NULL (users): "+user32.count())
   
    //phone empty records for PENDING declaration validated users    
    val user33 = userSelfDeclaredDataDF.filter(col("declared_status") === "PENDING" && !notNullAndEmpty(col("declared-phone")))
    print_Writer.write("\nphone empty records for declaration pending users: "+user33.count())  
     
    print_Writer.close()     
  }

def notNullAndEmpty(c:Column): Column ={
    (c.isNotNull and !(c <=> lit("")))
  }
 

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
