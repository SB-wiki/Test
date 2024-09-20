# \[Design]-API-to-determine-the-experiment-for-a-user

### Introduction:

Web/Mobile application needs to identify whether a given device/user is part of some experiment or not. This is required to enable Mobile/Web application to load modules specific to some experimentation. In this document, we present the request/response structure of the API and high-level design of API implementation.

### High-level design:&#x20;

Block diagram below shows the high-level design of experimentation service. To determine whether user/device is part of an experiment when a request is made by Mobile/Web client, API service has to check in the pre-populated data source(Cache) with details about the experiment data and targeted user/Device. If a match for the device/user is found in the Datasource(Cache), it should return the response with experiment data which is defined in the "Experiment Definition". The experiment definition consists of details regarding the experiment and criteria/rules to target the intended users/device.  The Cache should be faster enough to look for the match against User/Device data to serve huge no. of request. To populate the Cache/Lookup table, we need "Experiment definition" to know what data has to be picked from User/Org/device database based on the criteria.&#x20;

Spark jobs can populate the experiment data from User/Org/Device database using the "Experiment definition". Whenever there is a change in the definition, the data product should be re-run to refresh the cache.

![](<../../../../PRD/prd-ed-td-req-9du/images/storage/Untitled Diagram.jpg>)

### API structure:

Due to the fact that the client needs to make a call to register the device ID on each load, we can use the existing Device register API to determine the experiment for a user as well. The request/response structure is given below:

```
POST v1/device/register/<device ID>

{
	"id": "",
    "ver": "",
    "ts": "",
    "params": {
        "msgid": ""
    },
    "request": {
        "did": "", //device ID
        "uaspec": {
            "agent": "",
            "ver": "",
            "system": "",
            "platform": "",
            "raw": ""
        },
        "channel": "",
        "fcmToken": "",
        "producer": "",
        "dspec": {}, // device spec
		"ext": { 
			"userid": "", // logged in user ID - optional
			"url" : "" // url to identify the experiment - optional
		}
    }
}


// Response:

{
    "id": "",
    "ver": "",
    "ts": "", //timestamp
    "params": {
        "resmsgid": "", //uuid
        "status": "successful",
        "client_key": null
    },
    "responseCode": "OK",
    "result": {
		"message": "Device registered successfully",
		"actions": [{
			"type": "experiment", // experiment/notification/configUpdate etc 
			"data": {
				"id": "", // experiment ID
				"name": "", //experiment name
				"startDate": "",
				"endDate": "",
				"key": "" // deployment key for mobile or experiment folder id for portal
			}
		}]  
    }
}
```

### \[TBD] Common Rules:

1incompleteSchema for common Rules:2incompleteCommon rules types

### Lookup table schema:

We can use Redis as a lookup table. To store the data in Redis, we can follow any these approach:

Approach 1:

Define a separate index for each key. Here key can be Userid, URL or DeviceIds.  So, each DB index inside Redis can hold any of these values as keys (Userid, URL, DeviceIds).  The value consists of "experiment data" in JSON sting format.

Pros:

1. Easy to maintain, since each DB index is separated by a single key

Approach 2:

We can combine keys using delimiter and store it in common DB index.

example:

userId:deviceID:URL

Pros:

1. we can assign a single DB index to store all the values

Cons:

&#x20;     1\. not easy to maintain since it is not easy to identify the type of key.

### Schema for Experimentation index:

Experimentation table schema.&#x20;

This index is used to store the user/device data along with experiment details. This is the primary index to check which user/device is part of which experiment.

```
schema for Experiment index

id text
name text
ver text
userId text
url text
deviceId text
key text
extData text 
platform text
startDate text
endDate text
lastUpdatedOn text
createdOn text
```

### Telemetry LOG event:

LOG event is generated from API service whenever a request is served as part of experimentation. Here is the sample LOG event:

```
{
	"eid": "LOG",
	"ets": 1561817862019,
	"ver": "3.0",
	"mid": "401ED13CE592E52899B24ECCFF188E1A",
	"actor": {
		"id": "",
		"type": "System"
	},
	"context": {
		"channel": "analytics.api",
		"pdata": {
			"id": "AnalyticsAPI",
			"ver": "3.0",
			"pid": "experiment",
			"model": null
		},
		"env": "analytics",
		"sid": null,
		"did": null,
		"cdata": null,
		"rollup": null
	},
	"object": null,
	"edata": {
		"type": "api_access",
		"params": [
				{
			"title": "experiment",
			"experimentId": "",
			"userId": "",
			"deviceId": "",
			"url": ""
			}
		]
	},
	"@timestamp": "2019-06-29T14:17:42+00:00"
}

```

### Open Questions:

1. How to invalidate a user who is part of an experiment?
2. What is the order of priority to evaluate the experiment from request params?

***

\[\[category.storage-team]] \[\[category.confluence]]
