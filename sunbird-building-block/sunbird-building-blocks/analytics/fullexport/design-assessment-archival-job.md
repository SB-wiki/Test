# \[Design]-Assessment-Archival-Job

**Introduction:** This wiki discusses how to manage growing raw assessment table data, as well as how to handle dependent services/jobs like exhaust jobs, flink jobs and API's.

**Background & Problem statement:** The diagram below describes the process of capturing the users' attempts data at answering questions, as well as the data and the services that are dependent on the assessment table.

![](<../../../../Analytics/Fullexport/images/storage/Assessment Consumption Archival@2x.png>)When users attempt questions for a certain course/batch, we created a data store to keep all of the attempted records for analytics purposes.

As the number of users grows, the amount of data generated grows as well, and some services rely on reading only aggregate score metrics rather than the entire raw assessment data. As a result, the cost of the data store is rising, and maintenance is becoming more difficult.

**For example** - if \~1 million active users take 5 attempts in one of the courses, we will save \~5 million attempts data in the assessment table.

The services which are dependent on the tables will use these attempts data until the course is active. When a course is no longer active, these data are rarely used by services.

**Key Design Problems:**

* Data Archival Process
* Assessment Archival policies based on object category
* Handling of failure scenarios while archiving the data
* Archival metadata store
* Support on reports jobs, API’s backwards compatibility after the archiving data.
* The generalisation of data archival to support other data to archival (ex: Progress Archival)

**Design:** **Data Archival Data Product:** The data product will be divided into two parts

* Archiving of the data
* Deletion of only archived data

**Archiving of the data:** The data archival data product runs every start of the week to archival the previous week data or the job which runs at the start of the week to archive the previous N weeks data.

![](<../../../../Analytics/Fullexport/images/storage/Assessment Consumption Archival@2x (1).png>)

* The archival job is designed in such a way that any additional archival job may be implemented simply by extending the base archival and modifying the functionality as needed to build custom archival functionality..
* The default archival job archives data each week; if another archival job needs to archive data for a different period, simply override the method.
* The first stage confirms the archival job of the configuration, period, and batches archival status. When the data archiving process begins for a given week.
*   There are currently several sorts of resources in the assessment table, such as **survey type of course** and **normal assessment type of course** . The job additionally does record filtering if the validation is successful.

    Instead of archiving all course type data, the job should be filtered to archive only the appropriate resource type of the course.
* The job that retrieves and archives the only particular resource data for a given N weeks into blob storage.
* On the success of archived report upload the job which updates the archival metadata into metadata store.

**Archival Formate:**

PATH = reports/archival-store/$batch\_id\_$collection\_id/$archival\_job\_date\_format-$timestamp.csv.gz

**Deleting of Archived Data:** After the data was successfully archived, the data archival job began deleting the archived data. It loads the metadata store for archived success batches into memory and deletes only the success archived data from the assessment agg table.

![](<../../../../Analytics/Fullexport/images/storage/Assessment Consumption Archival@2x (2).png>)

Once all of the archived batches' data has been successfully deleted, the DB admin must manually run the Cassandra compaction operation to remove the tombstone data from the assessment agg table.

**Handling of Failure Scenarios:**

* If the job throws an exception when archiving the batches, the job should mark the archival state as failed in the metadata store and pick up the next batch to archive.
* If the job fails in b/w while running for a particular period, we should be able to resume from the specific batch ID if we rerun the process (Job should not archive the already archived batch again and if the blob has already existed in the blob store the job should capable to replace the older archived file)
* If the user requests that archived data be deleted, the job should delete only archived data by searching the archived metadata store and deleting only archived entries.
* If an exception occurs during the deletion, the job should mark the batch as deleted and restart the procedure in the following batch.
* If the force archival option is enabled for a certain period, the job should re-archive the previously archived batch and also should delete the already archived blob’s.

#### Archival Metadata Store:

All the archived metadata need to be stored in any of the relational database systems. The below is the table schema of the archival metadata store.

```scala
CREATE TABLE archival_metadata (
    UUID text, 
    batch_id text,
    collection_id text,
    resource_type text, 
    job_id text, 
    archival_date timestamp,
    completion_date timestamp,
    archival_status text, 
    deletion_status text, 
    blob_url list[text], 
    iteration int,
    request_data json,
    err_message text
)
```

The above table schema which describes the archival metadata store.

|    | **Column**      | **Data Type** | **Description**                                                                                                                                       |
| -- | --------------- | ------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1  | UUID            | UUID          | Unique identifier - Primary Key                                                                                                                       |
| 2  | Batch ID        | Text          | Batch Identifier                                                                                                                                      |
| 3  | Collection ID   | Text          | Collection/Survey Identifier                                                                                                                          |
| 4  | Resource Type   | Text          | Which defines the type of Collection (Ex - Course/ Survey)                                                                                            |
| 5  | Job ID          | Text          | Type of Job - progress archival, assessment archival                                                                                                  |
| 6  | Archival Date   | Timestamp     | Archival Start Date                                                                                                                                   |
| 7  | Completion Date | Timestamp     | Archival End Date                                                                                                                                     |
| 8  | Archival Status | String        | Status of Archival - SUCCESS, FAILED                                                                                                                  |
| 9  | Deletion Status | String        | Status of Archived data deletion - SUCCESS, FAILED                                                                                                    |
| 10 | Blob URL’s      | List\[String] | Archived compressed csv blob paths                                                                                                                    |
| 11 | Iteration       | Int           | Indicates the number of Execution                                                                                                                     |
| 12 | Request Data    | JSON          | Which Store the config of the job {"period": "LAST\_WEEK/LAST\_N\_WEEKS/ALL", "batchId":batch-001 "date": "2021-10-27", "action": "archive/deletion"} |
| 13 | Error Message   | String        | Error Message if Any while deleting/Archiving                                                                                                         |

#### Support On Report Jobs & API:

Once the data is got archived from the respective table there are a few services that are dependent on the archiving table For example -

* Progress Exhaust Job
* Response Exhaust Job
* Flink Job (Assessment agg)
* API’s, etc.,

These dependents jobs should not get affected and should not cause any performance issues if the data is got archived from the archival table.

![](<../../../../Analytics/Fullexport/images/storage/Assessment Consumption Archival@2x (3).png>)

* The progress exhaust V2 Job will fetch the score metrics related data from the activity aggregator table going forward instead of loading from the assessment agg table
* The Response Exhaust V2 Job will fetch from both archival blob store and assessment agg table for a specific batch and merge those records and generate a report with distinct values.
* The API’s content state read API which fetches the score metrics details from the assessment agg table.
* The Assessment agg flink write the assessment raw data into assessment agg and score metrics into activity agg table.
* For more details of understanding related to activity agg table changes and compatibilities please read this wiki page - \[\[\[Design] Assessment Consumption table to support best score aggregates|\[Design]-Assessment-Consumption-table-to-support-best-score-aggregates]]

**Archival Job Generalisation:** The archival job should be able to extend and implement its own archival logic to archive any kind of table record data without any tight coupling.

**Job Configurations:**

```
{
  "search": {
    "type": "none"
  },
  "model": "org.sunbird.analytics.job.report.$job_name",
  "modelParams": {
    "mode": "archive/deletion",
    "request": {
      "archivalTable": "assessment_aggregator",
      "query": "{}" // TODO: Search Query (need to validate once with TM)
      "batchId": "batch-001",
      "date": "2021-11-01"
    },
    "blobConfig": {
      "store": "azure",
      "blobExt": "csv.gz",
      "reportPath": "assessment-archived-data/",
      "container": "reports"
    },
    "sparkCassandraConnectionHost": "{{ core_cassandra_host }}",
    "fromDate": "$(date --date yesterday '+%Y-%m-%d')",
    "toDate": "$(date --date yesterday '+%Y-%m-%d')"
  },
  "parallelization": 8,
  "appName": "$job_name"
}
```

### **Queries** :

### **Conclusion** :

***

\[\[category.storage-team]] \[\[category.confluence]]
