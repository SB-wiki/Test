# \[Data-Product]-Dashboard-summariser---Cumulative

#### Summary:

* **Type**  - Dashboard cumulative summariser
* **Granularity**  - DAY
* **Computation Level**  - Level 3
* **Frequency**  - Runs Daily

**Purpose:** The Dashboard summariser is used to compute the

1. **Unique Devices**  - The total number of unique devices that have ever accessed Diksha (across portal and app)
2. **Learning Experiences**  - The total number of content play sessions across portal and app to current date.
3. **Hours of interaction**  - The total time spent on Diksha (i.e. total session time, inclusive of but not limited to content play sessions)

#### Inputs:

&#x20;        Derived Event : ME\_WORKFLOW\_SUMMARY

#### Output

```
{
  "eid": "ME_PORTAL_CUMULATIVE_METRICS",
  "ets": 1544670495619,
  "syncts": 1544670495619,
  "metrics_summary": {
    "noOfUniqueDevices": 1323,
    "totalContentPlayTime": 29.24,
    "totalTimeSpent": 35577.22,
    "totalContentPublished": 4105
  }
}
```

#### Algorithm

|   | Field             | Description                                                                                     | Computation                                                       |
| - | ----------------- | ----------------------------------------------------------------------------------------------- | ----------------------------------------------------------------- |
| 1 | noOfUniqueDevices | This metric tracks the total number of unique devices that have accessed Diksha(Portal and App) | filter by with below fields and compute the total distinct count  |

```
filter((d_period = 0 ) and (d_tag=="all") and (d_content_id=='all')and (d_user_id=='all') and (d_deviceId!='all') and distinctCount(d_device_id)
```

\| | 2 | totalDigitalContentPublished  | Number of contents been published | composite search API: **/composite/v3/search** | | 3 | totalContentPlaySessions | This metric tracks the total number of content play sessions (Portal and App). | filter with below fields and  aggregating the edata.eks.time\_spent field

```
filter((d_period = 0) and (d_tag=="all") and (d_content_id=='all')and (d_user_id=='all') and (d_mode=='play') and (d_type=='content') and  aggregate(m_total_sessions)
```

\| | 4 | totalTimeSpent | This metric track the total time spent on Diksha(Portal and App) | filter by with below fields and  aggregating the edata.eks.time\_spent field

```
filter((d_period = 0) and (d_tag=="all") and (d_content_id=='all')and (d_user_id=='all') and   (d_type=='app' ||'session') and (d_deviceId=='all') aggregate(m_total_ts)
```

|

#### Conclusion:

***

\[\[category.storage-team]] \[\[category.confluence]]
