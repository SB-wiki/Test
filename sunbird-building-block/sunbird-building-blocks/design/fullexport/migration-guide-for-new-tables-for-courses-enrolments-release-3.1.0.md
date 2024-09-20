
## Overview
To reduce the usage of elasticsearch, the cassandra schema for user enrolments and course consumption were re-structured. 

Please follow the below steps to migrate the existing data needs to be migrate to the newly created tables.


## Steps to Follow:
Below steps need to be executed in the same order as it is mentioned.


* Create new tables using jenkins job


* Bring down LMS service and samza jobs


* Execute Migration script


* Validate data count


* Deploy LMS and samza from latest release tag.



1. Create New tablesBuild and deploy Core/Cassandra jenkins job,  to create the user_enrolments and user_content_consumption  tables. 

The schema for the tables is given below.


```
CREATE TABLE sunbird_courses.user_enrolments (
    userid text,
    courseid text,
    batchid text,
    active boolean,
    addedby text,
    certificates list<frozen<map<text, text>>>,
    completedon timestamp,
    completionpercentage int,
    contentstatus map<text, int>,
    datetime timestamp,
    enrolleddate text,
    lastreadcontentid text,
    lastreadcontentstatus int,
    progress int,
    status int,
    PRIMARY KEY (userid, courseid, batchid)
) WITH CLUSTERING ORDER BY (courseid ASC, batchid ASC);
CREATE INDEX inx_ues_status ON sunbird_courses.user_enrolments (status);
CREATE INDEX inx_ues_certs ON sunbird_courses.user_enrolments (values(certificates));


CREATE TABLE sunbird_courses.user_content_consumption (
    userid text,
    courseid text,
    batchid text,
    contentid text,
    completedcount int,
    datetime timestamp,
    lastaccesstime text,
    lastcompletedtime text,
    lastupdatedtime text,
    progress int,
    status int,
    viewcount int,
    PRIMARY KEY (userid, courseid, batchid, contentid)
) WITH CLUSTERING ORDER BY (courseid ASC, batchid ASC, contentid ASC);
CREATE INDEX inx_ucc_status ON sunbird_courses.user_content_consumption (status);
```
2. Bring down services and jobsIn order to stop the further requests to the old table before the start of data migration, the following has to be performed.


* Stop LMS service.


* Stop course-batch-updater, course-certificate-generator and merge-user-courses  samza jobs



3. Data MigrationIf spark is available, login to spark machine. Else, download spark from [here](https://www.apache.org/dyn/closer.lua/spark/spark-3.0.0/spark-3.0.0-bin-hadoop2.7.tgz), to the preferred instance.

Follow the below mentioned steps for data migration.


```
> vi CourseDataMigration.scala 
> copy data from https://github.com/Sunbird-Ed/sunbird-data-products/blob/release-3.1.0/adhoc-scripts/src/main/scala/CourseDataMigration.scala and paste it to  CourseDataMigration.scala
> cd to the spark directory
> bin/spark-shell --master local[*] --packages com.datastax.spark:spark-cassandra-connector_2.11:2.5.0 --conf spark.cassandra.connection.host={{cassandra_IP}}
> :load {{absolute path of CourseDataMigration.scala}}
> CourseDataMigration.migrateUserCourses(sc)
after the above call
> CourseDataMigration.migrateContentConsumption(sc)
```
4. Data count validationValidate the below log statement printed from the above job execution, for data counts match.

For user_enrolments, the log statements are user_courses data Count : and user_enrolments count post migration:

For user_content_consumption, the log statements are content_consumption data Count : and content_consumption data Count :

5. Deploy service and jobsPost successful migration, deploy LMS service and samza job from latest release tag.


## Testing
The metrics like, db counts are available in the console logs of the script execution. 

The time taken to execute is based on the size of the tables. 

For a test execution of 412million records, in an infra setup with 16 core 64 GB RAM, the time taken to complete migration is 3 hrs 30 mins.





*****

[[category.storage-team]] 
[[category.confluence]] 
