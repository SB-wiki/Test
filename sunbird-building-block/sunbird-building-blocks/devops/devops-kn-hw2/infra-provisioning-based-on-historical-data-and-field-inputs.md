# Infra-Provisioning-Based-on-Historical-Data-and-Field-Inputs

**Problem:**

It is expected that, by end of June, 2019, about 28 States will be on DIKSHA, and the platform needs to support all that load.

Based on historical usage data (telemetry and API logs), and the field data known to Implementation, can we get an estimate of the Infra needed?

**Input Data:**

Field Inputs: What is known about the profile of the State that is going to come – such as

1. Number of students enrolled in Public Schools and Demographics (distribution by Class)
2. Subject, Medium, Class
3. Textbook descriptors such as a number of QR codes, size of the Textbook etc..

Historical Data:

1. Telemetry Events
2. API Logs

Load Testing Data

1. tps VS infra configuration needed

**Output Data:**

1. For every Service, provide an estimate of the Infra configuration needed

**Stage-1** :  **Filter** TaskFilter the events and logs between a certain time period, based on the Field Inputs to create a segment. The same filter needs to be applied to telemetry events and API logs.Expected OutputSame as original event structure, except that they are filtered.ChallengesEvery Filed input might not directly translate to a filter dimension. Have to use approximations/proxies in such cases. **Stage-2a** :  **Group By** Task

1. For every Telemetry event type, get the "COUNT" of those events for every "HOUR" by "DAY". (All words capital case are variables).&#x20;
2. For every API log event type, get the "MAXIMUM" number of those class for every "HOUR" by "DAY". (All words capital case are variables).&#x20;
3. For each day, get NEW number of devices (or Apps installs). This will be the adoption curve for that particular state.

Expected Output

Event Time Series

| Day | Hour | Event  | COUNT |
| --- | ---- | ------ | ----- |
|     | 00   | SCAN   | 10    |
|     | 00   | SEACRH | 0     |
|     | ..   |        |       |
|     | 00   | ASSESS | 10    |

API Log Time Series

| Day | Hour | API             | COUNT |
| --- | ---- | --------------- | ----- |
|     | 00   | FrameWorkRead   | 0     |
|     | 01   | CompositeSearch | 10    |
|     | ..   |                 |       |
|     | 01   | DialcodeRead    | 10    |

Adoption Curve

| Day | #AppInstalls | #DevicesAdded |
| --- | ------------ | ------------- |
|     | 200          | 10            |
|     |              |               |

\| 10 | 10 | | | | | | | | |

ChallengesSome heuristics might have to be developed to populate the columns. Some events (SCAN) may not be directly available, but it may have to derived from low level telemetry events like INTERACT  etc... May be, we have to use work flow summarizer to get these data. **Stage-2b** : **Cluster** TaskCluster the event and API logs to create several clusters. Each cluster represents a type of a load profile. For clustering, consider the "HOUR" as the dimension and "DAY" as a new instance. In this example, for each Event type cluster will have 24 data points, one at each hour. It is effectively clustering time-series data. Expected OutputEvent Time Series Cluster

| ClusterNum | Hour | Event | COUNT |
| ---------- | ---- | ----- | ----- |
| 1          | 00   | SCAN  | 2     |
| 1          | 00   | SCAN  | 0     |
|            | ..   |       |       |
| 1          | 23   | SCAN  | 10    |

API Log Cluster

| ClusterNum | Hour | API             | COUNT |
| ---------- | ---- | --------------- | ----- |
| 1          | 00   | CompositeSearch | 2     |
| 1          | 00   | CompositeSearch | 0     |
|            | ..   |                 |       |
| 1          | 23   | CompositeSearch | 10    |

[code](https://github.com/ekstep/Data-Science/blob/master/explore/poc/autoscale/segments/clusterEvents.py) for clustering (using python sklearn and pyspark mllib

ChallengesPlot the clusters, and see if they are making sense. Iterative on the "number" of clusters

**Stage-3** :  **Map Number of Events to API Calls** TaskMap Events  to API Calls. Run the following Seemingly Unrelated Regressiony1(k)  = β0+  β11(k) x1(k)  + β11(k) x1(k)  +... + β1m(k) xm(k) y2(k)  = β0+  β21(k) x1(k)  + β21(k) x1(k)  +... + β2m(k) xm(k) .....yn(k)  = β0+  βn1(k) x1(k)  + βn1(k) x2(k)  +... + βnm(k) xm(k) Here yi(k) is the maximum number calls between kth to (k+1) hour of the i-th API. Example, y1(1) is the maximum no of CompositeSearch calls at between 1am to 2am. xi(k) is the total count of i-th event between kth to (k+1) hour. Example, x1(2) is the total number of SCAN events  between 1am to 2am. [code](https://github.com/ekstep/Data-Science/blob/master/explore/poc/autoscale/segments/events2apis.py) for the SURChallengesTry to interpret the coefficients. Here we are assuming that:1) Event to API call mapping does not depend on the when they are called2) A single event can trigger multiple API calls3) And that mapping is linearDo those assumptions make sense, in the light of the data?

**Stage-4: Load to Infra** TaskMap "concurrent calls" to actual Infra requirements. Example:Expected Output

| Service | TPS | CPU:MEM:DISK |
| ------- | --- | ------------ |
| Search  | 300 | 4:16:128     |
| Search  | 600 | 8:31:128     |
|         | ..  |              |
|         |     |              |

[code](https://github.com/ekstep/Data-Science/blob/master/explore/poc/autoscale/segments/api2infra.py) for mapping, given load testing data

&#x20; _With the above four pieces in places, one can play with a profile of a state (inputs) and look at the intermediate data at every stage and look at the eventual the infra requirements. he mappings can be improved over time. A little UI can be built to run different scenarios, adjust the mappings until  you get confidence and  go for the kill._

***

\[\[category.storage-team]] \[\[category.confluence]]
