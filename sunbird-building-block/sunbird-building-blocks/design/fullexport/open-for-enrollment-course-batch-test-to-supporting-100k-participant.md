# Open-for-enrollment-course-batch-test-to-supporting-100K-Participant--

This documents is about the POC done on limitation of course batch. By term " limitation of course batch" here we  mean how many participants can enroll in an open-batch.

We only considered the limitation for storing and retrieving data from a course batch using existing API. We also looked for any type behavior change in the response and time taken by the existing API for a course batch which have arguably large number of participants.

This experiment was done on a local machine having 8 GB of RAM and Intel® Core™ i5-6300U CPU @ 2.40GHz × 4  quad core processor running a UBUNTU OS 16.04-64bit.

The Software and service running during this experiment were listed below :

1. Sunbird-learner-service (not in docker).
2. Cassandra
3. Elastic search
4. Keycloak
5. Eclipse-IDE
6. Mozilla Firefox

### What are the limitations for the course batch ?

No logical limitation is specified in the source code, so the limitation comes into play through services/plugin/Data-Bases etc.

1. **Elastic search** : There is a max http request size in the ES GitHub code, and it is set against Integer.MAX\_VALUE or 2^31-1. So, basically, **2GB is the maximum document size for bulk indexing over HTTP** . And also to add to it, ES does not process an HTTP request until it completes. So Considering this our course batch document should not exceeds 2GB .
2.  **Cassandra** :  The limits mentioned for Cassandra in the documentation for version 3.0 can be found here [https://docs.datastax.com/en/cql/3.3/cql/cql\_reference/refLimits.html](https://docs.datastax.com/en/cql/3.3/cql/cql\_reference/refLimits.html) .

    so in our cassandra DB  we have the following table structure to save course batch details .

```
CREATE TABLE sunbird.course_batch (
    id text PRIMARY KEY,
    countdecrementdate text,
    countdecrementstatus boolean,
    countincrementdate text,
    countincrementstatus boolean,
    courseadditionalinfo map<text, text>,
    coursecreator text,
    courseid text,
    createdby text,
    createddate text,
    createdfor list<text>,
    description text,
    enddate text,
    enrollmenttype text,
    hashtagid text,
    mentors list<text>,
    name text,
    participant map<text, boolean>,
    startdate text,
    status int,
    updateddate text
) WITH bloom_filter_fp_chance = 0.01
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
CREATE INDEX inx_cou_bat_coursecreator ON sunbird.course_batch (coursecreator);
CREATE INDEX inx_cou_bat_courseid ON sunbird.course_batch (courseid);
CREATE INDEX inx_cou_bat_status ON sunbird.course_batch (status);
CREATE INDEX inx_cou_bat_createdby ON sunbird.course_batch (createdby);
CREATE INDEX inx_cou_bat_enrolmenttype ON sunbird.course_batch (enrollmenttype);
```

We have **participants** as MAP, limits defined in the **cassandra doc** are 65535 values can be added . So to check this we have to break this only mentioned point of failure.

**Process of Checking Limit :**  Create more than 65535 Users in the service and add them to batches.

Script were used to create a user and enroll it in a course batch.

Script were basically making API calls to create user and enroll them into specific batch with all valid data.

#### **Result After exceed the defined limit** :&#x20;

we were successfully able to add more than 65535 user in a single course batch . Practically we added almost 70K users to a course batch. While the whole process of enrolling users into a course batch no errors were found in the logs of elastic search, cassandra, keycloak , sunbird-learner-service.

we cross check the user enrolled in the course batch using this APIs :

1. v1/course/batch/read/:batchid.
2. v1/course/batch/search.

**Following were also cross checked by extracting data out of cassandra, count from both were found to be same and were way more than 65355.**

**API Response  Result time and data size for various size of course batches :**

```
Participants		   Size				    get Batch response 				batch search response			
										    (best-worst)			        (best-worst)
5 k                    252.430 KB	 		12-113 ms          		        19-40 ms                      
10 k                   430 KB 				30-160 ms 				        50-255 ms                     
30 k                   1.28 MB 	            140-935 ms		 		        156-280 ms                    
50 k                   2.12 MB		        401-4984 ms			            400-890 ms
70 k 				   2.80 MB 			    950-8818 ms           	        540-1250 ms
                    
```

Sample CourseBatch data which have more than 65535 participants from cassandra : [https://drive.google.com/file/d/1vQHV2QMhEY140pnzhKiTJuLJTxzGTUCW/view?usp=sharing](https://drive.google.com/file/d/1vQHV2QMhEY140pnzhKiTJuLJTxzGTUCW/view?usp=sharing)

File is too big to upload or render here.

### Changes Required for enrolling 100k user into a course batch :

*   Change of data structure from MAP to LIST for storing participant. This will be done in both cassandra , ElasticSearch.

    \*  Migration of older participant required.
* Portal team need to redesign UI or some change in UI to accommodate the respective changes.
* &#x20;For open batch response participant list can be discarded.

***

\[\[category.storage-team]] \[\[category.confluence]]
