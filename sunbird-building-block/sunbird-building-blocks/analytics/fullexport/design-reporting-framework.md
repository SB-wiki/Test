# \[Design]-Reporting-Framework

**Introduction:** This document explains the current reporting state, its key problems and the proposed solution for generalising the reporting framework using the built-in analytics framework which can be extended for various use cases with reduced development effort.

**Analytics Framework - Current State**

\*\*Druid based reports: \*\* **Below is the configuration for daily metrics job using Druid Query Model**

```
{
    "search": {
        "type": "none"
    },
    "model": "org.ekstep.analytics.model.DruidQueryProcessingModel",
    "modelParams": {
        "reportConfig": {
            "id": "ETB-Consumption-Daily-Reports",
            "queryType": "timeseries",
            "dateRange": {
                "staticInterval": "LastDay",
                "granularity": "day"
            },
            "metrics": [
                {
                    "metric": "totalSuccessfulScans",
                    "label": "Total Successful QR Scans",
                    "druidQuery": {
                        "queryType": "timeSeries",
                        "dataSource": "telemetry-events",
                        "intervals": "LastDay",
                        "aggregations": [
                            {
                                "name": "total_successful_scans",
                                "type": "count",
                                "fieldName": ""
                            }
                        ],
                        "filters": [
                            {
                                "type": "isnotnull",
                                "dimension": "edata_filters_dialcodes"
                            },
                            {
                                "type": "equals",
                                "dimension": "eid",
                                "value": "SEARCH"
                            },
                            {
                                "type": "greaterthan",
                                "dimension": "edata_size",
                                "value": 0
                            }
                        ],
                        "descending": "false"
                    }
                },
                {
                    "metric": "totalPercentFailedScans",
                    "label": "Total Percent Failed QR Scans",
                    "druidQuery": {
                        "queryType": "timeSeries",
                        "dataSource": "telemetry-events",
                        "intervals": "LastDay",
                        "aggregations": [
                            {
                                "name": "total_failed_scans",
                                "type": "javascript",
                                "fieldName": "edata_size",
                                "fnAggregate": "function(current, edata_size) { return current + (edata_size == 0 ? 1 : 0); }",
                                "fnCombine": "function(partialA, partialB) { return partialA + partialB; }",
                                "fnReset": "function () { return 0; }"
                            },
                            {
                                "name": "total_scans",
                                "type": "count",
                                "fieldName": ""
                            }
                        ],
                        "filters": [
                            {
                                "type": "isnotnull",
                                "dimension": "edata_filters_dialcodes"
                            },
                            {
                                "type": "equals",
                                "dimension": "eid",
                                "value": "SEARCH"
                            }
                        ],
                        "postAggregation": [
                            {
                                "type": "javascript",
                                "name": "total_percent_failed_scans",
                                "fields": {
                                    "leftField": "total_failed_scans",
                                    "rightField": "total_scans",
                                    "rightFieldType": "FieldAccess"
                                },
                                "fn": "function(total_failed_scans, total_scans) { return (total_scans > 0) ? (total_failed_scans/total_scans) * 100 : 0 }"
                            }
                        ],
                        "descending": "false"
                    }
                },
                {
                    "metric": "totalContentDownload",
                    "label": "Total Content Download",
                    "druidQuery": {
                        "queryType": "timeSeries",
                        "dataSource": "telemetry-events",
                        "intervals": "LastDay",
                        "aggregations": [
                            {
                                "name": "total_content_download",
                                "type": "count",
                                "fieldName": ""
                            }
                        ],
                        "filters": [
                            {
                                "type": "equals",
                                "dimension": "edata_subtype",
                                "value": "ContentDownload-Success"
                            },
                            {
                                "type": "equals",
                                "dimension": "eid",
                                "value": "INTERACT"
                            },
                            {
                                "type": "in",
                                "dimension": "dimensions_pdata_id",
                                "values": [
                                    "'$producerEnv'.diksha.app",
                                    "'$producerEnv'.diksha.portal",
                                    "'$producerEnv'.diksha.desktop"
                                ]
                            }
                        ],
                        "descending": "false"
                    }
                },
                {
                    "metric": "totalContentDownloadByApp",
                    "label": "Total Content Download on App",
                    "druidQuery": {
                        "queryType": "timeSeries",
                        "dataSource": "telemetry-events",
                        "intervals": "LastDay",
                        "aggregations": [
                            {
                                "name": "total_content_download_on_app",
                                "type": "count",
                                "fieldName": ""
                            }
                        ],
                        "filters": [
                            {
                                "type": "equals",
                                "dimension": "edata_subtype",
                                "value": "ContentDownload-Success"
                            },
                            {
                                "type": "equals",
                                "dimension": "eid",
                                "value": "INTERACT"
                            },
                            {
                                "type": "equals",
                                "dimension": "context_pdata_id",
                                "value": "'$producerEnv'.diksha.app"
                            }
                        ],
                        "descending": "false"
                    }
                },
                {
                    "metric": "totalContentDownloadByPortal",
                    "label": "Total Content Download on Portal",
                    "druidQuery": {
                        "queryType": "timeSeries",
                        "dataSource": "telemetry-events",
                        "intervals": "LastDay",
                        "aggregations": [
                            {
                                "name": "total_content_download_on_portal",
                                "type": "count",
                                "fieldName": ""
                            }
                        ],
                        "filters": [
                            {
                                "type": "equals",
                                "dimension": "edata_subtype",
                                "value": "ContentDownload-Success"
                            },
                            {
                                "type": "equals",
                                "dimension": "eid",
                                "value": "INTERACT"
                            },
                            {
                                "type": "equals",
                                "dimension": "context_pdata_id",
                                "value": "'$producerEnv'.diksha.portal"
                            }
                        ],
                        "descending": "false"
                    }
                },
                {
                    "metric": "totalContentDownloadByDesktop",
                    "label": "Total Content Download on Desktop",
                    "druidQuery": {
                        "queryType": "timeSeries",
                        "dataSource": "telemetry-events",
                        "intervals": "LastDay",
                        "aggregations": [
                            {
                                "name": "total_content_download_on_desktop",
                                "type": "count",
                                "fieldName": ""
                            }
                        ],
                        "filters": [
                            {
                                "type": "equals",
                                "dimension": "edata_subtype",
                                "value": "ContentDownload-Success"
                            },
                            {
                                "type": "equals",
                                "dimension": "eid",
                                "value": "INTERACT"
                            },
                            {
                                "type": "equals",
                                "dimension": "context_pdata_id",
                                "value": "'$producerEnv'.diksha.desktop"
                            }
                        ],
                        "descending": "false"
                    }
                },
                {
                    "metric": "totalContentPlayed",
                    "label": "Total Content Played",
                    "druidQuery": {
                        "queryType": "timeseries",
                        "dataSource": "summary-events",
                        "intervals": "LastDay",
                        "aggregations": [
                            {
                                "name": "total_content_plays",
                                "type": "count",
                                "fieldName": ""
                            }
                        ],
                        "filters": [
                            {
                                "type": "equals",
                                "dimension": "eid",
                                "value": "ME_WORKFLOW_SUMMARY"
                            },
                            {
                                "type": "in",
                                "dimension": "dimensions_pdata_id",
                                "values": [
                                    "'$producerEnv'.diksha.app",
                                    "'$producerEnv'.diksha.portal",
                                    "'$producerEnv'.diksha.desktop"
                                ]
                            },
                            {
                                "type": "equals",
                                "dimension": "dimensions_type",
                                "value": "content"
                            },
                            {
                                "type": "equals",
                                "dimension": "dimensions_mode",
                                "value": "play"
                            }
                        ],
                        "descending": "false"
                    }
                },
                {
                    "metric": "totalContentPlayedOnApp",
                    "label": "Total Content Played On App",
                    "druidQuery": {
                        "queryType": "timeseries",
                        "dataSource": "summary-events",
                        "intervals": "LastDay",
                        "aggregations": [
                            {
                                "name": "total_content_plays_on_app",
                                "type": "count",
                                "fieldName": ""
                            }
                        ],
                        "filters": [
                            {
                                "type": "equals",
                                "dimension": "eid",
                                "value": "ME_WORKFLOW_SUMMARY"
                            },
                            {
                                "type": "equals",
                                "dimension": "dimensions_pdata_id",
                                "value": "'$producerEnv'.diksha.app"
                            },
                            {
                                "type": "equals",
                                "dimension": "dimensions_type",
                                "value": "content"
                            },
                            {
                                "type": "equals",
                                "dimension": "dimensions_mode",
                                "value": "play"
                            }
                        ],
                        "descending": "false"
                    }
                },
                {
                    "metric": "totalContentPlayedOnPortal",
                    "label": "Total Content Played On Portal",
                    "druidQuery": {
                        "queryType": "timeseries",
                        "dataSource": "summary-events",
                        "intervals": "LastDay",
                        "aggregations": [
                            {
                                "name": "total_content_plays_on_portal",
                                "type": "count",
                                "fieldName": ""
                            }
                        ],
                        "filters": [
                            {
                                "type": "equals",
                                "dimension": "eid",
                                "value": "ME_WORKFLOW_SUMMARY"
                            },
                            {
                                "type": "equals",
                                "dimension": "dimensions_pdata_id",
                                "value": "'$producerEnv'.diksha.portal"
                            },
                            {
                                "type": "equals",
                                "dimension": "dimensions_type",
                                "value": "content"
                            },
                            {
                                "type": "equals",
                                "dimension": "dimensions_mode",
                                "value": "play"
                            }
                        ],
                        "descending": "false"
                    }
                },
                {
                    "metric": "totalContentPlayedOnDesktop",
                    "label": "Total Content Played On Desktop",
                    "druidQuery": {
                        "queryType": "timeseries",
                        "dataSource": "summary-events",
                        "intervals": "LastDay",
                        "aggregations": [
                            {
                                "name": "total_content_plays_on_desktop",
                                "type": "count",
                                "fieldName": ""
                            }
                        ],
                        "filters": [
                            {
                                "type": "equals",
                                "dimension": "eid",
                                "value": "ME_WORKFLOW_SUMMARY"
                            },
                            {
                                "type": "equals",
                                "dimension": "dimensions_pdata_id",
                                "value": "'$producerEnv'.diksha.desktop"
                            },
                            {
                                "type": "equals",
                                "dimension": "dimensions_type",
                                "value": "content"
                            },
                            {
                                "type": "equals",
                                "dimension": "dimensions_mode",
                                "value": "play"
                            }
                        ],
                        "descending": "false"
                    }
                },
                {
                    "metric": "totalUniqueDevices",
                    "label": "Total Unique Devices",
                    "druidQuery": {
                        "queryType": "timeseries",
                        "dataSource": "summary-events",
                        "intervals": "LastDay",
                        "aggregations": [
                            {
                                "name": "total_unique_devices",
                                "type": "cardinality",
                                "fieldName": "dimensions_did"
                            }
                        ],
                        "filters": [
                            {
                                "type": "in",
                                "dimension": "dimensions_pdata_id",
                                "values": [
                                    "'$producerEnv'.diksha.app",
                                    "'$producerEnv'.diksha.portal",
                                    "'$producerEnv'.diksha.desktop"
                                ]
                            },
                            {
                                "type": "equals",
                                "dimension": "dimensions_type",
                                "value": "app"
                            }
                        ],
                        "descending": "false"
                    }
                },
                {
                    "metric": "totalUniqueDevicesOnApp",
                    "label": "Total Unique Devices On App",
                    "druidQuery": {
                        "queryType": "timeseries",
                        "dataSource": "summary-events",
                        "intervals": "LastDay",
                        "aggregations": [
                            {
                                "name": "total_unique_devices_on_app",
                                "type": "cardinality",
                                "fieldName": "dimensions_did"
                            }
                        ],
                        "filters": [
                            {
                                "type": "equals",
                                "dimension": "dimensions_pdata_id",
                                "value": "'$producerEnv'.diksha.app"
                            },
                            {
                                "type": "equals",
                                "dimension": "dimensions_type",
                                "value": "app"
                            }
                        ],
                        "descending": "false"
                    }
                },
                {
                    "metric": "totalUniqueDevicesOnPortal",
                    "label": "Total Unique Devices On Portal",
                    "druidQuery": {
                        "queryType": "timeseries",
                        "dataSource": "summary-events",
                        "intervals": "LastDay",
                        "aggregations": [
                            {
                                "name": "total_unique_devices_on_portal",
                                "type": "cardinality",
                                "fieldName": "dimensions_did"
                            }
                        ],
                        "filters": [
                            {
                                "type": "equals",
                                "dimension": "dimensions_pdata_id",
                                "value": "'$producerEnv'.diksha.portal"
                            },
                            {
                                "type": "equals",
                                "dimension": "dimensions_type",
                                "value": "app"
                            }
                        ],
                        "descending": "false"
                    }
                },
                {
                    "metric": "totalUniqueDevicesOnDesktop",
                    "label": "Total Unique Devices On Desktop",
                    "druidQuery": {
                        "queryType": "timeseries",
                        "dataSource": "summary-events",
                        "intervals": "LastDay",
                        "aggregations": [
                            {
                                "name": "total_unique_devices_on_desktop",
                                "type": "cardinality",
                                "fieldName": "dimensions_did"
                            }
                        ],
                        "filters": [
                            {
                                "type": "equals",
                                "dimension": "dimensions_pdata_id",
                                "value": "'$producerEnv'.diksha.desktop"
                            },
                            {
                                "type": "equals",
                                "dimension": "dimensions_type",
                                "value": "app"
                            }
                        ],
                        "descending": "false"
                    }
                },
                {
                    "metric": "totalContentPlayedInHour",
                    "label": "Total Content Played In Hour",
                    "druidQuery": {
                        "queryType": "timeseries",
                        "dataSource": "summary-events",
                        "intervals": "LastDay",
                        "aggregations": [
                            {
                                "name": "sum__edata_time_spent",
                                "type": "doubleSum",
                                "fieldName": "edata_time_spent"
                            }
                        ],
                        "filters": [
                            {
                                "type": "equals",
                                "dimension": "eid",
                                "value": "ME_WORKFLOW_SUMMARY"
                            },
                            {
                                "type": "in",
                                "dimension": "dimensions_pdata_id",
                                "values": [
                                    "'$producerEnv'.diksha.app",
                                    "'$producerEnv'.diksha.portal",
                                    "'$producerEnv'.diksha.desktop"
                                ]
                            },
                            {
                                "type": "equals",
                                "dimension": "dimensions_type",
                                "value": "content"
                            },
                            {
                                "type": "equals",
                                "dimension": "dimensions_mode",
                                "value": "play"
                            }
                        ],
                        "postAggregation": [
                            {
                                "type": "arithmetic",
                                "name": "total_time_spent_in_hours",
                                "fields": {
                                    "leftField": "sum__edata_time_spent",
                                    "rightField": 3600,
                                    "rightFieldType": "constant"
                                },
                                "fn": "/"
                            }
                        ],
                        "descending": "false"
                    }
                },
                {
                    "metric": "totalContentPlayedInHourOnApp",
                    "label": "Total Content Played In Hour On App",
                    "druidQuery": {
                        "queryType": "timeseries",
                        "dataSource": "summary-events",
                        "intervals": "LastDay",
                        "aggregations": [
                            {
                                "name": "sum__edata_time_spent",
                                "type": "doubleSum",
                                "fieldName": "edata_time_spent"
                            }
                        ],
                        "filters": [
                            {
                                "type": "equals",
                                "dimension": "eid",
                                "value": "ME_WORKFLOW_SUMMARY"
                            },
                            {
                                "type": "equals",
                                "dimension": "dimensions_pdata_id",
                                "value": "'$producerEnv'.diksha.app"
                            },
                            {
                                "type": "equals",
                                "dimension": "dimensions_type",
                                "value": "content"
                            },
                            {
                                "type": "equals",
                                "dimension": "dimensions_mode",
                                "value": "play"
                            }
                        ],
                        "postAggregation": [
                            {
                                "type": "arithmetic",
                                "name": "total_time_spent_in_hours_on_app",
                                "fields": {
                                    "leftField": "sum__edata_time_spent",
                                    "rightField": 3600,
                                    "rightFieldType": "constant"
                                },
                                "fn": "/"
                            }
                        ],
                        "descending": "false"
                    }
                },
                {
                    "metric": "totalContentPlayedInHourOnPortal",
                    "label": "Total Content Played In Hour On Portal",
                    "druidQuery": {
                        "queryType": "timeseries",
                        "dataSource": "summary-events",
                        "intervals": "LastDay",
                        "aggregations": [
                            {
                                "name": "sum__edata_time_spent",
                                "type": "doubleSum",
                                "fieldName": "edata_time_spent"
                            }
                        ],
                        "filters": [
                            {
                                "type": "equals",
                                "dimension": "eid",
                                "value": "ME_WORKFLOW_SUMMARY"
                            },
                            {
                                "type": "equals",
                                "dimension": "dimensions_pdata_id",
                                "value": "'$producerEnv'.diksha.portal"
                            },
                            {
                                "type": "equals",
                                "dimension": "dimensions_type",
                                "value": "content"
                            },
                            {
                                "type": "equals",
                                "dimension": "dimensions_mode",
                                "value": "play"
                            }
                        ],
                        "postAggregation": [
                            {
                                "type": "arithmetic",
                                "name": "total_time_spent_in_hours_on_portal",
                                "fields": {
                                    "leftField": "sum__edata_time_spent",
                                    "rightField": 3600,
                                    "rightFieldType": "constant"
                                },
                                "fn": "/"
                            }
                        ],
                        "descending": "false"
                    }
                },
                {
                    "metric": "totalContentPlayedInHourOnDesktop",
                    "label": "Total Content Played In Hour On Desktop",
                    "druidQuery": {
                        "queryType": "timeseries",
                        "dataSource": "summary-events",
                        "intervals": "LastDay",
                        "aggregations": [
                            {
                                "name": "sum__edata_time_spent",
                                "type": "doubleSum",
                                "fieldName": "edata_time_spent"
                            }
                        ],
                        "filters": [
                            {
                                "type": "equals",
                                "dimension": "eid",
                                "value": "ME_WORKFLOW_SUMMARY"
                            },
                            {
                                "type": "equals",
                                "dimension": "dimensions_pdata_id",
                                "value": "'$producerEnv'.diksha.desktop"
                            },
                            {
                                "type": "equals",
                                "dimension": "dimensions_type",
                                "value": "content"
                            },
                            {
                                "type": "equals",
                                "dimension": "dimensions_mode",
                                "value": "play"
                            }
                        ],
                        "postAggregation": [
                            {
                                "type": "arithmetic",
                                "name": "total_time_spent_in_hours_on_desktop",
                                "fields": {
                                    "leftField": "sum__edata_time_spent",
                                    "rightField": 3600,
                                    "rightFieldType": "constant"
                                },
                                "fn": "/"
                            }
                        ],
                        "descending": "false"
                    }
                }
            ],
            "labels": {
                "total_content_download": "Total Content Downloads",
                "total_content_download_on_app": "Total Content Downloads On App",
                "total_content_download_on_portal": "Total Content Downloads On Portal",
                "total_content_download_on_desktop": "Total Content Downloads On Desktop",
                "total_successful_scans": "Number of successful QR Scans",
                "total_percent_failed_scans": "Total Percent Failed Scans",
                "total_unique_devices": "Total Unique Devices",
                "total_unique_devices_on_app": "Total Unique Devices On App",
                "total_unique_devices_on_portal": "Total Unique Devices On Portal",
                "total_unique_devices_on_desktop": "Total Unique Devices On Desktop",
                "total_time_spent_in_hours": "Total Content Play Time (in hours)",
                "total_time_spent_in_hours_on_app": "Total Content Play Time on App (in hours)",
                "total_time_spent_in_hours_on_portal": "Total Content Play Time on Portal (in hours)",
                "total_time_spent_in_hours_on_desktop": "Total Content Play Time on Desktop (in hours)",
                "total_failed_scans": "Number of failed QR Scans",
                "total_scans": "Number of QR Scans",
                "total_content_plays": "Total Content Plays",
                "total_content_plays_on_app": "Total Content Plays On App",
                "total_content_plays_on_portal": "Total Content Plays On Portal",
                "total_content_plays_on_desktop": "Total Content Plays On Desktop"
            },
            "output": [
                {
                    "type": "csv",
                    "label": "scans",
                    "metrics": [
                        "total_content_download",
                        "total_content_download_on_app",
                        "total_content_download_on_portal",
                        "total_content_download_on_desktop",
                        "total_successful_scans",
                        "total_percent_failed_scans",
                        "total_unique_devices",
                        "total_unique_devices_on_app",
                        "total_unique_devices_on_portal",
                        "total_unique_devices_on_desktop",
                        "total_time_spent_in_hours",
                        "total_time_spent_in_hours_on_app",
                        "total_time_spent_in_hours_on_portal",
                        "total_time_spent_in_hours_on_desktop",
                        "total_failed_scans",
                        "total_scans",
                        "total_content_plays",
                        "total_content_plays_on_app",
                        "total_content_plays_on_portal",
                        "total_content_plays_on_desktop"
                    ],
                    "dims": [
                        
                    ],
                    "fileParameters": [
                        "id",
                        "dims"
                    ]
                }
            ]
        },
        "bucket": "{{ bucket }}",
        "key": "druid-reports/"
    },
    "output": [
        {
            "to": "console",
            "params": {
                "printEvent": false
            }
          }
    ],
    "parallelization": 8,
    "appName": "Druid Query Processor",
    "deviceMapping": false
  }
```

**Reports Functionality**

**Observations:**

After looking at the existing report jobs we can observe the following pattern emerge in terms of functionality :

1. The data is retrieved from telemetry and transactional data sources
2. All the data is joined to create a full data frame (similar to how a druid creates) on which the aggregate operations are done
3. The output of the job is stored in blob store in CSV and JSON format. CSV for downloading the report and JSON to display dashboards.
4. The reporting data is also being indexed into ElasticSearch for transactional based reports. For ex: Course Progress Report

And the following issues:

1. **Dependency on Analytics team** . The other teams/products are dependent on the analytics team to create, test and execute the report daily
2. **Duplication of code** . For ex: The user and org details are required in each report and are implemented in each report
3. **Reliability of the reports doesn't exist** . For ex: No proper logging, replay capabilities, no metrics generated and manual monitoring.
4. \*\*No integration into job manager. \*\* Many of the reports are built in python which makes it incompatible to run along with the existing data products. Due to this the dependencies are never known and the reports jobs go ahead with execution even if the core data product like WFS has failed to run for the day.
5. \*\*Inefficient implementation. \*\* Most of the reports are not implemented to be executed in distributed model (none is fully aware of spark fundamentals) and hence either take too long to execute or need huge memory requirements.
6. \*\*Insufficient logging. \*\* There is no proper logging mechanism to be able to debug an issue of report not being executed

**Key Design Problems** Following are the key design problems:

1. **Reliability of reports execution**
2. **Abstraction of spark internals in distributed computing and memory management**
3. **Scheduling and execution based on dependencies**
4. **Metrics generation for application monitoring**
5. **Reusability**

**Proposed Solution:** Based on the above observations, we propose to create a Reporting Framework on top of the existing analytics framework which will aid in building reports which are more maintainable, requires little development effort and learning curve and provides more stability.

![](<../../../../Analytics/Fullexport/images/storage/Reporting framework (2).jpg>)

***

\[\[category.storage-team]] \[\[category.confluence]]
