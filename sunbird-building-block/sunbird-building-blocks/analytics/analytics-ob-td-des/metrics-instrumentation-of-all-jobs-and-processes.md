# Metrics-instrumentation-of-all-jobs-and-processes

## Introduction

Here we are introducing a new event ID to the V3 telemetry specification, i.e METRIC event and it has below event structure. All components will be sending metric with this below event structure

**Metric**  event consists of following fields in the  _edata_  section:

1. System: High level system ID from which metrics are being generated. This field is mandatory.
2. Subsystem: self-contained system ID within a High level system. This field is optional.
3. Metrics: consists of metric values and its type. This field is mandatory.
4. frequency: to denote the frequency of this metric being generated. This is an optional field.

```
// METRIC event
{
    "edata": {
        "system": "", // High level system e.g "Data Pipeline", "Data Products", "Analytics API" . // required
        "subsystem": "", // sub system type e.g "Denormalization", "WorkFlowSummaryModel"       // Optional
        "metrics": [{ // metrics  // required
            "metric": "", // metric e.g "count", "inputCount", "outputCount", "consumerLag", "timeTaken"
            "value": , // value for the metric
            "range": {"min": , "max": "" } // Optional. Rule if any e.g Range("1000000", "1500000")
        }],
        "frequency": // Frequency of metric event generation in mins e.g 5 - pipeline metrics, 1440 - data products // Optional
    }
}
```

## List of System and Subsystem values with producer data:

| Jobs/Processes      | Producer - id       | Producer - pid        | System       | Subsystem                                                                                                                                                                                                                                                                   |
| ------------------- | ------------------- | --------------------- | ------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Pipeline Samza jobs | pipeline.monitoring | samza.metrics         | DataPipeline | Job Names - DeDuplication DeNormalization DruidEventsValidator EventsRouter RedisUpdater TelemetryExtractor TelemetryLocationUpdater TelemetryRouter TelemetryValidator DeviceProfileUpdater ContentCacheUpdater UserCacheUpdater AssessmentAggregator DerivedDeDuplication |
| Data products       | pipeline.monitoring | dataproduct.metrics   | DataProduct  | Job Names - WorkFlowSummaryModel WorkFlowUsageSummaryModel ETBCoverageSummaryModel UpdateContentRating DataExhaustJob DeviceSummaryModel etc..                                                                                                                              |
| Analytics APIs      | pipeline.monitoring | analytics.api.metrics | AnalyticsAPI | API names - DeviceRegisterAPI DeviceProfileAPI DataExhaustAPI etc..                                                                                                                                                                                                         |
| Reporting Jobs      | pipeline.monitoring | reporting.job.metrics | ReportingJob | Report names                                                                                                                                                                                                                                                                |
| Adhoc Jobs          | pipeline.monitoring | adhoc.job.metrics     | AdhocJob     | Job names                                                                                                                                                                                                                                                                   |

## Sample events by module

#### 1. Metric event sample for Samza jobs:

```
{
  "eid": "METRIC",
  "ets": 1574015713706,
  "ver": "3.0",
  "mid": "",// Required. Unique message ID

  "actor": {
    "id": "analytics",
    "type": "System"
  },

  "context": { 
    "channel": "",
    "pdata": {
      "id": "pipeline.monitoring",
      "pid": "samza.metrics",
      "ver":  "1.0"
    },
    "env": "sunbirddev"
  },
  "edata": {
        "system": "DataPipeline",
        "subsystem": "DeNormalization",
        "metrics": [
        {
            "metric": "partition",
            "value": 3
        },
        { 
            "metric": "success-message-count",
            "value": 1153
        },
        { 
            "metric": "cache-hit-count",
            "value": 649
        },
        { 
            "metric": "cache-empty-values-count",
            "value": 984
        },
        {
            "metric": "user-cache-hit-count",
            "value": 891
        },
        {
            "metric": "failed-message-count",
            "value": 0
        },
        { 
            "metric": "consumer-lag",
            "value": 143
        }
        ],
        "frequency": 5
  }
}
```

#### 2. Metric event sample for Data products:

```
{
  "eid": "METRIC",
  "ets": 1574015713706,
  "ver": "3.0",
  "mid": "",// Required. Unique message ID

  "actor": {
    "id": "analytics",
    "type": "System"
  },

  "context": { 
    "channel": "",
    "pdata": {
      "id": "pipeline.monitoring",
      "pid": "dataproduct.metrics",
      "ver":  "1.0"
    },
    "env": "sunbirddev"
  },
  "edata": {
        "system": "DataProduct",
        "subsystem": "WorkFlowSummaryModel",
         "metrics": [
        { 
            "metric": "inputCount",
            "value": 23397933,
        },
        { 
            "metric": "outputCount",
            "value": 1027033,
        },
        { 
            "metric": "timeTakenSecs",
            "value": 1308,
        },
        { 
            "metric": "date",
            "value": "2019-11-01",
        }
        ],
        "frequency": 1440
  }
}
```

#### 3. Metric event sample for reporting jobs:

```
{
  "eid": "METRIC",
  "ets": 1574015713706,
  "ver": "3.0",
  "mid": "",// Required. Unique message ID

  "actor": {
    "id": "analytics",
    "type": "System"
  },

  "context": { 
    "channel": "",
    "pdata": {
      "id": "pipeline.monitoring",
      "pid": "reporting.job.metrics",
      "ver":  "1.0"
    },
    "env": "sunbirddev"
  },
  "edata": {
        "system": "ReportingJob",
        "subsystem": "ETB-reports",
         "metrics": [
        { 
            "metric": "noOfFilesUploaded",
            "value": 100,
        },
        { 
            "metric": "timeTakenSecs",
            "value": 1308,
        },
        { 
            "metric": "date",
            "value": "2019-11-01",
        }
        ],
        "frequency": 1440
  }
}
```

***

\[\[category.storage-team]] \[\[category.confluence]]
