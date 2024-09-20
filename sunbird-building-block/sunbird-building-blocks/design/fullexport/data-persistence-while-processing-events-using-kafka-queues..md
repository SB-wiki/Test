# Data-Persistence-while-processing-events-using-kafka--queues.

#### What is Data Persistence ?

Persistent data in the field of data processing denotes information that is infrequently accessed, not likely to be modified and should be not lost before processing valuable information from it.

#### Why we need Kafka Queues for processing events ? what is wrong with present technique or architecture ?

We are using asynchronous calls to update and create various attributes associated with user, org etc. This create and update operations are done in background using the actor operations.  The case of failure "failed to process the background calls" will leads to data inconsistency, And this is a very major issue as we have only process half of the task and assured the requester with a success message. We can use queuing which will be not in memory so if at any point service fails to work or stops we will able to process the background task as soon as service restarts. This will give 99.9% assurance that data will be processed and it is what we need .

**Approaches for implementing Kafka queues for background data task.**

#### Approach 1: Using a Utility to refine data and send it to queue.

In this approach we will be sending data in queue after refining it into a small and more informative, In this approach assurance of  data consistency and event processing is very good. If we are using 3 clusters or nodes we will be having 95-97% assurance that message will be processed in any case other than all 3 clusters or nodes go Down or stop working. This assurance can be increased up to 97-99% by using 5 cluster or nodes . By increasing the cluster or nodes we are decreasing the failure chances, But still we have a situation where all the clusters or  nodes in KAFKA goes down or stops working. If all the nodes are not working at the same time then our events will be lost and we will be having a situation from where we will introduce inconsistent data into our database , which we do not want at any cost.&#x20;

Probability of failure of all   3 nodes is more than failure of all 5 nodes, but if we follow regular health checkups processes of machines where we are running clusters or nodes , this probability of failure of all node at once will we down to 0.1%.

#### Approach 2 : Using Utility to refine data , write it to a file and use Logstash to process events to Kafka.

In this approach we will be writing events into a file after refining them. Logstash will read this events and will send it to kafka queue. In this approach if all the nodes in Kafka are not available at the same time , Logstash will wait to process events till any of the cluster or node comes alive.  Logstash will keep track of the events by managing an offset and will process them in sequential manner. This will give us assurance of data consistency and event processing with considering the case of Kafka cluster or nodes failure all at the same time.

what if Kafka is up and Logstash is not able to send it to queue due to some message construction error ?

This will the scenario where message construction logic is wrong , For this we can set an alarm so that we will be able to look in it as soon as possible, and reprocesses them.

**Writing to a file will not work fine if we run service in a docker container, as for each deployment it will remove the old data in the file.**

So we can use S3 / Cassandra / azure for keeping event messages and Logstash will read it .

**Compatibility of AWS S3 / Cassandra /Azure with Logstash:**

1.  **AWS S3 :** It is compatible with Logstash as organization involved in development and maintenance of logstash it self provide plugin to read events from a S3 file.

    more details can be found on this link [https://www.elastic.co/guide/en/logstash/5.3/plugins-inputs-s3.html](https://www.elastic.co/guide/en/logstash/5.3/plugins-inputs-s3.html) .

    Provided Configuration details are descriptive.
2.  **CASSANDRA** : It is compatible with Logstash by using JDBC plugin provided by the  organization who owns Logstash .

    more details can be found on this link [https://www.elastic.co/guide/en/logstash/current/plugins-inputs-jdbc.html](https://www.elastic.co/guide/en/logstash/current/plugins-inputs-jdbc.html) .

    Provided configuration details are very descriptive but too much complex and need more resources than AWS S3 approach. Further more we have to explicitly add the JDBC driver and define each and every configuration details.

    We also have to mention QUERIES for how message event should be taken out and what to do with already processed messages. It is a slow process as it will need frequent database calls. also we have to update the database for processed messages.

    If we use this approach we have to write the message events into database which is more expensive than writing it to file, Also we have to take care of database clean up as data will always grow and will be useless after sometime.
3.  **AZURE :**  It is compatible with Logstash by using this plugin reads and parses data from Azure Storage Blobs : [https://github.com/Azure/azure-diagnostics-tools/tree/master/Logstash/logstash-input-azureblob](https://github.com/Azure/azure-diagnostics-tools/tree/master/Logstash/logstash-input-azureblob) , which is developed and maintained by Microsoft .

    Easy to install and use . Same as AWS S3 . Performance analysis in respect to AWS S3 not known, Not much used  as AWS S3.

    &#x20;

**Approaches to implement event processing :**

#### Approach 1:  Sending complete message received after processing the actor call.

This will have so much unwanted data which is not required. But will have fast processing without using any utility to convert it to more valuable. Further this we have to send multiple events in the queue for each background operation, so more messages will be in queue and consumer have to be not so intelligent to process them, because each message will have a define task. But in this approach we have to send multiple events which is a non reliable process as for example : we have to sending 10 messages for a foreground event and  we are only able to send 5 messages and service stops running, so only partial update and create operation will take place.

#### Approach 2:  Sending refined message after processing the actor call using a Utility .

We have to create a utility which helps us in generating event message, which will be logically more efficient . By using a util we can generate a simple event message with all the required data to be processed or reused. We can logically group the background operations, So the intelligent consumer will read it and process all the background operations as per define logic. This will remove any chance of partial data update or create. Further on consumer side we can have a Storage where we can put all the event messages which were not processed successfully or had some errors, so we can study them to improve our implementation.

We will be having two type of event messages :

1. Transaction : single and grouped events
2. Informative : single events.

**Logically grouping of operations :** \*\* \*\* Logical grouping of operations can be Done using

```
      API:            ES                                   Tables cassandra
#. create user->user,userprofilevisibility->(user,usr_external_identity,user_job_profile,address,user_educations,user_org)
#. update user->user,userprofilevisibility->(user,usr_external_identity,user_job_profile,address,user_educations,user_org)
#. block user->user -> (user)
#. userBulkUpload->user->user,userprofilevisibility->(bulk_upload_process_task,bulk_upload_process, all tables from create user)
#. unblock user-> user->(user)
#. updateLoginTime-> user->(user)
#. accept tnc-> user-> (user)
#. addUserToOrg-> user-> (user-org)
#. removeUserFromOrg -> user->(user-org)
#. AssignRoles -> user-> (user-org)
#. CreateOrg-> org -> (organisation,org_external_identity,address)
#. org bulk upload  -> org -> (bulk_upload_process_task,bulk_upload_process,organisation,org_external_identity)
#. update org -> org -> (organisation,org_external_identity,address)
#. update org status -> org -> (organisation)
#. create user notes -> usernotes -> (user_notes)
#. update user notes -> usernotes -> (user_notes)
#. delete user notes -> usernotes -> (user_notes)
#. create batch -> batch,usercourses,user -> (course_batch,user_courses)
#. update batch -> batch,usercourses,user -> (course_batch,user_courses)
#. add user to batch -> batch,usercourses,user -> (course_batch,user_courses)
#. remove user to batch -> batch,usercourses,user -> (course_batch,user_courses)
#. enroll batch -> batch,usercourses,user ->    (course_batch,user_courses)
#. unenroll batch -> batch,usercourses,user ->  (course_batch,user_courses)
#. update content status -> content,user ->     (course_batch,user_courses)
#. location bulk upload -> location ->  (bulk_upload_process_task,bulk_upload_process,location) 
#. location create -> location ->   (location)
#. location update -> location ->   (location)
#. data sync api  -> user, org, batch,usercourses -> (complete user, org or batch or user courses)
#. Create issuer                
#. Delete issuer
#. Create badge class
#. Delete badge class
#. Create badge assertion
#. Delete badge assertions
#. link badge to content   - > badgeassociations - > (content_badge_association)
#. unLink badge to content -> badgeassociations -> (content_badge_association)
#. Add user skills ->         user              -> (user_skills,skills)
#. endorse user skill
#. Object create
#. Object update
#. Object delete
#. System settings
#. Generate OTP
```

***

\[\[category.storage-team]] \[\[category.confluence]]
