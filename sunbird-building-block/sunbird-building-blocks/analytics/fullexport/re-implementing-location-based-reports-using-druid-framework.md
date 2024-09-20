 **Introduction:** The location based reports include district wise weekly and monthly reports. The district weekly report lists Per State (device location) Scans, Plays and Unique Devices in the week on App or Portal by district and the district monthly report lists Per State (device location) unique devices in the month by district. These reports need to be implemented using the druid framework.

JIRA LINK: [SB-15681 System JIRA](https:///browse/SB-15681)

 **Current Implementation - Script based reports:** The python based scripts query on druid and generate reports grouped by district based on city district mapping.

city_district_mapping.csv:



| State | District | City | 
|  --- |  --- |  --- | 
| Uttar Pradesh | MEERUT | Mawana | 
| Uttar Pradesh | MEERUT | Daurala | 
| Uttar Pradesh | BULANDSHEHR | Sikandarabad | 




*  **Output:** 

Format for district weekly report:



| Date | District | Total Unique Devices | Unique Devices on App | Unique Devices on Portal | Total Number of QR Scans | Number of QR Scans on App | Number of QR Scans on Portal | Total Number of Content Plays | Number of Content Plays on App | Number of Content Plays on Portal | 
|  --- |  --- |  --- |  --- |  --- |  --- |  --- |  --- |  --- |  --- |  --- | 
|  **09/06/2019**  | Bilaspur | 17 | 6 | 11 | 188 | 98 | 45 | 117 | 61 | 47 | 
|  **09/06/2019**  | Dantewada | 8 | 7 | 1 | 71 | 60 | 67 | 78 | 40 | 32 | 
|  **16/06/2019**  | Raipur | 19 | 17 | 2 | 60 | 124 | 18 | 58 | 22 | 30 | 
|  **23/06/2019**  | Baster | 20 | 11 | 9 | 97 | 89 | 1 | 56 | 45 | 11 | 



Format for district monthly report:



| District | Unique Devices | 
|  --- |  --- | 
| Anantapur | 761 | 
| Chittoor | 1253 | 
| Kurnool | 1465 | 
| Nellore | 3624 | 



 **Design for re-implementation:** 
*  **Input:** 

The re-implementation for the reports can be done based on the DruidQueryProcessingModel.

Queries:

District Monthly:


*  **Granularity:** Month
*  **Frequency:** Every 1st date of the month


```
{
            "id":"district_monthly",
            "queryType":"groupBy",
            "dateRange":{
                "staticInterval":"LastMonth",
                "granularity":"all"
            },
            "metrics":[
              {
                "metric":"totalUniqueDevices",
                "label":"Total Unique Devices",
                "druidQuery":{
                    "queryType":"groupBy",
                    "dataSource":"telemetry-events",
                    "intervals":"LastMonth",
                    "aggregations":[
                      {
                          "name":"total_unique_devices",
                          "type":"cardinality",
                          "fieldName":"context_did"
                      }
                    ],
                    "dimensions":[
                      {
                          "fieldName":"derived_loc_state",
                          "aliasName":"state"
                      },
                      {
                          "fieldName":"derived_loc_district",
                          "aliasName":"district"
                      }
                    ],
                    "filters":[
                      {
                          "type":"in",
                          "dimension":"context_pdata_id",
                          "values":[
                            "{{ producer_env }}.diksha.portal",
                            "{{ producer_env }}.diksha.app"
                          ]
                      },
                      {
                          "type":"isnotnull",
                          "dimension":"derived_loc_state"
                      },
                      {
                          "type":"isnotnull",
                          "dimension":"derived_loc_district"
                      }
                    ],
                    "descending":"false"
                }
              }
            ],
            "labels":{
              "state":"State",
              "district":"District",
              "total_unique_devices":"Number of Unique Devices"
            },
            "output":[
              {
                "type":"csv",
                "metrics":[
                    "total_unique_devices"
                ],
                "dims":[
                    "state"
                ],
                "fileParameters":[
                    "id",
                    "dims"
                ]
              }
            ]
          }
```


District Weekly:


*  **Granularity:** Week
*  **Frequency:** Every Monday


```
{
        "id":"district_weekly",
        "queryType":"groupBy",
        "dateRange":{
            "staticInterval":"LastWeek",
            "granularity":"all"
        },
        "metrics":[
            {
                "metric":"totalUniqueDevices",
                "label":"Total Unique Devices",
                "druidQuery":{
                   "queryType":"groupBy",
                   "dataSource":"telemetry-events",
                   "intervals":"LastWeek",
                   "aggregations":[
                      {
                         "name":"total_unique_devices",
                         "type":"cardinality",
                         "fieldName":"context_did"
                      }
                   ],
                   "dimensions":[
                      {
                         "fieldName":"derived_loc_state",
                         "aliasName":"state"
                      },
                      {
                         "fieldName":"derived_loc_district",
                         "aliasName":"district"
                      }
                   ],
                   "filters":[
                      {
                         "type":"in",
                         "dimension":"context_pdata_id",
                         "values":[
                           "{{ producer_env }}.diksha.portal",
                           "{{ producer_env }}.diksha.app"
                         ]
                      },
                      {
                         "type":"isnotnull",
                         "dimension":"derived_loc_state"
                      },
                      {
                         "type":"isnotnull",
                         "dimension":"derived_loc_district"
                      }
                   ],
                   "descending":"false"
                }
             },
             {
                "metric":"totalUniqueDevicesOnPortal",
                "label":"Total Unique Devices on Portal",
                "druidQuery":{
                   "queryType":"groupBy",
                   "dataSource":"telemetry-events",
                   "intervals":"LastWeek",
                   "aggregations":[
                      {
                         "name":"total_unique_devices_on_portal",
                         "type":"cardinality",
                         "fieldName":"context_did"
                      }
                   ],
                   "dimensions":[
                      {
                         "fieldName":"derived_loc_state",
                         "aliasName":"state"
                      },
                      {
                         "fieldName":"derived_loc_district",
                         "aliasName":"district"
                      }
                   ],
                   "filters":[
                      {
                         "type":"equals",
                         "dimension":"context_pdata_id",
                         "value":"{{ producer_env }}.diksha.portal"
                      },
                      {
                         "type":"isnotnull",
                         "dimension":"derived_loc_state"
                      },
                      {
                         "type":"isnotnull",
                         "dimension":"derived_loc_district"
                      }
                   ],
                   "descending":"false"
                }
             },
             {
                "metric":"totalUniqueDevicesOnApp",
                "label":"Total Unique Devices on App",
                "druidQuery":{
                   "queryType":"groupBy",
                   "dataSource":"telemetry-events",
                   "intervals":"LastWeek",
                   "aggregations":[
                      {
                         "name":"total_unique_devices_on_app",
                         "type":"cardinality",
                         "fieldName":"context_did"
                      }
                   ],
                   "dimensions":[
                      {
                         "fieldName":"derived_loc_state",
                         "aliasName":"state"
                      },
                      {
                         "fieldName":"derived_loc_district",
                         "aliasName":"district"
                      }
                   ],
                   "filters":[
                      {
                         "type":"equals",
                         "dimension":"context_pdata_id",
                         "value":"{{ producer_env }}.diksha.app"
                      },
                      {
                         "type":"isnotnull",
                         "dimension":"derived_loc_state"
                      },
                      {
                         "type":"isnotnull",
                         "dimension":"derived_loc_district"
                      }
                   ],
                   "descending":"false"
                }
             },
             {
                "metric":"totalQRScans",
                "label":"Total QR Scans",
                "druidQuery":{
                   "queryType":"groupBy",
                   "dataSource":"telemetry-events",
                   "intervals":"LastWeek",
                   "aggregations":[
                      {
                         "name":"total_scans",
                         "type":"count",
                         "fieldName":""
                      }
                   ],
                   "dimensions":[
                      {
                         "fieldName":"derived_loc_state",
                         "aliasName":"state"
                      },
                      {
                         "fieldName":"derived_loc_district",
                         "aliasName":"district"
                      }
                   ],
                   "filters":[
                    {
                        "type":"in",
                        "dimension":"context_pdata_id",
                        "values":[
                          "{{ producer_env }}.diksha.portal",
                          "{{ producer_env }}.diksha.app"
                        ]
                     },
                      {
                         "type":"equals",
                         "dimension":"eid",
                         "value":"SEARCH"
                      },
                      {
                         "type":"isnotnull",
                         "dimension":"edata_filters_dialcodes"
                      },
                      {
                         "type":"isnotnull",
                         "dimension":"derived_loc_state"
                      },
                      {
                         "type":"isnotnull",
                         "dimension":"derived_loc_district"
                      }
                   ],
                   "descending":"false"
                }
             },
             {
                "metric":"totalQRScansOnPortal",
                "label":"Total QR Scans on Portal",
                "druidQuery":{
                   "queryType":"groupBy",
                   "dataSource":"telemetry-events",
                   "intervals":"LastWeek",
                   "aggregations":[
                      {
                         "name":"total_scans_on_portal",
                         "type":"count",
                         "fieldName":""
                      }
                   ],
                   "dimensions":[
                      {
                         "fieldName":"derived_loc_state",
                         "aliasName":"state"
                      },
                      {
                         "fieldName":"derived_loc_district",
                         "aliasName":"district"
                      }
                   ],
                   "filters":[
                      {
                         "type":"equals",
                         "dimension":"context_pdata_id",
                         "value":"{{ producer_env }}.diksha.portal"
                      },
                      {
                         "type":"equals",
                         "dimension":"eid",
                         "value":"SEARCH"
                      },
                      {
                         "type":"isnotnull",
                         "dimension":"edata_filters_dialcodes"
                      },
                      {
                         "type":"isnotnull",
                         "dimension":"derived_loc_state"
                      },
                      {
                         "type":"isnotnull",
                         "dimension":"derived_loc_district"
                      }
                   ],
                   "descending":"false"
                }
             },
             {
                "metric":"totalQRScansOnApp",
                "label":"Total QR Scans on App",
                "druidQuery":{
                   "queryType":"groupBy",
                   "dataSource":"telemetry-events",
                   "intervals":"LastWeek",
                   "aggregations":[
                      {
                         "name":"total_scans_on_app",
                         "type":"count",
                         "fieldName":""
                      }
                   ],
                   "dimensions":[
                      {
                         "fieldName":"derived_loc_state",
                         "aliasName":"state"
                      },
                      {
                         "fieldName":"derived_loc_district",
                         "aliasName":"district"
                      }
                   ],
                   "filters":[
                      {
                         "type":"equals",
                         "dimension":"context_pdata_id",
                         "value":"{{ producer_env }}.diksha.app"
                      },
                      {
                         "type":"equals",
                         "dimension":"eid",
                         "value":"SEARCH"
                      },
                      {
                         "type":"isnotnull",
                         "dimension":"edata_filters_dialcodes"
                      },
                      {
                         "type":"isnotnull",
                         "dimension":"derived_loc_state"
                      },
                      {
                         "type":"isnotnull",
                         "dimension":"derived_loc_district"
                      }
                   ],
                   "descending":"false"
                }
             },
             {
                "metric":"totalContentPlays",
                "label":"Total Content Plays",
                "druidQuery":{
                   "queryType":"groupBy",
                   "dataSource":"summary-events",
                   "intervals":"LastWeek",
                   "aggregations":[
                      {
                         "name":"total_content_plays",
                         "type":"count",
                         "fieldName":""
                      }
                   ],
                   "dimensions":[
                      {
                         "fieldName":"derived_loc_state",
                         "aliasName":"state"
                      },
                      {
                         "fieldName":"derived_loc_district",
                         "aliasName":"district"
                      }
                   ],
                   "filters":[
                      {
                        "type":"in",
                        "dimension":"dimensions_pdata_id",
                        "values":[
                          "{{ producer_env }}.diksha.portal",
                          "{{ producer_env }}.diksha.app"
                        ]
                      },
                      {
                         "type":"equals",
                         "dimension":"dimensions_type",
                         "value":"content"
                      },
                      {
                         "type":"equals",
                         "dimension":"dimensions_mode",
                         "value":"play"
                      },
                      {
                         "type":"isnotnull",
                         "dimension":"derived_loc_state"
                      },
                      {
                         "type":"isnotnull",
                         "dimension":"derived_loc_district"
                      }
                   ],
                   "descending":"false"
                }
             },
             {
                "metric":"totalContentPlaysOnPortal",
                "label":"Total Content Plays on Portal",
                "druidQuery":{
                   "queryType":"groupBy",
                   "dataSource":"summary-events",
                   "intervals":"LastWeek",
                   "aggregations":[
                      {
                         "name":"total_content_plays_on_portal",
                         "type":"count",
                         "fieldName":""
                      }
                   ],
                   "dimensions":[
                      {
                         "fieldName":"derived_loc_state",
                         "aliasName":"state"
                      },
                      {
                         "fieldName":"derived_loc_district",
                         "aliasName":"district"
                      }
                   ],
                   "filters":[
                      {
                         "type":"equals",
                         "dimension":"dimensions_pdata_id",
                         "value":"{{ producer_env }}.diksha.portal"
                      },
                      {
                         "type":"equals",
                         "dimension":"dimensions_type",
                         "value":"content"
                      },
                      {
                         "type":"equals",
                         "dimension":"dimensions_mode",
                         "value":"play"
                      },
                      {
                         "type":"isnotnull",
                         "dimension":"derived_loc_state"
                      },
                      {
                         "type":"isnotnull",
                         "dimension":"derived_loc_district"
                      }
                   ],
                   "descending":"false"
                }
             },
             {
                "metric":"totalContentPlaysOnApp",
                "label":"Total Content Plays on App",
                "druidQuery":{
                   "queryType":"groupBy",
                   "dataSource":"summary-events",
                   "intervals":"LastWeek",
                   "aggregations":[
                      {
                         "name":"total_content_plays_on_app",
                         "type":"count",
                         "fieldName":""
                      }
                   ],
                   "dimensions":[
                      {
                         "fieldName":"derived_loc_state",
                         "aliasName":"state"
                      },
                      {
                         "fieldName":"derived_loc_district",
                         "aliasName":"district"
                      }
                   ],
                   "filters":[
                      {
                         "type":"equals",
                         "dimension":"dimensions_pdata_id",
                         "value":"{{ producer_env }}.diksha.app"
                      },
                      {
                         "type":"equals",
                         "dimension":"dimensions_type",
                         "value":"content"
                      },
                      {
                         "type":"equals",
                         "dimension":"dimensions_mode",
                         "value":"play"
                      },
                      {
                         "type":"isnotnull",
                         "dimension":"derived_loc_state"
                      },
                      {
                         "type":"isnotnull",
                         "dimension":"derived_loc_district"
                      }
                   ],
                   "descending":"false"
                }
             }
        ],
        "labels":{
          "state":"State",
          "district":"District",
          "total_unique_devices":"Total Unique Devices",
          "total_unique_devices_on_portal":"Total Unique Devices on Portal",
          "total_unique_devices_on_app":"Total Unique Devices on App",
          "total_scans":"Total QR Scans",
          "total_scans_on_portal":"Total QR Scans on Portal",
          "total_scans_on_app":"Total QR Scans on App",
          "total_content_plays":"Total Content Plays",
          "total_content_plays_on_portal":"Total Content Plays on Portal",
          "total_content_plays_on_app":"Total Content Plays on App"
        },
        "output":[
          {
            "type":"csv",
            "metrics":[
                "total_unique_devices",
                "total_unique_devices_on_portal",
                "total_unique_devices_on_app",
                "total_scans",
                "total_scans_on_portal",
                "total_scans_on_app",
                "total_content_plays",
                "total_content_plays_on_portal",
                "total_content_plays_on_app"
            ],
            "dims":[
                "state"
            ],
            "fileParameters":[
                "id",
                "dims"
            ]
          }
        ]
      }
```



*  **Output:** 

The output for location reports from the DruidQueryProcessingModel would be a csv file containing the metrics for districts of that particular state. A new file will be generated every week with the district data.

Format for district weekly report:



| Date | District | Total Unique Devices | Unique Devices on App | Unique Devices on Portal | Total Number of QR Scans | Number of QR Scans on App | Number of QR Scans on Portal | Total Number of Content Plays | Number of Content Plays on App | Number of Content Plays on Portal | 
|  --- |  --- |  --- |  --- |  --- |  --- |  --- |  --- |  --- |  --- |  --- | 
|  **09/06/2019**  | Bilaspur | 17 | 6 | 11 | 188 | 98 | 45 | 117 | 61 | 47 | 
|  **09/06/2019**  | Dantewada | 8 | 7 | 1 | 71 | 60 | 67 | 78 | 40 | 32 | 
|  **09/06/2019**  | Raipur | 19 | 17 | 2 | 60 | 124 | 18 | 58 | 22 | 30 | 
|  **09/06/2019**  | Baster | 20 | 11 | 9 | 97 | 89 | 1 | 56 | 45 | 11 | 



Format for district monthly report:



| District | Unique Devices | 
|  --- |  --- | 
| Anantapur | 761 | 
| Chittoor | 1253 | 
| Kurnool | 1465 | 
| Nellore | 3624 | 





*****

[[category.storage-team]] 
[[category.confluence]] 
