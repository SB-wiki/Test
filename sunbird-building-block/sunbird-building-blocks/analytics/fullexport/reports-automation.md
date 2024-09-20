# Reports-Automation

The objective of this document is to explain the Automation of creating Reports in Admin Dashboard

## Jira Ticket

[https://project-sunbird.atlassian.net/browse/ED-2090](https://project-sunbird.atlassian.net/browse/ED-2090)

![](<../../../../Analytics/Fullexport/images/storage/Screenshot from 2023-05-20 18-53-44.png>)

## API Endpoint :

1. **To get refresh token** :

```
{{host}}auth/realms/sunbird/protocol/openid-connect/token
```

1. **To get access token** :

```
{{host}}/auth/v1/refresh/token
```

1. **BackEndApi** :
   * Create Chart

```
{{host}}/api/data/v1/report/jobs/submit
```

```
* Update Chart
```

```
{{host}}/api/data/v1/report/jobs/chart_id
```

```
* Delete Chart
```

```
{{host}}/report/jobs/deactivate/chart_id
```

1. **FrontEndApi** :
   * Create Report

```
{{host}}/api/data/v1/report-service/report/create
```

```
* Update Report
```

```
{{host}}/api/data/v1/report-service/report/update/report_id
```

```
* Delete Report
```

```
{{host}}/api/data/v1/report-service/report/delete/report_id
```

## Sample Json Config

To View Config Expand here

```
{
    "id": "ekstep.analytics.report.get",
    "ver": "1.0",
    "ts": "2023-05-20T09:20:56.069+00:00",
    "params": {
        "resmsgid": "bc012eba-b2fa-4ee1-a872-ea1c3372dd41",
        "status": "successful",
        "client_key": null
    },
    "responseCode": "OK",
    "result": {
        "createdOn": 1683257527141,
        "updatedOn": 1684569486582,
        "reportId": "ml_total_unique_users_newo",
        "config": {
            "streamQuery": true,
            "reportConfig": {
                "id": "ml_total_unique_users_newo",
                "mergeConfig": {
                    "postContainer": "reports",
                    "container": "reports",
                    "basePath": "/mount/data/analytics/tmp",
                    "reportPath": "ml_total_unique_users_newo.csv",
                    "rollup": 0
                },
                "labels": {
                    "block_name": "Block name",
                    "SUM(unique_users)": "total_content_plays_on_portal",
                    "legend": "Total Unique Users",
                    "total_content_plays_on_portal": "Total Unique Users",
                    "organisation_name": "Organisation",
                    "parent_channel": "parent_channel",
                    "district_name": "District name",
                    "program_name": "Program name",
                    "state_slug": "state_slug",
                    "solution_name": "Observation name"
                },
                "dateRange": {
                    "staticInterval": "LastDay",
                    "granularity": "all",
                    "intervalSlider": 0
                },
                "metrics": [
                    {
                        "metric": "total_content_plays_on_portal",
                        "label": "total_content_plays_on_portal",
                        "druidQuery": {
                            "dataSource": "ml-obs-status",
                            "limitSpec": {
                                "type": "default",
                                "limit": 10000,
                                "columns": [
                                    {
                                        "dimension": "SUM(unique_users)",
                                        "direction": "descending"
                                    }
                                ]
                            },
                            "filters": [
                                {
                                    "type": "equals",
                                    "dimension": "status",
                                    "value": "completed"
                                },
                                {
                                    "type": "equals",
                                    "dimension": "private_program",
                                    "value": "false"
                                },
                                {
                                    "type": "equals",
                                    "dimension": "solution_type",
                                    "value": "observation_with_out_rubric"
                                },
                                {
                                    "type": "regex",
                                    "dimension": "program_name",
                                    "value": "^((?!(?i)(test)).)*$"
                                }
                            ],
                            "granularity": "all",
                            "dimensions": [
                                {
                                    "fieldName": "parent_channel",
                                    "aliasName": "parent_channel"
                                },
                                {
                                    "type": "extraction",
                                    "extractionFn": [
                                        {
                                            "type": "registeredLookup",
                                            "retainMissingValue": true,
                                            "fn": "stateSlugLookup"
                                        }
                                    ],
                                    "fieldName": "state_name",
                                    "aliasName": "state_slug"
                                },
                                {
                                    "fieldName": "organisation_name",
                                    "aliasName": "Organisation"
                                },
                                {
                                    "fieldName": "district_name",
                                    "aliasName": "District name"
                                },
                                {
                                    "fieldName": "block_name",
                                    "aliasName": "Block name"
                                },
                                {
                                    "fieldName": "program_name",
                                    "aliasName": "Program name"
                                },
                                {
                                    "fieldName": "solution_name",
                                    "aliasName": "Observation name"
                                }
                            ],
                            "aggregations": [
                                {
                                    "fieldName": "unique_users",
                                    "type": "longSum",
                                    "name": "total_content_plays_on_portal"
                                }
                            ],
                            "postAggregations": [],
                            "queryType": "groupBy"
                        }
                    }
                ],
                "output": [
                    {
                        "type": "csv",
                        "metrics": [
                            "total_content_plays_on_portal"
                        ],
                        "dims": [
                            "date",
                            "state_slug"
                        ],
                        "fileParameters": [
                            "id",
                            "dims"
                        ]
                    }
                ],
                "queryType": "groupBy"
            },
            "container": "reports",
            "store": "azure",
            "key": "hawk-eye/"
        },
        "requestedBy": "fb85a044-d9eb-479b-a55a-faf1bfaea14d",
        "reportDescription": "Total number of active distinct users",
        "submittedOn": 1683257527141,
        "status": "ACTIVE",
        "status_msg": "REPORT SUCCESSFULLY ACTIVATED",
        "reportSchedule": "DAILY"
    }
}
```

## Automation Flow:

1. Coding Structure to be maintained as:

```
Automation Scripts -> Folder
    create_report.py            
    update_report.py
    deactivate_report.py
release-6.0 -> Folder
    report_preparation.py
    chart_name1_report_config.json
    ......
    chart_namen_report_config.json
```

1. Release wise Json config files need to be created and pushed to the git, So the number of json represents the number of Chart creation/updation/deletion.
2. In Jenkins a job need to be created which triggers the script report\_preparation.py from ml-analytics server
3. This script will call get\_token.py prgram to generate the access token once and reuse for all operations
4. Then based on the operation to be performed for report creation the functions will be called from this script

```
Ex :create_report(access_token,fromtEnd/backEnd,report_config.json)
```

1. Operation(create/update/delete) of each chart logic is maintained in a separate **.py** file under Automation Scripts Folder
2. So Basically each individually script will invoke the corresponding API to perform the action
3. After every API call the status and the config related to it, is been maintained in the MongoDB, ie logging will be done in MongoDB
4. The structure of log to be maintained in MongoDB is

```
{
    _id : 1,
    release : "release-6.0",
    configFileName : "chart_name1_report_config.json",
    config : "The whole json",
    createdAt : "",
    updatedAt : "",
    status : "success/failed",
    errmsg : "",
    operation :""
}
```

1. For every operation there will be a insert document to the MongoDB

## Handling Duplicate run:

1. For every report action, First it will check the MongoDB with the updated-At and chart\_name
2.  If its same chart and date also matches, next will check for status,

    If status failed will execute program else will check for config changes if there are changes will trigger update operation else exit the program

```
If(status=="failed")
   execute prgm
elsif (current_config != oldConfig)
    update operation
else 
    log this as duplicating the same chart and exit from program
```

## Exception Handling :

1. Authorisation exception
2. Id not found exception : while update
3. Internal server Error
4. Mongo client error

***

\[\[category.storage-team]] \[\[category.confluence]]
