
## Overview
With the current data we have for courses enrolments, the updates and reads from elastic search is becoming a costly operation in terms of scalability. This could be resolved by reading data from cassandra only as it is the primary datastore.

The impacted APIs are:


1. Open batch enrolment


1. Open batch un-enrolment


1. User enrolment List


1. Content State Update




## Implementation Design
The existing table structure of sunbird_courses.user_courses table has batchid as partitionKey and userid as clusteringKey. With this structure, it is not good to fetch the data based on userId.

Thus, by making userid as partitionKey and courseid and batchid as clusteringKey, it is easy to fetch the data using userId, and also validation is easy with userId and courseId combination.

Below is the new table structure.


```
CREATE TABLE sunbird_courses.user_enrolments (
	    userid text,
	    batchid text,
	    active boolean,
	    addedby text,
	    certificates list<frozen<map<text, text>>>,
	    completedon timestamp,
	    completionpercentage int,
	    contentstatus map<text, int>,
	    courseid text,
	    datetime timestamp,
	    delta text,
	    enrolleddate text,
	    grade text,
	    lastreadcontentid text,
	    lastreadcontentstatus int,
	    progress int,
	    status int,
	    PRIMARY KEY (userid, courseid, batchid)
	) WITH CLUSTERING ORDER BY (batchid ASC)
	    AND bloom_filter_fp_chance = 0.01
	    AND caching = {'keys': 'ALL', 'rows_per_partition': 'NONE'}
	    AND comment = ''
	    AND compaction = {'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy', 'max_threshold': '32', 'min_threshold': '4'}
	    AND compression = {'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor'}
	    AND crc_check_chance = 1.0
	    AND dclocal_read_repair_chance = 0.1
	    AND default_time_to_live = 0
	    AND gc_grace_seconds = 864000
	    AND max_index_interval = 2048
	    AND memtable_flush_period_in_ms = 0
	    AND min_index_interval = 128
	    AND read_repair_chance = 0.0
	    AND speculative_retry = '99PERCENTILE';
	CREATE INDEX inx_ucs_status ON sunbird_courses.user_courses (status);
	CREATE TRIGGER batch_enrollment_trigger ON sunbird_courses.user_courses USING 'org.sunbird.cassandra.triggers.TransactionEventTrigger';
```
Along with the new table, the following changes needs to be made.


1. Migration of data from user_courses table to user_enrolments, using data copy from csv.


1. Course-batch-updater and course-certificate-generator jobs need to read from and write to new table.


1. Course progress metrics job need to read data form new table.






### TODOs:

1. Update certificates column data type with map<text, map<text, text>>


1. Deprecate completionPercentage and status columns and computation of values for these two is done at client side.


1. Re-validate the need of sunbird_courses.content_consumption table, as we have contentStatus column.





*****

[[category.storage-team]] 
[[category.confluence]] 
