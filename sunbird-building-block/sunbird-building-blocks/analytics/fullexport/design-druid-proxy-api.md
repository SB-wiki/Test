# \[Design]-Druid-Proxy-API

### **Introduction** :

This document describes the design of the proxy API to validate/filter druid quires to avoid cascading failure.

### **Problem Statement:** &#x20;

Currently, The druid API is open and any user can fire a scan query over any date range and also use high cardinality columns as filter criteria without any ranges. Due to this druid system will crash and the user will not able to query the druid system further.

![](<../../../../Analytics/Fullexport/images/storage/Screenshot 2019-11-14 at 3.39.39 PM.png>) ![](<../../../../Analytics/Fullexport/images/storage/Screenshot 2020-08-25 at 1.37.12 PM.png>)

Once API Validates the request JSON object then proxy API will create the Hash key for the request object and checks in the redis for that hash key. if the value is present for the hash key in the redis then it will respond with value to the end-user OR. if the response is not present in the redis then it will fetch the result from the druid data source and store that response into Redis for certain interval of time.

\*\*API End Point: \*\* POST /v1/druid/

\*\*Request: \*\*

```js
{
  "queryType": "timeseries",
  "dataSource": "telemetry-events",
  "intervals": [
    "2019-09-23T00:00:00.000Z/2019-09-24T00:00:00.000Z"
  ],
  "aggregations": [
    {
      "type": "javascript",
      "name": "failed_scans",
      "fieldNames": [
        "edata_size"
      ],
      "fnAggregate": "function(current, edata_size) { return current + (edata_size == 0 ? 1 : 0); }",
      "fnCombine": "function(partialA, partialB) { return partialA + partialB; }",
      "fnReset": "function () { return 0; }"
    },
    {
      "type": "count",
      "name": "total_scans"
    }
  ],
  "postAggregations": [
    {
      "type": "arithmetic",
      "name": "failed_scans_percentage",
      "fn": "*",
      "fields": [
        {
          "type": "arithmetic",
          "name": "ratio",
          "fn": "/",
          "fields": [
            {
              "type": "fieldAccess",
              "name": "failed_scan_count",
              "fieldName": "failed_scans"
            },
            {
              "type": "fieldAccess",
              "name": "total_scan_count",
              "fieldName": "total_scans"
            }
          ]
        },
        {
          "type": "constant",
          "name": "const",
          "value": 100
        }
      ]
    }
  ],
  "filter": {
    "type": "and",
    "fields": [
      {
        "type": "selector",
        "dimension": "eid",
        "value": "SEARCH"
      },
      {
        "type": "not",
        "field": {
          "type": "selector",
          "dimension": "edata_filters_dialcodes",
          "value": null
        }
      }
    ]
  },
  "granularity": "all"
}
```

\*\*Response: \*\* Proxy API will not re-structure the response from the druid.&#x20;

1. \*\* Cancel Response : \*\*

```js
{
  "error" : "Query Rejected",
  "errorMessage" : "dimensions in a groupBy or topN query needs to be a maximum of 10.",
  "errorClass" : "java.util.concurrent.TimeoutException",
  "host" : "dev.sunbird.ord:8083"
}
```

&#x20;   2\. **Success Response**

```js
[
  {
    "timestamp": "2019-09-23T00:00:00.030Z",
    "result": {
      "failed_scans_percentage": 14.661939572679069,
      "total_scans": 159365,
      "failed_scans": 23366
    }
  }
]] ]></ac:plain-text-body></ac:structured-macro><p><br /></p><p><br /></p><p><strong>Rules:</strong></p><ac:structured-macro ac:name="code" ac:schema-version="1" ac:macro-id="6021bb36-8ba5-4fc3-ab61-743de6863c69"><ac:parameter ac:name="language">js</ac:parameter><ac:parameter ac:name="theme">FadeToGrey</ac:parameter><ac:parameter ac:name="title">Rules</ac:parameter><ac:plain-text-body><![CDATA[limits: [{ // Keeping limits per data source.
        cardinalColumns: [ // High cardinal dimensions
            "context_sid", // Telemetry, context session id
            "context_did", // Telemetry, context did
            "actor_id", // User id
            "object_id", // Content Id
            "syncts", // Sync Time Stamp
            "mid", // Uniq id
            "device_id",
        ],
        common: {
            max_dimensions: 10, // Maximum number of high cardinal dimensions are allowed.
            max_result_threshold: 1000, // Allowed max result is 1000.
        },
        dataSource: "telemetry-events", // Name of the data source.
        enableCache: true, // It stores the request and response into redis for the fast response
        queryRules: {
            groupBy: {
                max_date_range: 30,
                max_filter_dimensions: 50, // Maximum allowed date range, In days.
            },
            scan: {  // Query Type
                max_date_range: 30, // Maximum allowed date range, In days.
                max_filter_dimensions: 50, // Maximum allowed dimensions
            },
            search: {  // Query Type
                max_date_range: 30, // Maximum allowed date range, In days.
                max_filter_dimensions: 50, // Maximum allowed dimensions
            },
            select: {
                max_date_range: 30, // Maximum allowed date range, In days.
                max_filter_dimensions: 50, // Maximum allowed date range, In days.
            },
            timeBoundary: {
                max_date_range: 30, // Maximum allowed date range, In days.
                max_filter_dimensions: 50, // Maximum allowed date range, In days.
            },
            timeseries: {
                max_date_range: 30, // Maximum allowed date range, In days.
                max_filter_dimensions: 50, // Maximum allowed date range, In days.
            },
            topN: {
                max_date_range: 30, // Maximum allowed date range, In days.
                max_filter_dimensions: 50, // Maximum allowed date range, In days.
            },
        },
    },
    {
        cardinalColumns: [ // High cardinal dimensions
            "dimensions_did", // Summary, dimension device id
            "dimensions_sid", // Summary, dimension session id
            "actor_id", // User id
            "object_id", // Content Id
            "syncts", // Sync Time Stamp
            "mid", // Uniq id
            "device_id",
        ],
        common: {
            max_dimensions: 10, // Maximum number of high cardinal dimensions are allowed.
            max_result_threshold: 1000, // Allowed max result is 1000.
        },
        dataSource: "summary-events", // Name of the data source
        enableCache: false, // It stores the request and response into redis for the fast response
        queryRules: {
            groupBy: {
                max_date_range: 30,
                max_filter_dimensions: 50, // Maximum allowed date range, In days.
            },
            scan: {  // Query Type
                max_date_range: 30, // Maximum allowed date range, In days.
                max_filter_dimensions: 50, // Maximum allowed dimensions
            },
            search: {  // Query Type
                max_date_range: 30, // Maximum allowed date range, In days.
                max_filter_dimensions: 50, // Maximum allowed dimensions
            },
            select: {
                max_date_range: 30, // Maximum allowed date range, In days.
                max_filter_dimensions: 50, // Maximum allowed date range, In days.
            },
            timeBoundary: {
                max_date_range: 30, // Maximum allowed date range, In days.
                max_filter_dimensions: 50, // Maximum allowed date range, In days.
            },
            timeseries: {
                max_date_range: 30, // Maximum allowed date range, In days.
                max_filter_dimensions: 50, // Maximum allowed date range, In days.
            },
            topN: {
                max_date_range: 30, // Maximum allowed date range, In days.
                max_filter_dimensions: 50, // Maximum allowed date range, In days.
            },
        },
    }]] ]></ac:plain-text-body></ac:structured-macro><p><br /></p><p><br /></p><h2><strong>Summary Aggregate</strong></h2><p><br /></p><p><strong>API End Point: POST: v1/collection/summary</strong></p><p><br /></p><p><strong>Request:</strong></p><p class="auto-cursor-target"><br /></p><ac:structured-macro ac:name="code" ac:schema-version="1" ac:macro-id="5852a1ef-3d4f-4c4b-8c48-4a9f889c85d2"><ac:parameter ac:name="language">js</ac:parameter><ac:parameter ac:name="theme">FadeToGrey</ac:parameter><ac:parameter ac:name="title">Request</ac:parameter><ac:plain-text-body><![CDATA[{
	"request": {
		"filters": {
			"collectionId": "", // requried.
			"batchId": "" // required.
		},
		"group_by": ["state", "dist"] // Optional
		"intervals": "2019-09-23T00:00:00.000Z/2019-09-24T00:00:00.000Z" // Optional, Default StartDate - Batch Start Date and  Default EndDate - Current Date.
	}
}
```

**Response:**

```js
{
  "result": {
    "collectionId": "", // Collection/CourseId
    "name": "", // Collection Name
    "batchId": "", // Batch Identifier
    "enrolmentCount": "",
    "completionCount": "",
    "certificatesIssuedCount": "",
    "summary": {  // Summary by state and district level
      "state": {
        "enrolmentCount": "",
        "completionCount": ""
      },
      "district": {
        "enrolmentCount": "",
        "completionCount": ""
      }
    }
  }
}
```

\*\* \*\*

**Conclusion:**

***

\[\[category.storage-team]] \[\[category.confluence]]
