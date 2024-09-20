 **release-4.0.0** :

This script will update associationType of the user based on their orgJoinDate.


### Steps to add associationType of the user



```
vi UserOrgAssociationTypeUpdate.scala
copy data from below UserOrgAssociationTypeUpdate.scala file  and paste it to  UserOrgAssociationTypeUpdate.scala
cd to the spark directory
bin/spark-shell --master local[*] --packages com.datastax.spark:spark-cassandra-connector_2.11:2.5.0
:load {{absolute path of UserOrgAssociationTypeUpdate.scala}}
UserOrgAssociationTypeUpdate.main("{cassandra ip}")
```



```
import org.apache.spark.sql.functions.{col, _}
import org.apache.spark.sql.{ DataFrame,SparkSession }
import org.apache.spark.sql.Encoders
import org.apache.spark.sql.SaveMode
import org.apache.spark.storage.StorageLevel
import org.apache.spark.sql.functions.{array_distinct, flatten}
import org.apache.spark.sql.expressions.Window

case class UserOrganisation(userid: String, organisationid: String, orgjoindate: Option[String], associationtype: Option[Int])

case class UserOrgAssociation(userid: String, organisationid: String, associationtype: Int)

object UserOrgAssociationTypeUpdate extends Serializable {
  def main(cassandraHost: String): Unit = {
    implicit val spark: SparkSession =
      SparkSession
        .builder()
        .appName("UserOrgDataMigration")
        .config("spark.master", "local[*]")
        .config("spark.cassandra.connection.host", cassandraHost)
        .config("spark.cassandra.output.batch.size.rows", "10000")
        .config("spark.cassandra.read.timeoutMS", "60000")
        .getOrCreate()
    val res = time(migrateData());
    Console.println("Time taken to execute script", res._1);
    spark.stop();
  }

def migrateData()(implicit spark: SparkSession) {
    val schema = Encoders.product[UserOrganisation].schema
    val data = spark.read.format("org.apache.spark.sql.cassandra").schema(schema).option("keyspace", "sunbird").option("table", "user_organisation").load();
    
    val custodianOrgId = getCustodianOrgId();

    val format = new java.text.SimpleDateFormat("yyyy-MM-dd")

    val userOrgDF = data.map((row) => {
            var associationType:Int = 2; //selfDeclaredAssociatioType (if orgJoinDate null or empty or after release-3.6))

            val orgJoinDate = if(row.getAs[String]("orgjoindate") != null) row.getAs[String]("orgjoindate") else ""

            val organisationId = row.getAs[String]("organisationid")

            if(organisationId != custodianOrgId && !orgJoinDate.isEmpty) {
                var orgJoinDateVar = orgJoinDate.substring(0,10)
                if (format.parse(orgJoinDate).before(format.parse("2021-02-04"))) {
                  associationType = 1; // sso AssociationType
                }
            }
        UserOrgAssociation(
                row.getAs[String](0), row.getAs[String](1), associationType)
        })
    
    userOrgDF.write.format("org.apache.spark.sql.cassandra").option("keyspace", "sunbird").option("table", "user_organisation").mode(SaveMode.Append).save()
  }

  def getCustodianOrgId() (implicit sparkSession: SparkSession): String = {
        val systemSettingDF = loadData(sparkSession, Map("table" -> "system_settings", "keyspace" -> "sunbird")).where(col("id") === "custodianOrgId")
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


*****

[[category.storage-team]] 
[[category.confluence]] 
