This document contains the steps required for testing Certificate-Generator flink job.


1. Create the topic in kafka


1. Push messages into the kafka-topic via scripts( we are using here scala script)


1. Create a cron-job which will checks kafka-topic for every minute


1. Run the respective flink-job from jenkins


1. Get the kafka-topic details into a separate text file for checking the processed messages.



 **Create-Kafka topic** :

Login to kafka-machine

Navigate to kafka bin path and create topic with below message


```
bin/kafka-topics.sh --create --zookeeper localhost:2181 --topic loadtest.generate.certificate.request  --replication-factor 1 --partitions 1
```


 **Push messages to Topic:** 

Here we are using scala script to load messages into the kafka-topic

Login to spark machine


```
vi KafkaSink.scala
copy data from below KafkaSink.scala file  and paste it to  KafkaSink.scala
vi KafkaDispatcher.scala
copy data from below KafkaDispatcher.scala file  and paste it to  KafkaDispatcher.scala
vi KafkaLoadData.scala
copy data from below KafkaLoadData.scala file  and paste it to KafkaLoadData.scala
cd to the spark directory
bin/spark-shell --master local[*] --driver-memory 100g --packages com.datastax.spark:spark-cassandra-connector_2.11:2.5.0
:load {{absolute path of KafkaSink.scala}}
:load {{absolute path of KafkaDispatcher.scala}}
:load {{absolute path of KafkaLoadData.scala}}
KafkaLoadData.main(Array("");
```



```
package org.sunbird.analytics.job.report.scripts

import scala.concurrent.ExecutionContext.Implicits.global

import org.apache.kafka.clients.producer.KafkaProducer
import org.apache.kafka.clients.producer.ProducerRecord
import java.util.concurrent.Future
import org.apache.kafka.clients.producer.RecordMetadata
import org.apache.kafka.clients.producer.Callback

class KafkaSink(createProducer: () => KafkaProducer[String, String]) extends Serializable {
  
  lazy val producer = createProducer()
  
  def send(topic: String, value: String, callBack: Callback): Future[RecordMetadata] = {
    producer.send(new ProducerRecord(topic, value), callBack);
  }
  
  def close(): Unit = producer.close()
  def flush(): Unit = producer.flush()
  
}

object KafkaSink {
  
  def apply(config: java.util.Map[String, Object]): KafkaSink = {
    val f = () => {
      val producer = new KafkaProducer[String, String](config)
      sys.addShutdownHook {
        producer.close()
      }
      producer
    }
    new KafkaSink(f)
  }
  
}
```



```
package org.sunbird.analytics.job.report.scripts

import java.lang.Long
import java.util.HashMap

import org.apache.kafka.clients.producer.{Callback, ProducerConfig, RecordMetadata}
import org.apache.spark.SparkContext
import org.apache.spark.rdd.RDD

class KafkaDispatcher extends java.io.Serializable {

  implicit val className = "org.ekstep.analytics.framework.dispatcher.KafkaDispatcher"

  def dispatch(events: RDD[String], kafkaBrokers: String, kafkaTopic: String)(implicit sc: SparkContext) = {

    events.foreachPartition((partitions: Iterator[String]) => {
      val kafkaSink = KafkaSink(kafkaProducerConfig(kafkaBrokers))
      partitions.foreach { message =>
        try {
          kafkaSink.send(kafkaTopic, message, new Callback {
            override def onCompletion(metadata: RecordMetadata, exception: Exception): Unit = {
              if (null != exception) {
                exception.printStackTrace()
              }
            }
          })
        } catch {
            case e: Exception =>
              println("SerializationException inside kafka dispatcher", e.getMessage)
        }
      }
      kafkaSink.flush()
      kafkaSink.close()
    })

  }

  private def kafkaProducerConfig(brokerList: String): HashMap[String, Object] = {
    val props = new HashMap[String, Object]()
    props.put(ProducerConfig.MAX_BLOCK_MS_CONFIG, 3000L.asInstanceOf[Long])
    props.put(ProducerConfig.BOOTSTRAP_SERVERS_CONFIG, brokerList)
    props.put(ProducerConfig.VALUE_SERIALIZER_CLASS_CONFIG, "org.apache.kafka.common.serialization.StringSerializer")
    props.put(ProducerConfig.KEY_SERIALIZER_CLASS_CONFIG, "org.apache.kafka.common.serialization.StringSerializer")
    props.put(ProducerConfig.COMPRESSION_TYPE_CONFIG, "snappy")
    props.put("request.timeout.ms", new Integer(15000))
    props.put("batch.size", new Integer(65536))
    props
  }

}
```



```
package org.sunbird.analytics.job.report.scripts

import java.util.UUID

import org.apache.spark.SparkContext
import org.apache.spark.sql.SparkSession

object KafkaLoadData extends Serializable {
  
  def main(args: Array[String]): Unit = {
  
    fetchAndLoadDataToKafka()
  }

  def fetchAndLoadDataToKafka() {
    implicit val sparkSession: SparkSession = SparkSession.builder()
        .appName("KafkaLoadData")
        .config("spark.master", "local[*]").getOrCreate()
    implicit val sparkContext: SparkContext = sparkSession.sparkContext
  
    // val kafkaBrokers = "28.0.2.89:9092, 28.0.2.90:9092, 28.0.2.91:9092"
    val kafkaBrokers = "localhost:9092"
    val kafkaTopic = "loadtest.generate.certificate.request1"
    System.out.println("fetchAndLoadDataToKafka called")
    // val jsonDF = spark.read.text(s"wasbs://telemetry-data-store@<account-name>.blob.core.windows.net/error_events/2020-12-17-160818{[0-4]}*.json.gz")
    //val jsonDF = sparkSession.read.text(s"wasbs://telemetry-data-store@<azure-account>.blob.core.windows.net/unique/raw/2021-09-01-*.json.gz")
    val eventString = "{\"eid\":\"BE_JOB_REQUEST\",\"ets\":1563788371969,\"mid\":\"LMS.1563788371969.590c5fa0-0ce8-46ed-bf6c-681c0a1fdac8\",\"actor\":{\"type\":\"System\",\"id\":\"Certificate Generator\"},\"context\":{\"pdata\":{\"ver\":\"1.0\",\"id\":\"org.sunbird.platform\"}},\"object\":{\"type\":\"GenerateCertificate\",\"id\":\"874ed8a5-782e-4f6c-8f36-e0288455901e\"},\"edata\":{\"userId\":\"user001\",\"svgTemplate\":\"https://ntpstagingall.blob.core.windows.net/user/cert/File-01311849840255795242.svg\",\"templateId\":\"template_01_dev_001\",\"courseName\":\"new course may23\",\"data\":[{\"recipientName\":\"Creation \",\"recipientId\":\"user001\"}],\"name\":\"100PercentCompletionCertificate\",\"tag\":\"0125450863553740809\",\"issuer\":{\"name\":\"Gujarat Council of Educational Research and Training\",\"url\":\"https://gcert.gujarat.gov.in/gcert/\",\"publicKey\":[\"1\",\"2\"]},\"signatoryList\":[{\"name\":\"CEO Gujarat\",\"id\":\"CEO\",\"designation\":\"CEO\",\"image\":\"https://cdn.pixabay.com/photo/2014/11/09/08/06/signature-523237__340.jpg\"}],\"criteria\":{\"narrative\":\"course completion certificate\"},\"basePath\":\"https://dev.sunbirded.org/certs\",\"related\":{\"type\":\"course\",\"batchId\":\"0131000245281587206\",\"courseId\":\"do_11309999837886054415\"}}}"
    val eventList = List.fill(100000)(eventString)
    val jsonDF1 = sparkSession.sparkContext.parallelize(eventList)
    //val events = jsonDF.rdd.map(row => row(0).asInstanceOf[String])
    val kafkaDispatcher = new KafkaDispatcher()
    kafkaDispatcher.dispatch(jsonDF1, kafkaBrokers, kafkaTopic)
  }
}
```


 **Create-cron job:** 

Setting up cron job for throughput computation:

Create a shell script  **compute_throughput.sh** with below content

#!/bin/bash

output_dir=<path>/throughput

now=$(date +'%F %H:%M:%S')

output=$(<path-to-kafka-dir>/kafka_2.12-2.8.0/bin/kafka-consumer-groups.sh --bootstrap-server localhost:9092  --describe --group loadtest-certificate-generator-group)

echo -e $now '\t' $output >> $output_dir/throughput.txt



Setup crontab to run this shell script every minute

 ***/1 * * * * <path-to-script>/compute_throughput.sh** 



 **Run Flink application:** 

Deploy the flink job and check the  throughput.txt, it will show the below content.


```
2022-04-29 10:18:01      GROUP TOPIC PARTITION CURRENT-OFFSET LOG-END-OFFSET LAG CONSUMER-ID HOST CLIENT-ID 
                         loadtest-certificate-generator-group loadtest.generate.certificate.request 0 1110000 1610000 500000 - - -
2022-04-29 10:19:01      GROUP TOPIC PARTITION CURRENT-OFFSET LOG-END-OFFSET LAG CONSUMER-ID HOST CLIENT-ID 
                         loadtest-certificate-generator-group loadtest.generate.certificate.request 0 1131871 1610000 478129 - - -
2022-04-29 10:20:01      GROUP TOPIC PARTITION CURRENT-OFFSET LOG-END-OFFSET LAG CONSUMER-ID HOST CLIENT-ID 
                         loadtest-certificate-generator-group loadtest.generate.certificate.request 0 1167186 1610000 442814 - - -
2022-04-29 10:21:01      GROUP TOPIC PARTITION CURRENT-OFFSET LOG-END-OFFSET LAG CONSUMER-ID HOST CLIENT-ID 
                         loadtest-certificate-generator-group loadtest.generate.certificate.request 0 1202581 1610000 407419 - - -
2022-04-29 10:22:01      GROUP TOPIC PARTITION CURRENT-OFFSET LOG-END-OFFSET LAG CONSUMER-ID HOST CLIENT-ID
                         loadtest-certificate-generator-group loadtest.generate.certificate.request 0 1237898 1610000 372102 - - -
2022-04-29 10:23:01      GROUP TOPIC PARTITION CURRENT-OFFSET LOG-END-OFFSET LAG CONSUMER-ID HOST CLIENT-ID
                         loadtest-certificate-generator-group loadtest.generate.certificate.request 0 1273213 1610000 336787 - - -
2022-04-29 10:24:01      GROUP TOPIC PARTITION CURRENT-OFFSET LOG-END-OFFSET LAG CONSUMER-ID HOST CLIENT-ID
                         loadtest-certificate-generator-group loadtest.generate.certificate.request 0 1308930 1610000 301070 - - -
2022-04-29 10:25:01      GROUP TOPIC PARTITION CURRENT-OFFSET LOG-END-OFFSET LAG CONSUMER-ID HOST CLIENT-ID
                         loadtest-certificate-generator-group loadtest.generate.certificate.request 0 1344325 1610000 265675 - - -
2022-04-29 10:26:01      GROUP TOPIC PARTITION CURRENT-OFFSET LOG-END-OFFSET LAG CONSUMER-ID HOST CLIENT-ID
                         loadtest-certificate-generator-group loadtest.generate.certificate.request 0 1379482 1610000 230518 - - -
2022-04-29 10:27:01      GROUP TOPIC PARTITION CURRENT-OFFSET LOG-END-OFFSET LAG CONSUMER-ID HOST CLIENT-ID
                         loadtest-certificate-generator-group loadtest.generate.certificate.request 0 1414931 1610000 195069 - - -
2022-04-29 10:28:01      GROUP TOPIC PARTITION CURRENT-OFFSET LOG-END-OFFSET LAG CONSUMER-ID HOST CLIENT-ID
                         loadtest-certificate-generator-group loadtest.generate.certificate.request 0 1449870 1610000 160130 - - -
2022-04-29 10:29:01      GROUP TOPIC PARTITION CURRENT-OFFSET LOG-END-OFFSET LAG CONSUMER-ID HOST CLIENT-ID
                         loadtest-certificate-generator-group loadtest.generate.certificate.request 0 1485292 1610000 124708 - - -
2022-04-29 10:30:01      GROUP TOPIC PARTITION CURRENT-OFFSET LOG-END-OFFSET LAG CONSUMER-ID HOST CLIENT-ID
                         loadtest-certificate-generator-group loadtest.generate.certificate.request 0 1520848 1610000 89152 - - -
2022-04-29 10:31:01      GROUP TOPIC PARTITION CURRENT-OFFSET LOG-END-OFFSET LAG CONSUMER-ID HOST CLIENT-ID
                         loadtest-certificate-generator-group loadtest.generate.certificate.request 0 1555975 1610000 54025 - - -
2022-04-29 10:32:01      GROUP TOPIC PARTITION CURRENT-OFFSET LOG-END-OFFSET LAG CONSUMER-ID HOST CLIENT-ID
                         loadtest-certificate-generator-group loadtest.generate.certificate.request 0 1591156 1610000 18844 - - -
2022-04-29 10:33:01      GROUP TOPIC PARTITION CURRENT-OFFSET LOG-END-OFFSET LAG CONSUMER-ID HOST CLIENT-ID
                         loadtest-certificate-generator-group loadtest.generate.certificate.request 0 1610000 1610000 0 - - -
```
Note: totally it took 15mins to process 5 lakh message with 1 instance of flink job.



*****

[[category.storage-team]] 
[[category.confluence]] 
