# User-Report--No.-of-Users-on-Platform

The objective of this document is to explain the User Report via Redis in the Admin Dashboard

**Jira Ticket:**

[https://project-sunbird.atlassian.net/browse/RRHE-32](https://project-sunbird.atlassian.net/browse/RRHE-32)

**GitHub Discussion Forum:**

[https://github.com/Sunbird-Lern/Community/discussions/68](https://github.com/Sunbird-Lern/Community/discussions/68)

## Architecture :

![](<../../../../Analytics/Fullexport/images/storage/Screenshot from 2023-04-18 14-16-31.png>)

## Custom data product :

*   **Model Config :**

    Execution of the data product in the server will be done by updating the config in the model-config.j2 file

```
{
  "search": {
    "type": "none"
  },
  "model": "org.sunbird.ml.exhaust.UniqueUserReportJob",
  "modelParams": {
    "store": "azure",
    "mode": "standAlone",
    "authorizedRoles": [
      "Report Admin",
      "Report Viewer"
    ],
    "id": "ml-unique-user-eport",
    "redis_table": [
      {
        "name": "user",
        "columns": [
          "userid",
          "state",
          "district"
        ],
        "filters": [
          {
            "name": "userType",
            "operator": "=",
            "value": "administrator"
          },
          {
            "name": "usersignintype",
            "operator": "in",
            "values": [
              "Validated",
              "Self-Signed-In"
            ]
          }
        ]
      }
    ],
    "label_mapping": {
      "user_id": "UUID",
      "state": "State",
      "district": "District"
    },
    "sparkRedisConnectionHost": "{{ metadata2_redis_host }}",
    "sparkUserDbRedisIndex": "12",
    "sparkUserDbRedisPort": "{{ user_port }}",
    "fromDate": "$(date --date yesterday '+%Y-%m-%d')",
    "toDate": "$(date --date yesterday '+%Y-%m-%d')",
    "key": "ml_unique_user_reports/",
    "format": "csv"
  },
  "parallelization": 8,
  "appName": "Unique User Report"
}
```

* Establish the Redis connect
* Get the required columns and filters from Model config
* **Data Query** :
* Frame the query

```
select(userid, state, district).filter(role = “administrator”).filter(usersignintype=(“Validated/Sel“))
```

* Select UserId, StateName, DistrictName and Store the Result into Spark Dataframe
* Filter : Role should be HT & other official and only logged in users
* Granularity : District level user count
* Store it in dataframe
* Handling Exception
* Perform aggregation to get unique count at district level
* Create a json file and store in cloud storage

#### Required Json Columns :

```
State
District
No.of users
```

* Schedule this job in Crontab to run weekly once

### Chart Config :

* Configure the Admin dashboard charts to point to this json file

```
{
    "request": {
        "report": {
            "title": "User’s Data Report with unique user",
            "description": "This report will track the no. of users with HT persona role on platform",
            "authorizedroles": [
                "REPORT_ADMIN",
                "ORG_ADMIN"
            ],
            "status": "draft",
            "type": "public",
            "createdby": "773d5976-e4df-4707-8121-71a4bc479bea",
            "reportconfig": {
                "label": "User’s Data Report with unique user",
                "title": "User’s Data Report with unique user",
                "charts": [
                    {
                        "id": "Big_Number",
                        "bigNumbers": [
                            {
                                "footer": " ",
                                "header": "No. of unique signed in  users with HT&other official role",
                                "dataExpr": "No of logins with valied and self user"
                            }
                        ],
                        "dataSource": {
                            "ids": [
                                "ml_no_signed_in_users_main"
                            ],
                            "commonDimension": "Date"
                        }
                    }
                ],
                "filters": [
                    {
                        "reference": "State Name",
                        "controlType": "multi-select",
                        "displayName": "State"
                    },
                    {
                        "reference": "District Name",
                        "controlType": "multi-select",
                        "displayName": "District"
                    }
                ],
                "dataSource": [
                    {
                        "id": "ml_no_signed_in_users_main",
                        "path": $path pointing to the json creted from Data product
                    }
                ],
                "description": "This report will track the no. of users with HT persona role on platform",
                "downloadUrl": ""
            },
            "slug": "hawk-eye",
            "reportgenerateddate": "2023-04-19T00:00:00.000Z",
            "reportduration": {
                "enddate": "12-02-2020",
                "startdate": "12-02-2020"
            },
            "tags": [
                "1Bn"
            ],
            "updatefrequency": "DAILY",
            "parameters": [
                "$slug"
            ],
            "report_type": "report"
        }
    }
}
```

* User will consume the report from the Admin Dashboard Portal

**Final Output :** ![](<../../../../Analytics/Fullexport/images/storage/Screenshot from 2023-04-19 15-55-22.png>)

***

\[\[category.storage-team]] \[\[category.confluence]]
