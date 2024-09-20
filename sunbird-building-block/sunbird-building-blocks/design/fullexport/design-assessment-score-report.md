# \[Design]-Assessment-score-report

**Introduction:** This documentation describes about the generation of the batch wise assessment report within the course. The report should generate with below fields. For more detail refer this \[\[ PRD|Assessment-Score-Report]].

```js
External ID //  External ID is the state ID provided by state for a teacher
User ID // User Identifier
User Name 
Email ID
Mobile Number
Organisation Name
District Name
School name 
Assessment Name // Name of the assessment/worksheet/content 
Total Score // Total score of the all assessment in a course( Eg: 2/3+3/4+2/3=7/10 )
```

\*\* \*\* **Solution -1: Assessment Samza job and Data product**

**Diagram:**

![](<../../../../Design/FullExport/images/storage/Screenshot 2019-08-26 at 6.01.37 PM.png>)

As per the above diagram, Router job should route all ASSESS events into Assessment Samza Job which compute and update the RDBMS table.The assessment data product which read and joins the data from multiple tables and will generates the assessment report per batch and uploads to azure cloud storage.

```js
 usr_external_identity // To get the user external id information
 user // to get the user information
 course_batch // To get the details about the batch enrolled to course
 user_courses // To get the information about the user enrolled to courses
 user_org // to get the user organisation details
 assessment_profile (new) // Assessment result
```

**Disadvantages** :

1. When pipeline is having huge lag,Then report will be wrong  &#x20;

**Solution - 2: API and Data product**

![](<../../../../Design/FullExport/images/storage/Screenshot 2019-08-27 at 11.31.56 AM.png>)

As per the above diagram, End user will sync the assess events through api, which will update the database with computed values. The assessment data product which read data from the database and will generate the reports per batch and uploads to azure cloud storage.

**Assessment update API:**

```js
METHOD: PATCH 
URI: /v1/content/state/update // End point
REQUEST: {
    "request": {
        "contents": [ ],
        "assessments": [
            {
 				"assessmentTs": 1567591211000, //Assessment time in epoch
                "batchId":"", // Batch Identifier - required
				"courseId":"", // Course Identifier - required
	  			"userId":"",  // User Identifier - required
	  			"attemptId":"", // Attempt Identifier - required
	  			"contentId": "", // Content Identifier - required
                "events": [ ] //ONLY ASSESS Events - required
            }
        ]
    }
}
```

**Request Structure:**

Events related to particular to batchId, courseId, userId, attemptId, contentId should be grouped together while calling this API.

**attemptId:** Should be generated from Hashing HASH(courseId, userId, contentId, batchId)

```js
{
    "id": "api.content.state.update",
    "ver": "v1",
    "ts": "2019-09-04 12:47:08:954+0000",
    "params": {
        "resmsgid": null,
        "msgid": "bec2defc-ddca-7b37-6a24-1dcbdfb23d48",
        "err": null,
        "status": "success",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "<contentId>": "SUCCESS"
    }
}
```

**Disadvantages** :

1. Need to validate and de-dup the the events.

**Table Schema:** **Question object :**

```
CREATE TABLE assessment_aggregator (
    batch_id text,
    user_id text,
    course_id text,
    content_id text,
    attempt_id text,
    updated_on timestamp,
    created_on timestamp,
    last_attempted_on timestamp,
    total_score int,
    total_max_score int,
    question list<frozen<question>>,
    PRIMARY KEY (content_id, attempt_id, user_id, course_id, batch_id )
)

CREATE INDEX ON assessment_aggregator (last_attempted_on);

CREATE TYPE question(
    id text,
    max_score int,
    score int,
    type text,
    title text,
    resvalues list<map<text,text>>,
    params list<map<text,text>>,
    description text,
    duration decimal
);



```

**Challenges:** \*\* \*\*

1. How to capture the attempts? i.e. Number of times the particular user is attempted particular question.&#x20;
2. How to capture the batch-id and course-id

### **Conclusion** :

**Analytics team:**

1. Analytics team will store the attempts as a blob in the database and all the event data related to the questions will be stored in the blob.
2. Analytics team will implement a API to ingest assessment related data. The API will take course\_id and batch\_id and a batch of ASSESS events.
3. The API will route the events to a separate Kafka topic. A new Samza job will process these events and load the summarized data into the database. Each record will correspond to a attempt\_id for a worksheet. The record will also contain overall score for the attempt\_id.
4. Postgres might not scale for the number of ASSESS events every day. Cassandra will be used to store the summarized data.

**Portal/Mobile** (Estimations have not been accounted for the following tasks):

1. Currently, the question id is auto generated every time the worksheet is played. Content player needs to fix it and use the do\_id for the questions.
2. Mobile and portal will have to send the attempt id in cdata both in the case of practice questions and exams. Currently, a new attempt id can be generated every time the worksheet is played. However, in future the exams will need to have the same attempt id passed until the assessment is submitted.
3. Mobile/Portal should figure out a way to call the assement score computation API only for assessments worksheets.

***

\[\[category.storage-team]] \[\[category.confluence]]
