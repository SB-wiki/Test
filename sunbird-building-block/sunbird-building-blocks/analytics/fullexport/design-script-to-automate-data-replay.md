# \[Design]Script-to-automate-data-replay

## Introduction:

This document details about the pre steps and post steps required for data replay. Currently azure backup deletion for duplicates at sink points are done manually and this document describes the implementation design for the python script to automate replay process.

## Details:

* The replay script will automatically replay from any backup (sink topic) for any given date range.
* The script will back up all the data sources depending on sink topic backup for a given date, complete the replay and then delete the backup. It will also delete the druid segments.
* The script has below steps iterated for each days for the given date range:

**Step 1:**

* It will back up all the data sources depending on sink topic for a given date
* It deletes all the data sources for a given date
* It takes backup of druid segments details to be deleted

**Step 2:**

* Complete the replay - push events from sink topic backup to specified Kafka topic

**Step 3:**

*   In case of successful replay

    &#x20;   \- Delete the backup

    &#x20;   \- Delete the druid segments

    &#x20;   \- Push replay completed message with metrics(data count, number of files deleted in each data source, time taken for replay, replay date) to slack.
*   In case of failure

    &#x20;   \- Restore the backup

    &#x20;   \- Push replay failure message with error and other metrics to slack.

    &#x20;   \- Continue with the replay for next date if any

## Input params:

* **bucket** - azure bucket
* **prefix** - (Optional) azure backup folder from which replay has to be done
* **filePath** - (Optional) complete file path incase of missing data replay
* **startDate** - Replay start date in "yyyy-MM-dd" format. Ex: 2019-12-01
* **endDate** - Replay end date in "yyyy-MM-dd" format. Ex: 2019-12-01
* **topic** - output kafka topic
* **brokerList** - kafka broker details
* **deleteBackups** - boolean flag whether to delete backups or not. In case of missing data/failed data replay this flag will be set to false.

## JSON config for backups deletion:

```
{
    "ingest": {
        "outputKafkaTopic": "telemetry.raw",
        "dependentSinkSources": [
            {
                "type": "azure",
                "prefix": "raw"
            },
            {
                "type": "azure",
                "prefix": "unique"
            },
            {
                "type": "azure",
                "prefix": "channel"
            },
            {
                "type": "azure",
                "prefix": "telemetry-denormalized"
            },
            {
                "type": "druid",
                "prefix": "telemetry-events"
            },
            {
                "type": "druid",
                "prefix": "telemetry-log-events"
            },
            {
                "type": "druid",
                "prefix": "telemetry-error-events"
            },
            {
                "type": "druid",
                "prefix": "telemetry-feedback-events"
            }
        ]
    },
    "raw": {
        "outputKafkaTopic": "telemetry.valid",
        "dependentSinkSources": [
            {
                "type": "azure",
                "prefix": "unique"
            },
            {
                "type": "azure",
                "prefix": "channel"
            },
            {
                "type": "azure",
                "prefix": "telemetry-denormalized"
            },
            {
                "type": "druid",
                "prefix": "telemetry-events"
            },
            {
                "type": "druid",
                "prefix": "telemetry-log-events"
            },
            {
                "type": "druid",
                "prefix": "telemetry-error-events"
            },
            {
                "type": "druid",
                "prefix": "telemetry-feedback-events"
            }
        ]
    },
    "unique": {
        "outputKafkaTopic": "telemetry.sink",
        "dependentSinkSources": [
            {
                "type": "azure",
                "prefix": "channel"
            },
            {
                "type": "azure",
                "prefix": "telemetry-denormalized"
            },
            {
                "type": "druid",
                "prefix": "telemetry-events"
            },
            {
                "type": "druid",
                "prefix": "telemetry-log-events"
            },
            {
                "type": "druid",
                "prefix": "telemetry-error-events"
            },
            {
                "type": "druid",
                "prefix": "telemetry-feedback-events"
            }
        ]
    },
    "failed": {
        "outputKafkaTopic": "telemetry.raw",
        "dependentSinkSources": [
            
        ]
    },
    "wfs": {
        "outputKafkaTopic": "telemetry.sink",
        "dependentSinkSources": [
            {
                "type": "azure",
                "prefix": "channel"
            },
            {
                "type": "azure",
                "prefix": "telemetry-denormalized"
            },
            {
                "type": "druid",
                "prefix": "summary-events"
            }
        ]
    }
}    
```

***

\[\[category.storage-team]] \[\[category.confluence]]
