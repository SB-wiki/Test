 **Job_Request table migration:** The scala script for {{env}}_job_request table migration from postgres DB. Using this script we are removing the existing blob csp specific path. 

Reports API in Obsrv BB, which will fetch the report data from this table will append the blob base path and return the reports.

Job_Request (analytics db in postgres) - Reports url update

 **from** 

[https://sunbirdstagingprivate.blob.core.windows.net/reports/userinfo-exhaust/7B7463609693ABBB33F4813BDE/0134278409923379202_userinfo_20211210.zip](https://sunbirdstagingprivate.blob.core.windows.net/reports/userinfo-exhaust/7B7463609693ABBB33F48[%E2%80%A6]13BDE/0134278409923379202_userinfo_20211210.zip)

 **to** 

userinfo-exhaust/7B7463609693ABBB33F4813BDE/0134278409923379202_userinfo_20211210.zip

Steps to execute:


1. Copy the below script to UpdateLinksInJR.scala file


1. Download the postgresql-42.2.6.jar from [https://jar-download.com/artifacts/org.postgresql/postgresql/42.2.6/source-code](https://jar-download.com/artifacts/org.postgresql/postgresql/42.2.6/source-code)


1. Go to spark home, for eg: spark-2.4.4-bin-hadoop2.7


1. Run below command in terminal


```
bin/spark-shell --master local[*]] ]></ac:plain-text-body></ac:structured-macro></li><li><p>Run below command in spark shell</p><ac:structured-macro ac:name="code" ac:schema-version="1" ac:macro-id="67d8ac0a-f26b-4441-bb6d-7ebb40c3f7e2"><ac:plain-text-body><![CDATA[:require <download path in step 2>/postgresql-42.2.6.jar
```

1. Run below command in spark shell


```
:load {{complete relative path of  UpdateLinksInJR.scala file}}
```

1. In below command, replace cloud_base_path value as ““, db-username - postgres db user name, db-password - postgres db password, table-name - {{env}}_job_request,  db-name - analytics, db-host-name - db ip address, old-blob-base-path - existing blob base path in db data ([https://sunbirdstagingprivate.blob.core.windows.net](https://sunbirdstagingprivate.blob.core.windows.net/reports/userinfo-exhaust/7B7463609693ABBB33F48[%E2%80%A6]13BDE/0134278409923379202_userinfo_20211210.zip)/[reports](https://sunbirdstagingprivate.blob.core.windows.net/reports/userinfo-exhaust/7B7463609693ABBB33F48[%E2%80%A6]13BDE/0134278409923379202_userinfo_20211210.zip)/)


1. Run below command in spark shell  with old-blob-base-path as “



wasb://reports@sunbirdstagingprivate.blob.core.windows.net/” (Get this value from the job-request table processed_batches column before executing the script)


```
UpdateLinksInJR.main(Array("{{cloud_base_path}}","{{db-username}}","{{db-password}}","{{table-name}}”,"{{db-name}}","{{db-host-name}}",”{{old-blob-base-path}}”))
```
Dev execution:


```
  UpdateLinksInJR.main(Array("","sunbirddevbb@devbb-pg11","dbpassword","sunbirdstaging_job_request","analytics","10.x.x.x", "wasb://reports@sunbirdstagingprivate.blob.core.windows.net/"))
```
 **For staging and other environment executions please provide proper field names.** 

For staging: replace parameters with proper details


```
UpdateLinksInJR.main(Array("{{cloud_base_path}}","{{db-username}}","{{db-password}}","{{table-name}}”,"{{db-name}}","{{db-host-name}}",”{{old-blob-base-path}}”))
```
updateProcessedBatchMap


```
import org.apache.spark.sql.functions.{col, _}
import org.apache.spark.sql.{ SparkSession}
import org.apache.spark.storage.StorageLevel

import java.io.File
import java.io.PrintWriter
import java.sql.{Connection, DriverManager, PreparedStatement}
import java.util.Properties

object UpdateLinksInJR extends Serializable {
    def main(args: Array[String]): Unit = {
        implicit val spark: SparkSession =
            SparkSession
                .builder()
                .appName("UpdateLinkInJR")
                .config("spark.master", "local[*]")
                //.config("spark.jars", "postgresql-42.2.14.jar")
                .getOrCreate()

        implicit val newHost: String = args(0)
        implicit val userName: String = args(1)
        implicit val password: String = args(2)
        implicit val tableName: String = args(3)
        implicit val database: String = args(4)
        implicit val host: String = args(5)
        implicit val presentBlobHost: String = args(6)

        val res = time(updateLinksInJR()(spark, newHost, userName, password, tableName, database, host, presentBlobHost));

        Console.println("Time taken to execute script", res._1);
        spark.stop();
    }

    def updateLinksInJR()(implicit spark: SparkSession, newHost: String, userName: String, password: String, tableName: String, database: String, host: String, presentBlobHost: String) {
        import spark.implicits._
        val sparkContext = spark.sparkContext
        val url = "jdbc:postgresql://"+host+":5432/"+database
        val connectionProperties = new Properties
        connectionProperties.put("driver", "org.postgresql.Driver")
        connectionProperties.put("dbtable", tableName)  // sunbirddev_job_request
        connectionProperties.put("user", userName)   //harikumarpalemkota
        connectionProperties.put("password", password)  //harikumarpalemkota
        connectionProperties.put("url", url)
        val jdbcDF = spark.read.format("jdbc").option("url", url).
          option("dbtable", tableName).  //sunbirddev_job_request
          option("user", userName).  //harikumarpalemkota
          option("password", password).  //harikumarpalemkota
          option("driver","org.postgresql.Driver").load().persist(StorageLevel.MEMORY_ONLY)
        jdbcDF.show(10, false)
        val templateDF = jdbcDF.select(col("tag"), col("request_id"), col("download_urls"), col("processed_batches"))
        val nonEmptyProcessedBatches = templateDF.where(col("processed_batches").isNotNull)
        nonEmptyProcessedBatches.show(10,false)
        val pdfDF = templateDF.select(col("tag"), col("request_id"))
        pdfDF.coalesce(1).write.format("com.databricks.spark.csv").option("header", "true").save("/tmp/updateLinksInJR/")
        val updateTemplateUrl = templateDF.withColumn("download_urls", when(col("download_urls").isNotNull, newDownloadUrlInfo(col("download_urls"), lit(newHost))).otherwise(col("download_urls"))).
          withColumn("processed_batches", when(col("processed_batches").isNotNull, updateProcessedBatchMap(col("processed_batches"), lit(newHost), lit(presentBlobHost))).otherwise(""))
        updateTemplateUrl.show(10, false)
        //val brodConn = sparkContext.broadcast(connectionProperties)

        val updateQry = s"UPDATE $tableName SET download_urls=?,processed_batches=? WHERE tag=? and request_id=?";
        val dbc: Connection = DriverManager.getConnection(
            connectionProperties.getProperty("url"), connectionProperties.getProperty("user"), connectionProperties.getProperty("password"))
        val pstmt: PreparedStatement = dbc.prepareStatement(updateQry);
        updateTemplateUrl.collect().foreach(partition => {
            if(partition.getAs("download_urls") != null) {
                val downUrl: java.util.List[String] = scala.collection.JavaConversions.seqAsJavaList(partition.getAs("download_urls"))
                val sqlArray = dbc.createArrayOf("text", downUrl.toArray.asInstanceOf[Array[Object]] )
                //scala.collection.JavaConversions.seqAsJavaList(downUrl)
                pstmt.setArray(1, sqlArray);
            } else {
                val sqlArray = dbc.createArrayOf("text",List().toArray.asInstanceOf[Array[Object]] );
                pstmt.setArray(1, sqlArray);
            }
            pstmt.setString(2, partition.getAs("processed_batches"));
            pstmt.setString(3, partition.getString(0));
            pstmt.setString(4, partition.getString(1));
            pstmt.addBatch()
        })
        pstmt.executeBatch()

    }

    def newDownloadUrlInfoFunction(oldUserCertInfo: Seq[String], newHost: String): Seq[String] = {
        var newDownloadUrl : Seq[String] = Seq.empty
        oldUserCertInfo.foreach(downloadUrl => {
            if(!downloadUrl.isEmpty) {
                val nonDoimainPath = downloadUrl.split("/", 5)
                val updatedDownloadUrl = nonDoimainPath(4)
                newDownloadUrl = newDownloadUrl :+ updatedDownloadUrl
            }
        })
        newDownloadUrl
    }

    val newDownloadUrlInfo = udf[Seq[String], Seq[String], String](newDownloadUrlInfoFunction)

    def updateProcessedBatchFunction(oldProcessedBatchs: String, newHost: String, presentBlobHost:String): String = {
        var newuprocessedBatch = new String
        if(oldProcessedBatchs.contains(presentBlobHost+"progress-exhaust/")) {
            newuprocessedBatch = oldProcessedBatchs.replaceFirst(presentBlobHost+"progress-exhaust/", newHost)
        } else if(oldProcessedBatchs.contains(presentBlobHost+"response-exhaust/")) {
            newuprocessedBatch = oldProcessedBatchs.replaceFirst(presentBlobHost+"response-exhaust/", newHost)
        } else if(oldProcessedBatchs.contains(presentBlobHost+"userinfo-exhaust/")) {
            newuprocessedBatch = oldProcessedBatchs.replaceFirst(presentBlobHost+"userinfo-exhaust/", newHost)
        }
        /*newuprocessedBatch = "[{"
        for(pb <- oldProcessedBatch) {
            val innercertInfo = pb._2
            for(certMap <- innercertInfo) {
                if(certMap._1.equals("filePath")) {
                    val updatePreviewUrl = certMap._2.split("/",4)
                    val updatedFilePath = "filePath:"+newHost+updatePreviewUrl(3)
                    newuprocessedBatch += updatedFilePath
                } else {
                    newuprocessedBatch += certMap._1+":"+certMap._2
                }
            }
        }
        newuprocessedBatch+"}]"*/
        newuprocessedBatch
    }

    val updateProcessedBatchMap = udf[String, String, String, String](updateProcessedBatchFunction)

    def time[R](block: => R): (Long, R) = {
        val t0 = System.currentTimeMillis()
        val result = block // call-by-name
        val t1 = System.currentTimeMillis()
        ((t1 - t0), result)
    }
}
```
Observations: (Time taken to execute script,25039), script ran over: 75290 records.

Verification Query:  (sunbirdstaging_job_request - this table name will change as per env)


```
select * from sunbirdstaging_job_request limit 10;
```
Run above query and select the data from analytics db and verify the  **download_urls**   column to make sure the cloud base path is removed and verify the  **processed_batches**  column to make sure the cloud base path is removed. 

Before migration data:


```
                                 tag                                  |            request_id            |      job_id      | status  |            request_data             |             requested_by             |  requested_channel   |    dt_job_submitted     |                                                                        download_urls                                                                        | dt_file_created |    dt_job_completed     | execution_time | err_message | iteration | encryption_key | batch_number |                                                                                                                      processed_batches                                                                                                                       
----------------------------------------------------------------------+----------------------------------+------------------+---------+-------------------------------------+--------------------------------------+----------------------+-------------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------+-----------------+-------------------------+----------------+-------------+-----------+----------------+--------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 do_2133816568022712321908_013381658992033792113:01269878797503692810 | F330990BF5873956AA7852A3DF4895C7 | progress-exhaust | SUCCESS | {"batchId":"013381658992033792113"} | fca2925f-1eee-4654-9177-fece3fd6afc9 | 01269878797503692810 | 2021-10-06 07:31:43.549 | {https://sunbirdstagingprivate.blob.core.windows.net/reports/progress-exhaust/F330990BF5873956AA7852A3DF4895C7/013381658992033792113_progress_20211006.zip} |                 | 2021-10-06 07:35:12.565 |          29682 |             |         0 |                |              | [{"channel":"01269878797503692810","batchId":"013381658992033792113","filePath":"wasb://reports@sunbirdstagingprivate.blob.core.windows.net/progress-exhaust/F330990BF5873956AA7852A3DF4895C7/013381658992033792113_progress_20211006.csv","fileSize":1403}]
(1 row)
```
After migration data:


```
                                 tag                                  |            request_id            |      job_id      | status  |            request_data             |             requested_by             |  requested_channel   |    dt_job_submitted     |                                                                        download_urls                                                                        | dt_file_created |    dt_job_completed     | execution_time | err_message | iteration | encryption_key | batch_number |                                                                                                                      processed_batches                                                                                                                       
----------------------------------------------------------------------+----------------------------------+------------------+---------+-------------------------------------+--------------------------------------+----------------------+-------------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------+-----------------+-------------------------+----------------+-------------+-----------+----------------+--------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 do_2133816568022712321908_013381658992033792113:01269878797503692810 | F330990BF5873956AA7852A3DF4895C7 | progress-exhaust | SUCCESS | {"batchId":"013381658992033792113"} | fca2925f-1eee-4654-9177-fece3fd6afc9 | 01269878797503692810 | 2021-10-06 07:31:43.549 | {progress-exhaust/F330990BF5873956AA7852A3DF4895C7/013381658992033792113_progress_20211006.zip} |                 | 2021-10-06 07:35:12.565 |          29682 |             |         0 |                |              | [{"channel":"01269878797503692810","batchId":"013381658992033792113","filePath":"progress-exhaust/F330990BF5873956AA7852A3DF4895C7/013381658992033792113_progress_20211006.csv","fileSize":1403}]
(1 row)
```


Observation from staging execution:

Ran the script with staging data, found there were data issues for 2 records, so script didn't ran properly in staging.

Identified records:


```
SELECT tag, request_id, job_id, status, request_data, requested_by, requested_channel, dt_job_submitted, download_urls, dt_file_created, dt_job_completed, execution_time, err_message, iteration, encryption_key, batch_number, processed_batches
	FROM public.sunbirdstaging_job_request where tag='do_21369020901738086411154_01369020992271974424:01269878797503692810' and request_id='2E710EDE2DABD36FF5BA4744C5D764AA';

SELECT tag, request_id, job_id, status, request_data, requested_by, requested_channel, dt_job_submitted, download_urls, dt_file_created, dt_job_completed, execution_time, err_message, iteration, encryption_key, batch_number, processed_batches
	FROM public.sunbirdstaging_job_request where tag='do_2133074736487792641239_013307481768378368112:01269878797503692810' and request_id='778A3669531143769B5E8C98D42E1CAD';
```
for those 2 records we can observe the  **download_urls**  values as '{userinfo-exhaust/2E710EDE2DABD36FF5BA4744C5D764AA/01369020992271974424_userinfo_20221218.csv}' and {progress-exhaust/778A3669531143769B5E8C98D42E1CAD/013307481768378368112_progress_20221216.csv}

but identically it should be appeneded with "[https://sunbirdstagingprivate.blob.core.windows.net/reports/](https://sunbirdstagingprivate.blob.core.windows.net/reports/)"AND  **processed_batches** values as \[{"channel":"01269878797503692810","batchId":"01369020992271974424","filePath":"userinfo-exhaust/2E710EDE2DABD36FF5BA4744C5D764AA/01369020992271974424_userinfo_20221218.csv","fileSize":532}] and \[{"channel":"01269878797503692810","batchId":"013307481768378368112","filePath":"progress-exhaust/778A3669531143769B5E8C98D42E1CAD/013307481768378368112_progress_20221216.csv","fileSize":240}]

but in the text  **filepath**  value should be appened with "wasb://reports@sunbirdstagingprivate.blob.core.windows.net/"both records seems to be inserted on 16th dec 2022, i don't know root cause of this, either someone must be inserted like this or something else. 

solution: Right now we can update both these records as we expect with the updation scripts.


```
UPDATE public.sunbirdstaging_job_request
	SET download_urls=ARRAY['https://sunbirdstagingprivate.blob.core.windows.net/reports/userinfo-exhaust/2E710EDE2DABD36FF5BA4744C5D764AA/01369020992271974424_userinfo_20221218.csv'], 
	processed_batches='[{"channel":"01269878797503692810","batchId":"01369020992271974424","filePath":"wasb://reports@sunbirdstagingprivate.blob.core.windows.net/userinfo-exhaust/2E710EDE2DABD36FF5BA4744C5D764AA/01369020992271974424_userinfo_20221218.csv","fileSize":532}]'
	WHERE tag='do_21369020901738086411154_01369020992271974424:01269878797503692810' and request_id='2E710EDE2DABD36FF5BA4744C5D764AA';
	
UPDATE public.sunbirdstaging_job_request
	SET download_urls=ARRAY['https://sunbirdstagingprivate.blob.core.windows.net/reports/progress-exhaust/778A3669531143769B5E8C98D42E1CAD/013307481768378368112_progress_20221216.csv}'],
	processed_batches='[{"channel":"01269878797503692810","batchId":"013307481768378368112","filePath":"wasb://reports@sunbirdstagingprivate.blob.core.windows.net/progress-exhaust/778A3669531143769B5E8C98D42E1CAD/013307481768378368112_progress_20221216.csv","fileSize":240}]'
	where tag='do_2133074736487792641239_013307481768378368112:01269878797503692810' and request_id='778A3669531143769B5E8C98D42E1CAD'
```




*****

[[category.storage-team]] 
[[category.confluence]] 
