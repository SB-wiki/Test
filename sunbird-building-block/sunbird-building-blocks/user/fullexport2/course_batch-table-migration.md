 **Course-Batch migration** : Scala script for course_batch table migration from cassandra.

This is used to update the certificate template url in course_batch table and append with variable.

APIs which will fetch this data will resolve the varible with configured cloud base path and return full url in response.


* course_batch (sunbird_courses keyspace in cassandra) - certificate template url update



 from [https://sunbirdstagingpublic.blob.core.windows.net/samiksha/certificateTemplates/637dacb4d3d5630009bc4acc/ba9aa220-ff1b-4717-b6ea-ace55f04fc16_23-10-2022-1669181140578.svg](https://sunbirdstagingpublic.blob.core.windows.net/samiksha/certificateTemplates/637dacb4d3d5630009bc4acc/ba9aa220-ff1b-4717-b6ea-ace55f04fc16_23-10-2022-1669181140578.svg)

 to 

[https://sunbirdstagingpublic.amazonaws.com/samiksha/certificateTemplates/637dacb4d3d5630009bc4acc/ba9aa220-ff1b-4717-b6ea-ace55f04fc16_23-10-2022-1669181140578.svg](https://sunbirdstagingpublic.amazonaws.com/samiksha/certificateTemplates/637dacb4d3d5630009bc4acc/ba9aa220-ff1b-4717-b6ea-ace55f04fc16_23-10-2022-1669181140578.svg))

Steps to execute:


1. Copy the below script to UpdateLinksInCB.scala file


1. Go to spark home, for eg: spark-2.4.4-bin-hadoop2.7


1. Run below command in terminal


```
bin/spark-shell --master local[*] --packages com.datastax.spark:spark-cassandra-connector_2.11:2.5.0
```

1. Run below command in spark shell


```
:load {{complete relative path of  UpdateLinksInCB.scala file}}
```

1. Run below command in spark shell


```
UpdateLinksInCB.main(Array("{{cassandra-host}}", "{{old_cloud_base_path}", "{{new_cloud_base_path}"))
```

    1. Replace the parameters as below


    1. {{cassandra-host}} with \[cassandra-1] In Core/hosts inventory


    1. {{old_cloud_base_path} with cloud_storage_base_url+cloud_storage_content_bucketname from ansible inventory


    1. {{new_cloud_base_path}} with CLOUD_BASE_PATH



    

    


```
import org.apache.spark.sql.functions.{col, _}
import org.apache.spark.sql.{Encoders, SaveMode, SparkSession}
import org.apache.spark.storage.StorageLevel

import java.io.File
import java.io.PrintWriter
import scala.collection.immutable.HashMap

object UpdateLinksInCB extends Serializable {
    
    def main(args: Array[String]): Unit = {
        implicit val spark: SparkSession =
            SparkSession
                .builder()
                .appName("UpdateLinksInCB")
                .config("spark.master", "local[*]")
                .config("spark.cassandra.connection.host", args(0))
                .config("spark.cassandra.output.batch.size.rows", "10000")
                .config("spark.cassandra.read.timeoutMS", "60000")
                .getOrCreate()
        
        val oldBasepath = args(1)
        val newBasepath = args(2)
        val res = time(updateLinksInCB(oldBasepath, newBasepath));

        
        Console.println("Time taken to execute script", res._1);
        spark.stop();
    }
    
    def updateLinksInCB(oldBasepath: String, newBasepath: String)(implicit spark: SparkSession) {
        import spark.implicits._
        val sparkContext = spark.sparkContext
        //val file = new File("userdeclarationup_audit.txt")
        //val print_Writer = new PrintWriter(file)
        val courseBatchDF = spark.read.format("org.apache.spark.sql.cassandra").option("keyspace", "sunbird_courses").option("table", "course_batch").load().persist(StorageLevel.MEMORY_ONLY)
        val courseBatchWithCert =   courseBatchDF.where(size(col("cert_templates"))>0);
        val originalCertDF = courseBatchWithCert.select(col("courseid"), col("batchid"), col("cert_templates"))
        originalCertDF.show(10, false)
        val updatedCertDF = originalCertDF.withColumn("cert_templates", certInfoMap(col("cert_templates"), lit(oldBasepath), lit(newBasepath)))
        updatedCertDF.show(10, false)
        updatedCertDF.write.format("org.apache.spark.sql.cassandra").option("keyspace", "sunbird_courses").option("table", "course_batch").mode(SaveMode.Append).save();
    }

    def updateCertMapFunction(oldUserCertInfo: Map[String, Map[String, String]] , oldBase: String, newBase: String): Map[String, Map[String, String]]  = {
        var updatedUserCertInfo = new HashMap[String, HashMap[String, String]] ()
        for(certInfo <- oldUserCertInfo) {
            val innercertInfo = certInfo._2
            var updatedInnercertInfo = new HashMap[String, String]()
            for(certMap <- innercertInfo) {
                if(certMap._2.contains(oldBase)) {
                    updatedInnercertInfo += (certMap._1 -> certMap._2.replace(oldBase, newBase))
                } else {
                    updatedInnercertInfo += (certMap._1 -> certMap._2)
                }
            }
            updatedUserCertInfo += (certInfo._1 -> updatedInnercertInfo)
        }
        updatedUserCertInfo
    }

    val certInfoMap = udf[Map[String, Map[String, String]] , Map[String, Map[String, String]] , String, String](updateCertMapFunction)
    
    def time[R](block: => R): (Long, R) = {
        val t0 = System.currentTimeMillis()
        val result = block // call-by-name
        val t1 = System.currentTimeMillis()
        ((t1 - t0), result)
    }
}
```
Observations: Script ran over 10244 records, it took around less than 4 mins

Verification Query:


```
select * from sunbird_courses.course_batch limit 10;
```
Run above query and select the data from course_batch table in sunbird_courses Cassandra keyspace  and verify the cert_templatescolumn to make sure the cloud base path is update with CLOUD_BASE_PATH.





*****

[[category.storage-team]] 
[[category.confluence]] 
