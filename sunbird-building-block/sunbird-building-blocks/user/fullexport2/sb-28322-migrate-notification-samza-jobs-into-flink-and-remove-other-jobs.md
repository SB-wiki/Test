# SB-28322-Migrate-notification-samza-jobs-into-flink-and-remove-other-jobs

## Requirement

Migrate merge user course job from samza to flink to support development and maintenance consistency with other lern flink jobs.

## Repositories

Samza module repository: [https://github.com/project-sunbird/sunbird-lms-jobs](https://github.com/project-sunbird/sunbird-lms-jobs)

Flink module repository:

**Current Issues:**

Vulnerability issues while upgrading > jdk 1.8, samza supports only jdk 1.8. To resolve this upgrade to flink.

## Description & Approach

Plan is to move this notification-job to new repo “notification-jobs” and migrate from samza to flink and also upgrade from jdk 1.8 to jdk 11. Re-writing the module in Scala with flink framework. No change in functionality.

New repo will contain only notification related flink code, other old samza jobs which are in no-use can be scrapped.

We use this notification flink job for sending notifications(email/sms) asynchronously.

Jenkins Job:

New Jenkins job need to be created under Lern Tab in Jenkins and the job should point to this repo.

Configurations:

Sunbird-Lern/lern-devops (api/jobs)(Environment and API Configurations and ES Mappings, flink job and dataproduct configurations)

Sunbird-Lern/lern-devops-private (api/jobs)

### Details:

```
Introduced NotificationStreamTask to execute task process
Re-written the NotificationService<ISamzaService> as NotificationFunction<BaseProcessKeyedFunction[T, R](config: BaseJobConfig)>
Introduced NotificationConfig for configurations
Using jobs-core/notification-sdk as dependencies
```

### Flink module structure vs Samza module structure:

| Flink module                                                                                | Samza Module                                                                                |
| ------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------- |
| ![](<../../../../User/Fullexport2/images/storage/Screenshot 2022-04-22 at 12.49.11 PM.png>) | ![](<../../../../User/Fullexport2/images/storage/Screenshot 2022-04-22 at 12.52.57 PM.png>) |

### Technologies upgrade:

|   | New module      | Old Module   |
| - | --------------- | ------------ |
| 1 | Flink 1.12      | samza 2.11   |
| 2 | Scala 2.12      | Java 8       |
| 3 | jobs-core 1.0.0 | hadoop 2.6.0 |

## Configurations & Env

```
include "base-config.conf"

kafka {
  input.topic = "kafka.__env__.lms.notification"
  groupId = "kafka.__env__.lms.notification.group"
}

task {
  window.shards = 1
  consumer.parallelism = 1
  dedup.parallelism = 1
  activity.agg.parallelism = 1
  enrolment.complete.parallelism = 1
}
```

Concern:

Topic name is not updated with lern bb

**Remove existing job and test:**

1. Stop the notification-job in the hadoop dashboard.
2.  push the event message into the “{env}.lms.notification” topic

    event message:

```
{"actor":{"id":"BroadCast Topic Notification","type":"System"},"eid":"BE_JOB_REQUEST","edata":{"request":{"notification":{"config":{"sender":"support@sunbird.com","subject":"Completion certificate"},"deliveryType":"message","mode":"email","template":{"data":"Hi","params":{"body":"email body","stateImgUrl":"https://sunbirddev.blob.core.windows.net/orgemailtemplate/img/File-0128212938260643843.png","firstName":"Hari","regards":"Minister of Gujarat","TraningName":"test-cert-notification","regardsperson":"Chairperson","heldDate":"16-12-2019"}},"ids":["harip@ilimi.in"]}},"action":"broadcast-topic-notification-all","iteration":2},"trace":{"X-Request-ID":null,"X-Trace-Enabled":"false"},"context":{"pdata":{"ver":"1.0","id":"org.sunbird.platform"}},"mid":"NS.1646230422793.70c10f26-631b-4d55-8aaa-fbe52b79cbc1","object":{"id":"93a06b829d13c9fa797ea641f484e5d38ce28868fbd75014852cbe413515177c","type":"TopicNotifyAll"}}
```

3. The above message should trigger a mail to the mentioned email-id

***

\[\[category.storage-team]] \[\[category.confluence]]
