
## Introduction: 
This wiki describes the Internal data exhaust Search API spec and Implementation details.


## Table Schema

```scala
CREATE TABLE IF NOT EXISTS {{ env }}_job_request(
	tag VARCHAR(100),
	request_id VARCHAR(50),
	job_id VARCHAR(50), 
	status VARCHAR(50), 
	request_data json, 
	requested_by VARCHAR(50), 
	requested_channel VARCHAR(50), 
	dt_job_submitted TIMESTAMP, 
	download_urls text[], 
	dt_file_created TIMESTAMP, 
	dt_job_completed TIMESTAMP, 
	execution_time INTEGER,
	err_message VARCHAR(300), 
	iteration INTEGER, 
	encryption_key VARCHAR(50), 
	batch_number INTEGER,
	PRIMARY KEY (tag, request_id)
)
```



## API Spec:
Which returns the List of exhaust request **s**  in descending order of “dt_job_submitted“ field.

 **Method:** POST

 **URI :** 'https://${host}/api/dataset/v1/request/search'

 **Request Body:** 


```
{
  "id": "ekstep.analytics.job.request.submit",
  "ver": "1.0",
  "ts": "2021-05-19T12:40:40+05:30",
  "params": {
    "msgid": "4f04da60-1e24-4d31-aa7b-1daf91c46341"
  },
  "request": {
    "filters": {
      "dataset": "progress-exhaut",
      "channel": "ORG_01",
      "status": "FAILED",
      "requestedDate":"2021-01-01" // yyyy-mm-dd
    },
    "limit": 50 // Default is 20 
  }
}
```
 **NOTE:**  The limit is default to 20 records

 **Response Body:** 


```

{
  "result": {
    "count": 3, // Total Number of records available in the db
    "jobs": [
      {
        "attempts": 0,
        "lastUpdated": 1600845394119,
        "tag": "course001_batch001:ORG_001",
        "batchId": "batch001",
        "downloadUrls": [],
        "datasetConfig": {
            "batchId": "batch001"
        },
        "statusMessage": "No data found",
        "requestedBy": "user001",
        "jobStats": {
          "dtJobSubmitted": 1600845394119,
          "dtJobCompleted": null,
          "executionTime": null
        },
        "status": "SUBMITTED",
        "dataset": "progress-exhaust",
        "requestId": "AF7B9BE5D0D075EA0DB8C6D12E192D5F",
        "requestedChannel": "ORG_001"
      }
    ]
  }
}

```




*****

[[category.storage-team]] 
[[category.confluence]] 
