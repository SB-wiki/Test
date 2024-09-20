 **TrainingCeritificate Migration** : The scala script for blob url change in TrainingCertificate table in postgres of RC.

Note: Execute this script when new CSP provider is opted and urls of existing blobs have to be changed.

Steps to execute:


1. Copy the below script to UpdateLinkInTC.scala file


1. Download the postgresql-42.2.6.jar from [https://jar-download.com/artifacts/org.postgresql/postgresql/42.2.6/source-code](https://jar-download.com/artifacts/org.postgresql/postgresql/42.2.6/source-code)


1. Go to spark home, for eg: spark-2.4.4-bin-hadoop2.7


1. Run below command in terminal


```
bin/spark-shell --master local[*] --driver-memory 24g
```

1. Run below command in spark shell


```
:require <download path in step 2>/postgresql-42.2.6.jar
```

1. Run below command in spark shell


```
:load {{complete relative path of  UpdateLinkInTC.scala file}}
```

1. In below command, replace cname - new cname url, db-username - postgres db user name, db-password - postgres db password, table-name - "\"V_TrainingCertificate\"", db-name - registry, db-host-name - db ip address, old-blob-base-path - existing blob base path of templateUrl column value.(for eg in staging is : [https://sunbirdstagingprivate.blob.core.windows.net](https://sunbirdstagingprivate.blob.core.windows.net/reports/userinfo-exhaust/7B7463609693ABBB33F48[%E2%80%A6]13BDE/0134278409923379202_userinfo_20211210.zip))


1. Run below command in spark shell


```
UpdateLinkInTC.main(Array("{{cname}}","{{db-username}}","{{db-password}}","{{table-name}}","{{db-name}}","{{db-host-name}}","{{old-blob-host-name}}"))
```



```
package org.sunbird.analytics.job.report.scripts

import org.apache.spark.sql.functions.{col, _}
import org.apache.spark.sql.{Encoders, Row, SparkSession}
import org.apache.spark.storage.StorageLevel

import java.sql.{Connection, DriverManager, PreparedStatement}
import java.util.Properties

object UpdateLinkInTC extends Serializable {
    
    def main(args: Array[String]): Unit = {
        implicit val spark: SparkSession =
            SparkSession
                .builder()
                .appName("UpdateLinkInTC")
                .config("spark.master", "local[*]")
              .config("spark.sql.inMemoryColumnarStorage.batchSize",10000)
              .config("spark.kryo.referenceTracking", false)
                //.config("spark.jars", "postgresql-42.2.14.jar")
                .getOrCreate()

        implicit val newHost: String = args(0)
        implicit val user: String = args(1)
        implicit val password: String = args(2)
        implicit val dbtable: String = args(3)   //"\"V_TrainingCertificate\""
        implicit val dbname: String = args(4)
        implicit val host: String = args(5)
        implicit val presentBlobHost: String = args(6)
        val url = "jdbc:postgresql://"+host+":5432/"+dbname

        val res = time(updateLinkInTC()(spark, newHost, dbtable, user, password, url, presentBlobHost))
        
        Console.println("Time taken to execute script", res._1);
        spark.stop();
    }
    
    def updateLinkInTC()(implicit spark: SparkSession, newHost: String, dbtable: String, user: String, password: String, url: String, presentBlobHost: String) {
        import spark.implicits._
        val sparkContext = spark.sparkContext

        val connectionProperties = new Properties
        connectionProperties.put("driver", "org.postgresql.Driver")
        connectionProperties.put("dbtable", dbtable)
        connectionProperties.put("user", user)
        connectionProperties.put("password", password)
        connectionProperties.put("url", url)
        val jdbcDF = spark.read.format("jdbc").option("url", url).
          option("dbtable", dbtable).
          option("user", user).
          option("password", password).
          option("driver", "org.postgresql.Driver").load().persist(StorageLevel.MEMORY_ONLY)
        jdbcDF.show(10, false)
        val templateDF = jdbcDF.select(col("ID"), col("templateUrl"), col("_ossigneddata")).where(col("templateUrl").isNotNull)
        //val csvDF = templateDF.select(col("ID"))
        val updateTemplateUrl = templateDF.withColumn("templateUrl", certInfo(col("templateUrl"), lit(newHost))).
          withColumn("_ossigneddata", when(col("_ossigneddata").isNotNull, newAssignedData(col("_ossigneddata"), lit(newHost), lit(presentBlobHost))).otherwise(col("_ossigneddata")))
        //csvDF.coalesce(1).write.format("com.databricks.spark.csv").option("header", "true").save("/tmp/updateLinksInTC/")
        //val brodConn = sparkContext.broadcast(connectionProperties)
        /*val updateQry = s"UPDATE $dbtable SET templateUrl=? WHERE ID=?";
        val dbc: Connection = DriverManager.getConnection(
            connectionProperties.getProperty("url"), connectionProperties.getProperty("user"), connectionProperties.getProperty("password"))*/
        /*val pstmt: PreparedStatement = dbc.prepareStatement(updateQry);
        updateTemplateUrl.collect().foreach(partition => {
            pstmt.setString(1, partition.getAs("templateUrl"));
            pstmt.setLong(2, partition.getLong(0));
            pstmt.addBatch()
        })
        pstmt.executeBatch()*/


        /*updateTemplateUrl.coalesce(5).foreachPartition((d) => List(d).iterator) { batch =>
            val dbc: Connection = DriverManager.getConnection(connectionProperties.getProperty("url"), connectionProperties.getProperty("user"), connectionProperties.getProperty("password"))
            val st: PreparedStatement = dbc.prepareStatement("UPDATE $dbtable SET templateUrl=? WHERE ID=?")

            batch.grouped(20000).foreach { session =>
                session.foreach { x =>
                    st.setString(1, x.getAs("templateUrl"))
                    st.setLong(2, x.getLong(0));
                    st.addBatch()
                }
                st.executeBatch()
            }
            dbc.close()
        }*/

        val id = "\"ID\""
        val templateUrl = "\"templateUrl\""
        val ossigneddata = "\"_osSignedData\""
        updateTemplateUrl.coalesce(5).foreachPartition((partition: Iterator[Row]) => {
            val dbc: Connection = DriverManager.getConnection(connectionProperties.getProperty("url"), connectionProperties.getProperty("user"), connectionProperties.getProperty("password"))
            val query = s"UPDATE $dbtable SET $templateUrl=?, $ossigneddata=? WHERE $id=?"
            val st: PreparedStatement = dbc.prepareStatement(query)
            partition.grouped(20000).foreach { session =>
                session.foreach { x =>
                    st.setString(1, x.getAs("templateUrl"))
                    st.setString(2, x.getAs("_ossigneddata"))
                    st.setLong(3, x.getLong(0));
                    st.addBatch()
                }
                st.executeBatch()
            }
            dbc.close()
        })
    }

    def newAssignedDataFunction(assignedData: String, newHost: String, presentBlobHost: String): String = {
        val updatedInnercertInfo = assignedData.replaceAll(presentBlobHost, newHost);
        updatedInnercertInfo
    }

    val newAssignedData = udf[String, String, String, String](newAssignedDataFunction)

    def updateCertFunction(oldUserCertInfo: String, newHost: String): String = {
        val updatePreviewUrl = oldUserCertInfo.split("/",4)
        val updatedInnercertInfo = (newHost+"/"+updatePreviewUrl(3))
        updatedInnercertInfo
    }

    val certInfo = udf[String, String, String](updateCertFunction)
    
    def time[R](block: => R): (Long, R) = {
        val t0 = System.currentTimeMillis()
        val result = block // call-by-name
        val t1 = System.currentTimeMillis()
        ((t1 - t0), result)
    }
}
```
Observations: 

This script took around 19gb driver memory, script is ran over: 4713032 records.

Took around 1hour.

Verification Query:


```
select "_osSignedData","templateUrl" from "V_TrainingCertificate" where osid='63759159-eca8-41e8-967e-6ca6944316a4';
```
Run above query and select the data from rc registry db and verify the templateUrl and ossigneddata to make sure the cloud base path is updated with cname.





*****

[[category.storage-team]] 
[[category.confluence]] 
