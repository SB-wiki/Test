 **release-4.0.0** 

In this ticket we are doing the following data migration on the user_role table, Moving roles related data to user_roles table.


* Data migration to add data from user_organisation table to user_roles table regarding roles data




```
vi UserOrgToUserRolesMigration.scala
copy data from below UserOrgToUserRolesMigration.scala file  and paste it to  UserOrgToUserRolesMigration.scala
cd to the spark directory
bin/spark-shell --master local[*] --packages com.datastax.spark:spark-cassandra-connector_2.11:2.5.0
:load {{absolute path of UserOrgToUserRolesMigration.scala}}
UserOrgToUserRolesMigration.main("{cassandra ip}")
```



```

import java.io.{File, PrintWriter}

import org.apache.spark.SparkContext
import org.apache.spark.sql.functions.col
import org.apache.spark.sql._
import org.apache.spark.sql.functions._
import org.apache.spark.sql.SparkSession

case class UserOrg(id:String, userid: String, roles: List[String], organisationid: Option[String], approvedby: String, updatedby: String, isdeleted: Boolean)
case class UserRole(userid: String, role: String, scope: String, createdby: String, updatedby: String)
case class UserRoleId(userid: String, role: String)

object UserOrgToUserRolesMigration extends Serializable {
    
    def main(cassandraId: String): Unit = {
    implicit val spark: SparkSession =
      SparkSession
        .builder()
        .appName("OrgLocationAndOrgTypeMigration")
        .config("spark.master", "local[*]")
        .config("spark.cassandra.connection.host",cassandraId)
        .config("spark.cassandra.output.batch.size.rows", "10000")
        .config("spark.cassandra.output.consistency.level","LOCAL_QUORUM")
        .config("spark.cassandra.input.consistency.level","LOCAL_QUORUM")
        .config("spark.cassandra.read.timeoutMS","12000")
        .getOrCreate()
        val res = time(migrateData());

    Console.println("Time taken to execute script", res._1);
    spark.stop();
   }
    
   def migrateData()(implicit spark: SparkSession) = {
    
        import spark.implicits._
    
        val userOrgSchema = Encoders.product[UserOrg].schema
        var userOrgAllData = spark.read.format("org.apache.spark.sql.cassandra").schema(userOrgSchema).option("keyspace", "sunbird").option("table", "user_organisation").load();
        var userOrgData = userOrgAllData.where(col("isdeleted") === false)
        val userOrgRolesDF = userOrgData.withColumn("newroles", explode_outer(col("roles")))
        val userFilteredOrgRolesDF = userOrgRolesDF.filter(col("newroles")  =!= "PUBLIC")
        val userFilteredOrgRolesDF1 = userFilteredOrgRolesDF.groupBy("userid", "newroles").agg(collect_list("organisationid").as("organisationids"), first("approvedby") as "approvedby", first("updatedby") as "updatedby")
        val userFilteredOrgRolesWithScope = userFilteredOrgRolesDF1.withColumn("scope", addScope(col("organisationids")))
        val userRoleDF = userFilteredOrgRolesWithScope.map(row => {
            var approvedBy = "";
            if(row.getAs[String]("approvedby") == null) {
                approvedBy = row.getAs[String]("userid");
            } else {
                approvedBy = row.getAs[String]("approvedby");
            }
            UserRole(row.getAs[String]("userid"), row.getAs("newroles"),
                row.getAs("scope"), approvedBy, row.getAs("updatedby"))
        })
        userRoleDF.write.format("org.apache.spark.sql.cassandra").option("keyspace", "sunbird").option("table", "user_roles").mode(SaveMode.Append).save();
        val file = new File("userroles.txt" )
        val print_Writer = new PrintWriter(file)
        val userRoleData = spark.read.format("org.apache.spark.sql.cassandra").option("keyspace", "sunbird").option("table", "user_roles").load().
          select(
              col("userid")).distinct().cache()
        userRoleData.coalesce(1).write.format("com.databricks.spark.csv").option("header", "true").save("/tmp/userrolesmigratedinfo")
        print_Writer.write("\n User roles table Row Count : "+ userRoleData.count())
        print_Writer.close()
        
    }
    
    def addScopeFunction(orgIds: Seq[String]): String = {
        var scope = "["
        if(orgIds.size == 1) {
            scope += "{\"organisationId\": \"" + orgIds(0) + "\"}"
        } else {
            scope += "{\"organisationId\": \"" + orgIds(0) + "\"},{\"organisationId\": \"" + orgIds(1) + "\"}"
        }
        scope += "]"
        return scope
    }
    val addScope = udf[String, Seq[String]] (addScopeFunction)

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
