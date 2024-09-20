Below are the different type of logs which is generated from learner service. 

what-ever mentioned in the [ticket](https://project-sunbird.atlassian.net/browse/SB-21783) SB-21783 is already getting in the below logs, do we need to add any further?




```json
{"timestamp":"2021-11-16T13:06:49.300Z","msg":"{\"eid\":\"ERROR\",\"ets\":1637068009300,\"ver\":\"3.0\",\"mid\":\"7d2fce08d3e7fabd2b0be1807e485dc8\",\"actor\":{\"id\":\"8153b9ef-6d13-4bab-aada-1e3a6f6e229e\",\"type\":\"User\"},\"context\":{\"channel\":\"0126796199493140480\",\"pdata\":{\"id\":\"staging.diksha.app\",\"pid\":\"learner-service\",\"ver\":\"4.4.0\"},\"env\":\"User\",\"did\":\"d2942ce5ce87680b0c024074deea3b2fb29c4a9b\",\"cdata\":[{\"id\":\"7d2fce08d3e7fabd2b0be1807e485dc8\",\"type\":\"Request\"}],\"rollup\":{}},\"edata\":{\"err\":\"500\",\"stacktrace\":\"controllers.BaseController.createCommonExceptionResponse(BaseController.java:530)\\ncontrollers.BaseCo\",\"errtype\":\"INTERNAL_ERROR\"}}","lname":"TelemetryEventLogger","tname":"Thread-107232","level":"INFO","HOSTNAME":"learner-7b698ffbdb-6dj26","application.home":"/home/sunbird/learner/learning-service-1.0-SNAPSHOT"}

{"timestamp":"2021-11-17T09:38:24.783Z","msg":"Invalid value null for parameter hashTagId. Please provide a valid value.","lname":"controllers.BaseController","tname":"application-akka.actor.default-dispatcher-20987","level":"ERROR","stack_trace":"<#76b0926c> org.sunbird.exception.ProjectCommonException: Invalid value null for parameter hashTagId. Please provide a valid value.\n\tat org.sunbird.validator.BaseRequestValidator.lambda$validateListValues$6(BaseRequestValidator.java:293)\n\tat java.util.ArrayList.forEach(ArrayList.java:1541)\n\tat org.sunbird.validator.BaseRequestValidator.validateListValues(BaseRequestValidator.java:287)\n\tat org.sunbird.validator.BaseRequestValidator.lambda$validateSearchRequestFiltersValues$4(BaseRequestValidator.java:259)\n\tat java.util.LinkedHashMap.forEach(LinkedHashMap.java:684)\n\tat org.sunbird.validator.BaseRequestValidator.validateSearchRequestFiltersValues(BaseRequestValidator.java:249)\n\tat org.sunbird.validator.BaseRequestValidator.validateSearchRequest(BaseRequestValidator.java:217)\n\tat controllers.organisationmanagement.OrgController.lambda$search$4(OrgController.java:85)\n\tat controllers.BaseController.handleSearchRequest(BaseController.java:307)\n\tat controllers.organisationmanagement.OrgController.search(OrgController.java:80)\n\tat router.Routes$$anonfun$routes$1$$anonfun$applyOrElse$64$$anonfun$apply$210$$anonfun$apply$211.apply(Routes.scala:2321)\n\tat router.Routes$$anonfun$routes$1$$anonfun$applyOrElse$64$$anonfun$apply$210$$anonfun$apply$211.apply(Routes.scala:2321)\n\tat play.core.routing.HandlerInvokerFactory$$anon$6.resultCall(HandlerInvoker.scala:155)\n\tat play.core.routing.HandlerInvokerFactory$JavaActionInvokerFactory$$anon$10$$anon$2$$anon$1.invocation(HandlerInvoker.scala:116)\n\tat play.core.j.JavaAction$$anon$1.call(JavaAction.scala:131)\n\tat play.mvc.Action.lambda$call$0(Action.java:89)\n\tat java.util.Optional.map(Optional.java:265)\n\tat play.mvc.Action.call(Action.java:81)\n\tat modules.OnRequestHandler$1.call(OnRequestHandler.java:87)\n\tat play.core.j.JavaAction$$anonfun$10.apply(JavaAction.scala:191)\n\tat play.core.j.JavaAction$$anonfun$10.apply(JavaAction.scala:191)\n\tat scala.concurrent.impl.Future$PromiseCompletingRunnable.liftedTree1$1(Future.scala:24)\n\tat scala.concurrent.impl.Future$PromiseCompletingRunnable....\n","HOSTNAME":"learner-7b698ffbdb-6dj26","application.home":"/home/sunbird/learner/learning-service-1.0-SNAPSHOT"}

{"timestamp":"2021-11-17T09:38:24.783Z","msg":"{\"eid\":\"ERROR\",\"ets\":1637141904783,\"ver\":\"3.0\",\"mid\":\"8e776b79-ff79-4552-9dcc-d0ee155476a3\",\"actor\":{\"id\":\"internal\",\"type\":\"Consumer\"},\"context\":{\"channel\":\"0126796199493140480\",\"pdata\":{\"id\":\"staging.sunbird.learning.service\",\"pid\":\"learner-service\",\"ver\":\"4.4.0\"},\"env\":\"Organisation\",\"cdata\":[{\"id\":\"8e776b79-ff79-4552-9dcc-d0ee155476a3\",\"type\":\"Request\"}],\"rollup\":{}},\"edata\":{\"err\":\"400\",\"stacktrace\":\"org.sunbird.validator.BaseRequestValidator.lambda$validateListValues$6(BaseRequestValidator.java:293\",\"errtype\":\"INVALID_PARAMETER_VALUE\"}}","lname":"TelemetryEventLogger","tname":"application-akka.actor.default-dispatcher-20987","level":"INFO","HOSTNAME":"learner-7b698ffbdb-6dj26","application.home":"/home/sunbird/learner/learning-service-1.0-SNAPSHOT"}

{"timestamp":"2021-11-17T07:55:56.141Z","msg":"Cassandra query : SELECT * FROM sunbird.role;","lname":"org.sunbird.cassandraimpl.CassandraOperationImpl","tname":"application-akka.actor.health-check-dispatcher-51401","level":"INFO","HOSTNAME":"learner-7b698ffbdb-6dj26","application.home":"/home/sunbird/learner/learning-service-1.0-SNAPSHOT"}

{"timestamp":"2021-11-17T07:57:23.816Z","msg":"{eid='LOG', edata={level=trace, requestid=0090d1c8237cd92dae6efe572589a508, type=system, message=EXIT LOG: method : POST, url: /v1/user/consent/read , For Operation : getUserConsent, params=[{consents=[]}, {msgid=0090d1c8237cd92dae6efe572589a508, errmsg=null, resmsgid=null, err=null, status=success, responseCode=200}]}}","lname":"util.PrintEntryExitLog","tname":"Thread-113979","level":"INFO","HOSTNAME":"learner-7b698ffbdb-6dj26","application.home":"/home/sunbird/learner/learning-service-1.0-SNAPSHOT","uid":"08631a74-4b94-4cf7-a818-831135248a4a","op":"getUserConsent","appVer":null,"appId":"dev.sunbird.portal","did":"1726023c0f4e4f17b2c956c412fd5859","sid":"mDPCn4Cs6i4vWnXCvjrfSKKPdNEqEGJy","reqId":"0090d1c8237cd92dae6efe572589a508"}

{"timestamp":"2021-11-17T07:57:23.873Z","msg":"ElasticSearchRestHighImpl:search: calling search for index user_alias, with query = {\"from\":0,\"size\":250,\"query\":{\"bool\":{\"must\":[{\"term\":{\"managedBy.raw\":{\"value\":\"08631a74-4b94-4cf7-a818-831135248a4a\",\"boost\":1.0}}}],\"adjust_pure_negative\":true,\"boost\":1.0}},\"_source\":{\"includes\":[],\"excludes\":[]},\"sort\":[{\"createdDate.raw\":{\"order\":\"desc\"}}]}","lname":"org.sunbird.common.ElasticSearchRestHighImpl","tname":"application-akka.actor.most-used-one-dispatcher-51384","level":"INFO","HOSTNAME":"learner-7b698ffbdb-6dj26","application.home":"/home/sunbird/learner/learning-service-1.0-SNAPSHOT","uid":"08631a74-4b94-4cf7-a818-831135248a4a","op":"getManagedUsers","appVer":null,"appId":"dev.sunbird.portal","did":"1726023c0f4e4f17b2c956c412fd5859","sid":"mDPCn4Cs6i4vWnXCvjrfSKKPdNEqEGJy","reqId":"2286318d-2835-4789-160d-53f28581f95c"}

{"timestamp":"2021-11-17T07:57:23.870Z","msg":"{eid='LOG', edata={level=trace, requestid=2286318d-2835-4789-160d-53f28581f95c, type=system, message=ENTRY LOG: method : GET, url: /v1/user/managed/08631a74-4b94-4cf7-a818-831135248a4a?sortBy=createdDate&order=desc?sortBy=createdDate&order=desc , For Operation : getManagedUsers, params=[{id=null, userId=null}]}}","lname":"util.PrintEntryExitLog","tname":"application-akka.actor.default-dispatcher-37","level":"INFO","HOSTNAME":"learner-7b698ffbdb-6dj26","application.home":"/home/sunbird/learner/learning-service-1.0-SNAPSHOT","uid":"08631a74-4b94-4cf7-a818-831135248a4a","op":"getManagedUsers","appVer":null,"appId":"dev.sunbird.portal","did":"1726023c0f4e4f17b2c956c412fd5859","sid":"mDPCn4Cs6i4vWnXCvjrfSKKPdNEqEGJy","reqId":"2286318d-2835-4789-160d-53f28581f95c"}

{"timestamp":"2021-11-17T07:57:23.815Z","msg":"Cassandra query : SELECT * FROM sunbird.user_consent WHERE consumer_id=? AND user_id=? AND object_id=?;","lname":"org.sunbird.cassandraimpl.CassandraOperationImpl","tname":"application-akka.actor.rr-usr-dispatcher-51009","level":"INFO","HOSTNAME":"learner-7b698ffbdb-6dj26","application.home":"/home/sunbird/learner/learning-service-1.0-SNAPSHOT","uid":"08631a74-4b94-4cf7-a818-831135248a4a","op":"getUserConsent","appVer":null,"appId":"dev.sunbird.portal","did":"1726023c0f4e4f17b2c956c412fd5859","sid":"mDPCn4Cs6i4vWnXCvjrfSKKPdNEqEGJy","reqId":"0090d1c8237cd92dae6efe572589a508"}
```


Learner-service already had many error-codes if we need to change anything now, portal and APP may get affect a lot.

As of now we are using logback.xml with slf4j for logging purpose, below given sample config for logging and telemetry.

Eg: 


```
<appender name="defaultLoggerAppender" class="ch.qos.logback.core.ConsoleAppender">
    <encoder class="net.logstash.logback.encoder.LogstashEncoder">
      <layout class="net.logstash.logback.layout.LogstashLayout">
        <fieldNames>
          <timestamp>timestamp</timestamp>
          <message>msg</message>
          <logger>lname</logger>
          <thread>tname</thread>
          <levelValue>[ignore]</levelValue>
          <version>[ignore]</version>
          <stack_trace>exception</stack_trace>
        </fieldNames>
        <throwableConverter class="net.logstash.logback.stacktrace.ShortenedThrowableConverter">
          <maxDepthPerThrowable>30</maxDepthPerThrowable>
          <maxLength>2048</maxLength>
          <exclude>sun\.reflect\..*\.invoke.*</exclude>
          <rootCauseFirst>true</rootCauseFirst>
          <inlineHash>true</inlineHash>
        </throwableConverter>
      </layout>
    </encoder>
  </appender>
  
  <logger name="defaultLoggerAppender" level="INFO" />
  
  <logger name="TelemetryEventLogger" level="INFO">
    <appender-ref ref="kafka-appender" />
  </logger>
  
  <appender name="kafka-appender" class="com.github.danielwegener.logback.kafka.KafkaAppender">
    <encoder class="ch.qos.logback.classic.encoder.PatternLayoutEncoder">
      <pattern>%msg</pattern>
    </encoder>

    <topic>${ENV_NAME}.telemetry.raw</topic>
    <!-- ensure that every message sent by the executing host is partitioned to the same partition strategy -->
    <keyingStrategy class="com.github.danielwegener.logback.kafka.keying.NoKeyKeyingStrategy" />
    <!-- block the logging application thread if the kafka appender cannot keep up with sending the log messages -->
    <deliveryStrategy class="com.github.danielwegener.logback.kafka.delivery.AsynchronousDeliveryStrategy" />

    <!-- each <producerConfig> translates to regular kafka-client config (format: key=value) -->
    <!-- producer configs are documented here: https://kafka.apache.org/documentation.html#newproducerconfigs -->
    <!-- bootstrap.servers is the only mandatory producerConfig -->
    <producerConfig>bootstrap.servers=${SUNBIRD_KAFKA_URL}</producerConfig>
    <!-- don't wait for a broker to ack the reception of a batch.  -->
    <producerConfig>acks=0</producerConfig>
    <!-- wait up to 1000ms and collect log messages before sending them as a batch -->
    <producerConfig>linger.ms=15000</producerConfig>
    <!-- even if the producer buffer runs full, do not block the application but start to drop messages -->
    <producerConfig>max.block.ms=0</producerConfig>
    <!-- define a client-id that you use to identify yourself against the kafka broker -->
    <producerConfig>client.id=${HOSTNAME}-${CONTEXT_NAME}-logback-relaxed</producerConfig>

    <!-- there is no fallback <appender-ref>. If this appender cannot deliver, it will drop its messages. -->

  </appender>
```


After code change:

Below are the logs from staging environment.


```
{"timestamp":"2021-12-08T11:37:47.083Z","msg":"{\"eid\":\"ERROR\",\"ets\":1638963467083,\"ver\":\"3.0\",\"mid\":\"c2e253f4-f3bc-43ad-8b12-dbf223cabe02\",\"actor\":{\"id\":\"internal\",\"type\":\"Consumer\"},\"context\":{\"channel\":\"0126796199493140480\",\"pdata\":{\"id\":\"staging.sunbird.learning.service\",\"pid\":\"learner-service\",\"ver\":\"4.5.0\"},\"env\":\"Organisation\",\"cdata\":[{\"id\":\"c2e253f4-f3bc-43ad-8b12-dbf223cabe02\",\"type\":\"Request\"}],\"rollup\":{}},\"edata\":{\"err\":\"INVALID_PARAMETER_VALUE\",\"stacktrace\":\"BaseController:handleSearchRequest: Exception occurred with error message = Invalid value null for parameter hashTagId. Please provide a valid value. org.sunbird.validator.BaseRequestValidator.lambda$validateListValues$6(BaseRequestValidator.java:293)java.base/java.util.ArrayList.forEach(ArrayList.java:1541)org.sunbird.validator.BaseRequestValidator.validateListValues(BaseRequestValidator.java:287)org.sunbird.validator.BaseRequestValidator.lambda$validateSearchRequestFiltersValues$4(BaseRequestValidator.java:259)java.base/java.util.LinkedHashMap.forEach(LinkedHashMap.java:684)org.sunbird.validator.BaseRequestValidator.validateSearchRequestFiltersValues(BaseRequestValidator.java:249)org.sunbird.validator.BaseRequestValidator.validateSearchRequest(BaseRequestValidator.java:217)controllers.organisationmanagement.OrgController.lambda$search$4(OrgController.java:85)controllers.BaseController.handleSearchRequest(BaseController.java:307)controllers.organisationmanagement.OrgController.search(OrgController.java:80)router.Routes$$anonfun$routes$1$$anonfun$applyOrElse$64$$anonfun$apply$210$$anonfun$apply$211.apply(Routes.scala:2321)router.Routes$$anonfun$routes$1$$anonfun$applyOrElse$64$$anonfun$apply$210$$anonfun$apply$211.apply(Routes.scala:2321)play.core.routing.HandlerInvokerFactory$$anon$6.resultCall(HandlerInvoker.scala:155)play.core.routing.HandlerInvokerFactory$JavaActionInvokerFactory$$anon$10$$anon$2$$anon$1.invocation(HandlerInvoker.scala:116)play.core.j.JavaAction$$anon$1.call(JavaAction.scala:131)play.mvc.Action.lambda$call$0(Action.java:89)java.base/java.util.Optional.map(Optional.java:265)play.mvc.Action.call(Action.java:81)modules.OnRequestHandler$1.call(OnRequestHandler.java:87)play.core.j.JavaAction$$anonfun$10.apply(JavaAction.scala:191)play.core.j.JavaAction$$anonfun$10.apply(JavaAction.scala:191)scala.concurrent.impl.Future$PromiseCompletingRunnable.liftedTree1$1(Future.scala:24)scala.concurrent.impl.Future$PromiseCompletingRunnable.run(Future.scala:24)play.core.j.HttpExecutionContext$$anon$2.run(HttpE\",\"errtype\":\"api_access\",\"requestid\":\"c2e253f4-f3bc-43ad-8b12-dbf223cabe02\"}}","lname":"TelemetryEventLogger","tname":"application-akka.actor.default-dispatcher-4","level":"INFO","HOSTNAME":"learner-77446bc9cb-xf4km","application.home":"/home/sunbird/learner/learning-service-1.0-SNAPSHOT"}

{"timestamp":"2021-12-08T11:46:07.637Z","msg":"{\"eid\":\"LOG\",\"ets\":1638963967637,\"ver\":\"3.0\",\"mid\":\"d4f1803d-c8fc-6a90-31cd-717a3ccaa6c5\",\"actor\":{\"id\":\"91a81041-bbbd-4bd7-947f-09f9e469213c\",\"type\":\"User\"},\"context\":{\"channel\":\"01269878797503692810\",\"pdata\":{\"id\":\"staging.sunbird.portal\",\"pid\":\"learner-service\",\"ver\":\"4.5.0\"},\"env\":\"User\",\"did\":\"ce7e52e72032b6241b55ece9d349b94a\",\"cdata\":[{\"id\":\"d4f1803d-c8fc-6a90-31cd-717a3ccaa6c5\",\"type\":\"Request\"}],\"rollup\":{}},\"edata\":{\"level\":\"info\",\"requestid\":\"d4f1803d-c8fc-6a90-31cd-717a3ccaa6c5\",\"type\":\"Api_access\",\"message\":\"\",\"params\":[{\"method\":\"GET\"},{\"url\":\"/v1/user/managed/91a81041-bbbd-4bd7-947f-09f9e469213c?sortBy=createdDate&order=desc?sortBy=createdDate&order=desc\"},{\"duration\":0},{\"status\":\"OK\"}]}}","lname":"TelemetryEventLogger","tname":"Thread-855","level":"INFO","HOSTNAME":"learner-77446bc9cb-xf4km","application.home":"/home/sunbird/learner/learning-service-1.0-SNAPSHOT"}
```


*****

[[category.storage-team]] 
[[category.confluence]] 
