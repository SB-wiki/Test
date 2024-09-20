
## Introduction:

* Right now we have support for 2 datasets supported as standard exhaust and 3 as on-demand exhaust. All of the exhaust ids and their necessary configurations are floating around in wiki pages and it will be very difficult to know the new datasets added and from when they are available from.


* To overcome the problem, we will be having 2 API one to create and the other to list the dataset’s metadata respectively




### Dataset Metadata Postgres Table schema:

```
CREATE TABLE dataset_metadata(
dataset_id VARCHAR(50),
dataset_sub_id VARCHAR(50),
dataset_config json,
visibility VARCHAR(50),
dataset_type VARCHAR(50), // Type of dataset, druid vs non-druid
version VARCHAR(10),
authorized_roles text[], // Authorized roles, custom authorization checks
available_from TIMESTAMP,
sample_request VARCHAR(300),
sample_response VARCHAR(300),
validation_json json, // dataset specific json validation schema
druid_query json, // dataset specific druid queries only if dataset_type is druid
limits json, // Dataset Limits configuration (sizePerChannel, requestsPerChannel etc)
supported_formats VARCHAR(20), // Json/CSV or both
exhaust_type VARCHAR(50), // OnDemand / Standard
PRIMARY KEY (dataset_id));
```

### Meta API details

1.  **Add Dataset**  - A private API that is invoked when there is an addition to a new dataset


1.  **List Datasets**  - to list all datasets available as exhaust.



 **Add Dataset API:** 

 POST:  / **dataset/v1/add** 

 **Request:** 


```
{
  "id": "ekstep.analytics.dataset.add",
  "ver": "1.0",
  "ts": "2016-12-07T12:40:40+05:30",
  "params": {
    "msgid": "4f04da60-1e24-4d31-aa7b-1daf91c46341" // unique request message id, UUID
  },
  "request": {
    "dataset": String, // Unique identifier for Dataset
    "datasetSubId": String, // Dataset sub type for druid exhaust and default to dataset value only if not specified
    "datasetConfig": Json, // Config filters for Dataset
    "visibility": String, // To denote whether dataset is public or private
    "datasetType": String, // Type of dataset. Can be druid vs non-druid
    "version": String , // Version of the dataset
    "authorizedRoles": List, // List of roles authorized to create a dataset tag
    "availableFrom" : Date, // Dataset available from date. Optional - will be defaulted to submitted date.
    "validationJson": Json, // dataset specific json validation schema
    "druidQuery": Json, // dataset specific druid queries only if dataset_type is druid
    "limits": Json, // Dataset Limits configuration (sizePerChannel, requestsPerChannel etc)
    "supportedFormats": String, // Json/CSV or both
    "exhaustType": String // Can be out of On-demand Exhaust, Standard Exhaust or Public Exhaust
  }  
}
```
 **Response** :
```
{
    "id": "ekstep.analytics.dataset.add",
    "ver": "1.0",
    "ts": "2016-12-07T12:43:23.890+00:00",
    "params": {
        "msgid": "4f04da60-1e24-4d31-aa7b-1daf91c46341",
        "status": "successful"
    },
    "responseCode": "OK",
    "result": {
      "message": "Dataset <dataset_sub_id> added successfully"
    }  
}
```
Sample Request:


```json
{
  "id": "ekstep.analytics.dataset.add",
  "ver": "1.0",
  "ts": "2016-12-07T12:40:40+05:30",
  "params": {
    "msgid": "4f04da60-1e24-4d31-aa7b-1daf91c46341"
  },
  "request": {
      "dataset": "progress-exhaust",
      "datasetConfig": {
          "batchFilters": List[],
            "contentFilters": {
              "request": {
                "filters": {
                  "identifier": String,
                  "prevState": "String"
                },
                "sort_by": {
                  "created_on": "desc"
                },
                "limit": Integer,
                "fields":List
              }
            },
            "reportPath": "String"
          },
          "output_format": "String"
      },
      "datasetType": "on-demand exhaust",
      "visibility": "private",
      "version": "v1",
      "authorizedRoles": [
        "portal"
      ]
   }   
}
```


 **List Dataset API:** 

 GET:  / **dataset/v1/list** 

 **Response:** 


```
{
    "id": "ekstep.analytics.dataset.list",
    "ver": "1.0",
    "ts": "2016-12-07T12:43:23.890+00:00",
    "params": {
        "resmsgid": "4f04da60-1e24-4d31-aa7b-1daf91c46341",
        "status": "successful"
    },
    "responseCode": "OK",
    "result": {
        "count": Int, // Number of datasets available
        "datasets": [{
            "dataset": String, // Unique identifier for Dataset
            "datasetSubId": String, // Dataset sub type for druid exhaust and default to dataset value only if not specified
            "datasetConfig": Json, // Config filters for Dataset
            "datasetType": String, // Type of dataset. Can be out of On-demand Exhaust, Channel Exhaust or Public Exhaust
            "visibility": String, // To denote whether dataset is public or private
            "version": String , // Version of the dataset
            "validationJson": Json, // dataset specific json validation schema
            "supportedFormats": String, // Json/CSV or both
            "exhaustType": String,
            "availableFrom" : Date // Dataset available from date. Optional - will be defaulted to submitted date. 
        }] 
    }
}    
```




*****

[[category.storage-team]] 
[[category.confluence]] 
