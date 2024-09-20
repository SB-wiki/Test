# \[Design]-Assessment-Consumption-Table-Changes-to-Support-the-Archival-Process

### Introduction

This document outlines the design of archiving assessment aggregation data and ways to compute the score metrics after archiving the assessment data, providing the support to exhaust jobs and API's

Problem StatementWe are archiving the assessment data irrespective of batch status whether the batch is active or not. Since the rapid growth in the assessment data of the Cassandra table, it’s problem to compute score metrics like best score etc..,

Below are the key design problems

* Handling of content state update API’s
* How to compute the score metrics example best attempt score
* Supporting of response exhaust job

### Design

**Table Changes - Deprecating the question object in the table**

The current table name is the assessment aggregator which stores the raw data of the assessment.

The context name of the table and the data being stored in the table which is mismatching. We will be deprecating the question object from the existing assessment aggregator table to store only assessment aggregated information.

**Assessment Agg Table**

```py
CREATE TABLE sunbird_courses.assessment_aggregator (
    user_id text,
    course_id text,
    batch_id text,
    content_id text,
    attempt_id text,
    created_on timestamp,
    grand_total text,
    last_attempted_on timestamp,
    total_max_score double,
    total_score double,
    updated_on timestamp,
    PRIMARY KEY ((user_id, course_id), batch_id, content_id, attempt_id)
) WITH CLUSTERING ORDER BY (batch_id ASC, content_id ASC, attempt_id ASC);
```

The above table is the current assessment aggregator table we will be deprecating the question column from it.

**Assessment raw table**

```py
CREATE TABLE sunbird_courses.assessment_raw (
    user_id text,
    course_id text,
    batch_id text,
    content_id text,
    attempt_id text,
    created_on timestamp,
    grand_total text,
    last_attempted_on timestamp,
    question list<frozen<question>>,
    total_max_score double,
    total_score double,
    updated_on timestamp,
    PRIMARY KEY ((user_id, course_id), batch_id, content_id, attempt_id)
) WITH CLUSTERING ORDER BY (batch_id ASC, content_id ASC, attempt_id ASC);
```

The above table is a raw table that stores all assessment raw data. The job should store the all event question object without deduping the question identifiers in the question column.

**Archival Process - High-Level Diagram of Archival Process**

![](<../../../../Analytics/Fullexport/images/storage/final diagram.png>)

The above diagram illustrates the archival process, generating score metrics. The content state read API which read from the assessment agg table, the assessment flink job which writes the raw data into assessment raw table, aggregated data into assessment agg table and score metrics data into activity agg table.

The response exhaust job reads both archived data and raw data from the cloud storage and raw table respectively to generate the response exhaust report.

The progress exhaust job reads the score metrics from the activity agg table to generate the progress report.

**Migration Activities**

* Write a migration script to migration score metrics into the activity agg table.
* Write migration script create raw table and populate all the records into assessment agg table

**Conclusion**

Instead of creating a new raw table, we will store all attempts score related information in the activity agg table by creating a new extra column in map format.

***

\[\[category.storage-team]] \[\[category.confluence]]
