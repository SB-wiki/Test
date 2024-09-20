# Public-Data-Exhaust-API

### Introduction:

* This wiki give the details about Public data exhaust API spec and implementation details.

### API Spec:

#### Get API

* Get the CDN links for exhaust data files by specific channel without authentication

**URL - GET :** public/dataset/get/{datasetId}?from=2020-09-10\&to=2020-09-14 orpublic/dataset/get/{datasetId}?since=2020-09-10datasetId: data type id. Response:

```json
{
    "id": "org.ekstep.analytics.telemetry",
    "ver": "1.0",
    "ts": "2020-09-14T06:04:13.988+00:00",
    "params": {
        "resmsgid": "d4a5bcb1-bff5-4c7c-a5f2-1c255ba640f0",
        "status": "successful",
        "client_key": null
    },
    "responseCode": "OK",
    "result": {
        "files": [], // list of exhaust files CDN url 
        "periodWiseFiles": { // period wise list of exhaust files CDN url 
            "<date:yyyy-mm-dd>": []
        }
    }
}
```

Sample Response:

/data/v3/public/dataset/get/summary-rollup?from=2020-06-16\&to=2020-06-17

```
{
    "id": "org.ekstep.analytics.telemetry",
    "ver": "1.0",
    "ts": "2020-09-14T06:04:13.988+00:00",
    "params": {
        "resmsgid": "d4a5bcb1-bff5-4c7c-a5f2-1c255ba640f0",
        "status": "successful",
        "client_key": null
    },
    "responseCode": "OK",
    "result": {
        "files": [
            "https://cdn.abc.com/data-store/data-exhaust/summary-rollup/2020-06-16.csv",
            "https://cdn.abc.com/data-store/data-exhaust/summary-rollup/2020-06-17.csv"
        ],
        "periodWiseFiles": {
            "2020-06-17": [
                "https://cdn.abc.com/data-store/data-exhaust/summary-rollup/2020-06-17.csv"
            ],
            "2020-06-16": [
                "https://cdn.abc.com/data-store/data-exhaust/summary-rollup/2020-06-16.csv"
            ]
        }
    }
}
```

### API Implementation details:

* Date range options
  * from: Must be in YYYY-MM-DD format. Will be defaulted to yesterday, if not specified
  * to: Must be in YYYY-MM-DD format. Will be defaulted to yesterday, if not specified. This must be greater than or equal to **from** and must be less than today.
  * since: Must be in YYYY-MM-DD format. Can be used instead of **from** & **to** , incase of last few days. Ex: Since 2021-04-01 - will be same as from 2021-04-01 till yesterday.
  * date: Must be in YYYY-MM-DD format. Can be used for any specific date instead of range.
  * date\_range: Can have any of the
* Distinguish between public & private dataset and return proper message back in response.
  * Get the list of public datasets from config and check against provided dataset.
  * Provide proper response message for invalid dataset
* Possible error messages are:
  * INVALID DATASET: Requested dataset is not available. Please select from the available options.
  * MISSING FILES: Exhaust files are not available for requested date.
  * OLDER THAN X MONTHS: Requested date is older than “X“ month and it is currently not available.
  * INVALID DATE RANGE: Provided data\_range is not valid. Please select from the available options.
  * INVALID INTERVAL: Provided dates(from, to or since) are invalid.
* Request caching&#x20;
  * we can look at the possibilities of caching at the proxy for first version
  * Design for handling caching at API level&#x20;

***

\[\[category.storage-team]] \[\[category.confluence]]
