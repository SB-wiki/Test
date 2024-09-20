# Design-for-automated-reports-from-Druid

### Introduction:

This document describes the design to generate the data for the portal dashboards from Druid OLAP data store and export the report data to cloud storage. This mainly consists of following modules

1. **Configure Report API** - This API will be used to submit a request for configuration of a new report.
2. **Job Scheduler Engine** - This Scheduler will submit the reports for execution based on execution frequency.
3. **Disable Report API** - This API will mark an existing report as disabled and will be excluded from the list of reports to be executed.
4. **Report Data Generator** - The report data generator will be a spark job which will generate report data file by executing the query configured in the report configuration against the druid data store. The report data file will then be exported to cloud storage to complete the report execution.

![](../../../../Design/FullExport/images/storage/reports\_from\_druid\_architecture.png)

### Configure Report API:

Input parameters

| Parameter            | Mandatory | Description                 | Comments                        |
| -------------------- | --------- | --------------------------- | ------------------------------- |
| report\_name         | Yes       | Name of the report          |                                 |
| query\_engine        | Yes       | Data Source                 | DRUID, CASSANDRA, ELASTICSEARCH |
| execution\_frequency | Yes       | Report generation frequency | DAILY, WEEKLY, MONTHLY          |
| report\_interval     | Yes       | Date range for queries      |                                 |

1. YESTERDAY
2. LAST\_7\_DAYS,
3. LAST\_WEEK,
4. LAST\_30\_DAYS,
5. LAST\_MONTH,
6. LAST\_QUARTER,
7. LAST\_3\_MONTHS,
8. LAST\_6\_MONTHS
9. LAST\_YEAR

\| | query | Yes | Query to be executed | | | output\_format | Yes | Output format of the report | json, csv | | output\_file\_pattern | No | Report output filename pattern | report\_id and end\_date from the interval are used by default{report\_id}-{end\_date}.{output\_format}Other Supported Placeholders are:

1. report\_name
2. timestamp

\| | output\_field\_names | Yes | Output field names used in report output | | | group\_by\_fields | No | Fields by which reports are grouped by | channel\_id, device\_id |

* **Request Object**

```
 {
  "id":"sunbird.analytics.report.submit",
  "ver":"1.0",
  "ts":"2019-03-07T12:40:40+05:30",
  "params":{
     "msgid":"4406df37-cd54-4d8a-ab8d-3939e0223580",
     "client_key":"analytics-team"
  },
  "request":{
     "channel_id":"in.ekstep",
     "report_name":"avg_collection_downloads",
     "query_engine": "druid",
     "execution_frequency": "DAILY",
     "report_interval":"LAST_7_DAYS",
     "output_format": "json",
     "output_field_names": ["Average Collection Downloads"],
     "query_json":{
        "queryType":"groupBy",
        "dataSource":"telemetry-events",
        "granularity":"day",
        "dimensions":[
           "eid"
        ],
        "aggregations":[
           { "type":"count", "name":"context_did", fieldName":"context_did" }
        ],
        "filter":{
           "type":"and",
           "fields":[
              { "type":"selector", "name":"eid", fieldName":"IMPRESSION" },
              { "type":"selector", "name":"edata_type", fieldName":"detail" },
              { "type":"selector", "name":"edata_pageid", fieldName":"collection-detail" },
              { "type":"selector", "name":"context_pdata_id", fieldName":"prod.diksha.app" }
           ]
        },
        "postAggregations":[
           {
              "type":"arithmetic",
              "name":"avg__edata_value",
              "fn":"/",
              "fields":[
                 { "type":"fieldAccess", "name":"total_edata_value", "fieldName":"total_edata_value" },
                 { "type":"fieldAccess", "name":"rows", "fieldName":"rows" }
              ]
           }
        ],
        "intervals":[
           "2019-02-20T00:00:00.000/2019-01-27T23:59:59.000"
        ]
     }
  }
 }
 
```

* **Output:**

The individual report configurations can be saved to a Cassandra table. The druid query JSON will be saved to Azure blob storage and the following will be the fields in the report configuration table.

```
   # Schema of table
   TABLE platform_db.reports_configuration (
     report_id text, // hash of report_name and report_interval
     report_config text, // Entire JSON from request
     status text,
     report_output_location text,
     report_last_generated timestamp,
     PRIMARY KEY (report_id) );
   )

```

### Job Scheduler Engine:

![](<../../../../Design/FullExport/images/storage/druid\_reports\_job\_scheduler (1).png>)

* **Input:**      - A list of reports in  **reports\_configuration** Cassandra table with the cron\_expression which falls within the current day of execution and with status as ENABLED.
* **Algorithm:** \*\*              \*\*

&#x20;               \- Data availability check has following 2 criteria:

&#x20;                       1\. Kafka indexing lag: check for 0 lag in druid ingestion.

&#x20;                       2\. Druid segments count: Segments should have been created for previous day.

&#x20;               \- Reports based on telemetry-events will be submitted for execution upon satisfying both the criteria.

&#x20;               \- Reports based on summary-events will be submitted for execution upon satisfying only 2nd criteria or check for files in azure.&#x20;

&#x20;               \- If  **report\_last\_generated**  is not equals to previous day for a report, submits the same report for all the pending dates.

* **Output:**

\- The list of reports are submitted for execution into the  **platform\_db.job\_request** Cassandra table with the status= \*\*SUBMITTED \*\* and job\_name= **druid-reports-** .

### Disable Report API:

* **Input:**

\- report-id

* **Output:**

\- The report will be **DISABLED** in the **platform\_db.reports\_configuration**  Cassandra table

### Report Data Generator Data Product:

* **Input:**

\- Set of Requests -  **i.e** All records in **platform\_db.job\_request** where status= **SUBMITTED** and job\_name starts with  **druid-reports**

* **Output:**

\-  Report data file will be saved in Azure with specified format

\-  **platform\_db.job\_request** table will be updated with job status and output file details will be updated in **platform\_db.reports\_configuration**

* **Output location and file format in Azure:**

Once a request has been submitted and processing complete, the report data file with the name of the file being the report id suffixed with report\_interval end-date saved under :

```
   /druid-reports/report_id-yyyy-mm-dd.csv
   /druid-reports/report_id-yyyy-mm-dd.json
```

### Regenerate Report API:

* **Input:**

\- report-list

\- replay-interval

* **Algorithm:**

\- Loops through replay interval, find  **report\_output\_filename**  with each date and resubmits to job\_request table for execution.

\- Backup and delete older report data files from azure.

\- report-list can be empty in case of regenerating all enabled reports.

* **Output:**

\- The list of reports are submitted for execution into the  **platform\_db.job\_request** Cassandra table with the status= \*\*SUBMITTED \*\* and job\_name= **druid-reports-** .

***

\[\[category.storage-team]] \[\[category.confluence]]
