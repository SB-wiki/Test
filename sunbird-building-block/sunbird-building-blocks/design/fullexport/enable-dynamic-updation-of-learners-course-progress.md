# Enable-dynamic-updation-of-learners'-course-progress

**Introduction** This wiki explains current design of course batches, problems with it and proposed changes to the design and implementation to resolve the current issues and able to handle scale.

**Background & Problem statement:** In current state changes stored in lms service are not reactive to any changes in the course content. This structure creates the issue when some of the contents changes and Sunbird uses locally stored copy of the content. For example, Once the user has completed the full course, if any unit is added or removed from the course, the changes are not dynamically reflected. There are use cases to enable this.

[SB-12089 System JIRA](https://browse/SB-12089)

![](<../../../../Design/FullExport/images/storage/Untitled drawing (1).png>)

**Key Design Problems:** 1. Easy way to maintain course details for a batch.

2. Better handling of course progress computation.
3. Easy to fetch data for given course or batch or user.

**Design:** **Managing Course Details:** Batches are created for a course. Course details are most of the time constant but, when the creator publishes it the data will be updated. So, copying the course details and saving along with course batch and user\_courses is not good.

Option 1: Maintain **cache** with ttl

Option 2: Always **fetch** it from source

#### Solution Approach

A complete solution can be divided into below points

1. remove the course data stored into db (ex. leafNodeCounts, courseName, tocUrl etc.)
2. Restructure the DB tables and corresponding ES
3. migrate the old data according to new structure
4. Code changes in accordance with the restructured data model
5. Change the sync process of user progress update to an async process with the help of kafka messaging.

Current DB structure related to course batch progress **course\_batch  (ES → cbatch)**

| column               | type                | description | used | indexed | can be removed |
| -------------------- | ------------------- | ----------- | ---- | ------- | -------------- |
| id                   | text                | batchid     |      | PK      |                |
| countdecrementdate   | text                |             |      |         |                |
| countdecrementstatus | boolean             |             |      |         |                |
| countincrementdate   | text                |             |      |         |                |
| countincrementstatus | boolean             |             |      |         |                |
| coursecreator        | text                |             |      | Y       |                |
| courseid             | text                |             |      | Y       |                |
| createdby            | text                |             |      |         |                |
| createddate          | text                |             |      |         |                |
| createdfor           | list                |             |      |         |                |
| description          | text                |             |      |         |                |
| enddate              | text                |             |      |         |                |
| enrollmenttype       | text                |             |      | Y       |                |
| hashtagid            | text                |             |      |         |                |
| mentors              | list                |             |      |         |                |
| name                 | text                |             |      |         |                |
| participant          | map\<text, boolean> |             |      |         |                |
| startdate            | text                |             |      |         |                |
| status               | int                 |             |      | Y       |                |
| updateddate          | text                |             |      |         |                |

**content\_consumption**

| column            | type      | description                                     | used | indexed | can be removed |
| ----------------- | --------- | ----------------------------------------------- | ---- | ------- | -------------- |
| id                | text      | hash of userid, batchid, courseid and contentid |      | PK      |                |
| batchid           | text      |                                                 |      |         |                |
| completedcount    | int       | how many time the content was completed         |      |         |                |
| contentid         | text      |                                                 |      | Y       |                |
| contentversion    | text      |                                                 |      |         |                |
| courseid          | text      |                                                 |      | Y       |                |
| datetime          | timestamp |                                                 |      |         |                |
| grade             | text      |                                                 | N    |         | Y              |
| lastaccesstime    | text      |                                                 |      |         |                |
| lastcompletedtime | text      |                                                 |      |         |                |
| lastupdatedtime   | text      |                                                 |      |         |                |
| progress          | int       | progress pushed                                 |      |         |                |
| result            | text      |                                                 | N    |         | Y              |
| score             | text      |                                                 | N    |         | Y              |
| status            | int       | 1 for progress 2 for completed                  |      | Y       |                |
| userid            | text      |                                                 |      | Y       |                |
| viewcount         | int       | how many times user viewed the content          |      |         |                |

**user\_courses (ES → usercourses)**

| column                | type      | description                          | used | indexed | can be removed |
| --------------------- | --------- | ------------------------------------ | ---- | ------- | -------------- |
| id                    | text      | hash of userid, batchid and courseid |      | PK      |                |
| active                | boolean   | turns false when user unenroll       |      |         |                |
| addedby               | text      |                                      |      |         |                |
| batchid               | text      |                                      |      | Y       |                |
| completedon           | timestamp |                                      |      |         |                |
| contentid             | text      |                                      |      |         |                |
| courseid              | text      |                                      |      | Y       |                |
| courselogourl         | text      |                                      |      |         | Y              |
| coursename            | text      |                                      |      | Y       | Y              |
| datetime              | timestamp |                                      |      |         |                |
| delta                 | text      |                                      | N    |         | Y              |
| description           | text      |                                      |      |         | Y              |
| enrolleddate          | text      |                                      |      |         |                |
| grade                 | text      |                                      | N    |         | Y              |
| lastreadcontentid     | text      |                                      |      |         |                |
| lastreadcontentstatus | int       |                                      |      |         |                |
| leafnodescount        | int       |                                      |      |         | Y              |
| progress              | int       | count of content completed           |      |         |                |
| status                | int       | 1 for progress 2 for completed       |      | Y       |                |
| tocurl                | text      |                                      |      |         | Y              |
| userid                | text      |                                      |      |         |                |

**DB Changes approach 1**

Remove unused column from user\_courses and move the content\_consumption as a map into the user\_courses table.

Steps involved

1. We cannot change the primary key of the table in cassandra, hence we would need to copy the data, drop the table, recreate the table with old data

```
COPY sunbird.user_courses (batchid,userid,courseid,contentid,active,addedby,datetime,enrolleddate,lastreadcontentid,lastreadcontentstatus,status,completedon) TO '../files/usercourses.csv' WITH HEADER = TRUE;

DROP TABLE sunbird.user_courses;

CREATE TABLE IF NOT EXISTS sunbird.user_courses(batchid text, userid text, courseId text, contentid text, active boolean, addedBy text, dateTime timestamp, enrolledDate text,lastReadContentId text,
lastReadContentStatus int,status int, completedon timestamp, contentconsumption map<text,frozen<map<text,text>>>, PRIMARY KEY (batchid,userid));

CREATE INDEX inx_ucs_userid ON sunbird.user_courses (userid);
CREATE INDEX inx_ucs_courseid ON sunbird.user_courses (courseid);
CREATE INDEX inx_ucs_status ON sunbird.user_courses (status);
CREATE INDEX inx_ucs_content_consumption ON sunbird.user_courses (contentconsumption);

COPY sunbird.user_courses (batchid,userid,courseid,contentid,active,addedby,datetime,enrolleddate,lastreadcontentid,lastreadcontentstatus,status,completedon) FROM '../files/usercourses.csv' WITH HEADER = TRUE;
```

2. Run a migration to copy from content\_consumption to user\_courses contentconsumption column as a map of map (can be a talend ETL job)
3. Code changes corresponsing to new DB structure
4. Progress can be calculated from contentconsumption column of user\_courses
5. Corresponsing mapping changes in ES

**Pros**

1. all the user progress and content consumption is in the same row eradicates ambiguity.
2. easier to get the data based on batchid as it's the partition key, or batchid and userid.
3. A migration of data from content\_consumption to user\_courses will be needed.&#x20;

**Cons**

1. the content/state/read is hampered as there is no way to output certain map component, hence the filtering of contents needs to be done in java, which is an overhead.
2. Related to above point, secondary indexes and data centralization is anti-pattern in cassandra.

**DB Changes approach 2**

This approach requires minimum db changes and no migration as we holds all the user\_courses related info in user\_courses as progress as map\<text,int> which defines if a particular content is read or completed. Hence there is no reliance on content\_consumption.

Any call to update the user progress will be forwarded to both the table user\_courses and content\_consumption. All the user course progress would be read from user\_courses whereas content\_consumption would be holding data as audit and for content/state/read call.

Currently we first put data into content\_consumption and then based on it the entry is made into user\_courses which is creating problems.

**Pros**

1. content/state/read would be efficient with userid as partition key and batchid/courseid as cluster key
2. no migration needed
3. user\_courses will hold sufficient info to show a user's current progress.

**Notes**

→ Since sunbird will no longer store course info, all the course info would be fetched at runtime from KP.

→ A user's current progress and updates will be calculated whenever the api call happens, hence would provide updated state

→ Since sunbird would not be holding course details (like leafnodecount), all the background processes as configured in analytics team would need to fetch latest course details and would need to calculate the progress based on stored progress.

***

\[\[category.storage-team]] \[\[category.confluence]]
