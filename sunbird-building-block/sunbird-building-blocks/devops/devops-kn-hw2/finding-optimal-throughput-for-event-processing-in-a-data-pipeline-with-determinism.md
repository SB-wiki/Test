# finding-optimal-throughput-for-event-processing-in-a-data-pipeline-with-determinism

[SB-12205 System JIRA](https://browse/SB-12205)

**Context:**

Say, 500 Millions telemetry events are to be syncd and load pattern is known (such as the peak is at 9am and 2pm and normal usage otherwise). The telemetry processing system is processing these events with fixed throughput for a certain period of time.

What is the smallest throughput of the system that can process all events synced before 12am by 2am.

**Inputs:**

```js
{
  "loadUnits":{"time":"hours", "load": "million", "type": "events"},
  "totalLoad": 500,
  "backLogs":200,
  "loadCurve": [
    {
      "time": 1,
      "load": 1
    },
    {
      "time": 2,
      "load": 1
    },
    {
      "time": 3,
      "load": 1
    },
    {
      "time": 4,
      "load": 2
    },
    {
      "time": 5,
      "load": 0
    },
    {
      "time": 6,
      "load": 0
    }
  ],
  "downTime":
  [{"when": 2, "duration":0.5}],
  "bufferLength":2
}
```

Description of the input:

**loadUnits** : units for time (in hours, minutes etc..) and events (million, thousands etc)

**totalLoad** : number of events to be processed in net duration (say 6am to 12am) such as 500 million

\*\*backLogs: \*\* how many events are pending before the onset

**totalCurve** : an array of (time and load). What fraction of the total load is to be seen and When

**downTime** : an array of (when and duration): When the system is going to be shutdown and for how long (in same units of time)

**bufferLength** : for how many time units the system is allowed to run so that throuput can be lowered further (at this time, system does not accept new events)

**Output:**

optimal throughput for the given number of totalEvents, downTime, backLogs, and loadCurve.

For every additional buffer period, it is recalculated.

**Approach** : A constrained minimization problem.

For the above input (shown JSON), the output is

\*\* finding optimal throughput \*\*

throughput required is:  117 million events per hour

adding 1 unit of time to lower throughput

throughput required is :  100 million events per hour

adding 2 unit of time to lower throuput

throughput required is :  88 million events per hour

code is [here](https://github.com/ekstep/Data-Science/blob/master/explore/poc/autoscale/druidIndexing.py)

***

\[\[category.storage-team]] \[\[category.confluence]]
