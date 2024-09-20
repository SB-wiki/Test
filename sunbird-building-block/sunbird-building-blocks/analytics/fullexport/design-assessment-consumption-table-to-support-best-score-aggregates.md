
## Introduction
This document details about the changes required to store best score aggregates and the APIs and jobs changes required to read the best scores.


### Problem Statement
In user_activity_agg table, agg column, the best scores are stored as int value. While the scores of each attempt is calculated as double.

The best score should always be of double value. Below are the key design problems


* Storing best scores as double value.


* APIs to handle both int and double value of best scores for backward compatibility


* Flink jobs changes to read best scores with backward compatibility.


* Supporting response exhaust jobs




## Design

### Table changes
Currently, we store aggregates in agg column of user_activity_agg table.

New aggregate column with data type Map<Text, Double> is introduced to store the scores and other aggregate data.


```
CREATE TABLE sunbird_courses.user_activity_agg (
    activity_type text,
    activity_id text,
    user_id text,
    context_id text,
    agg map<text, int>,
    aggregates map<text, double>, //new column, to store aggregates with double value
    agg_last_updated map<text, timestamp>,
    agg_details list<text>, 
    PRIMARY KEY ((activity_type, activity_id, user_id), context_id)
)
```

### API changes
In order to have backward compatibility, the APIs will merge the data from agg and aggregates columns with aggregates column data a priority.

Below are list of APIs and service.



|  **Service**  |  **API**  | 
|  --- |  --- | 
| Course Service | Content State Read (/v1/content/state/read)Group Aggregates Read(/v1/group/activity/agg) | 
| Viewer Service | Assessment Save(/v1/assess/save) Assessment Submit(/v1/assess/submit) Assessment Read (/v1/assess/read) | 


### Flink Jobs changes
Flink jobs which reads assessment aggregates require changes with backward compatibility.

Below are the jobs and changes required:



|  **Flink Jobs**  |  **Changes Required**  | 
|  --- |  --- | 
| Activity-aggregate-updater | Update completedCount to new column (aggregates) | 
| Collection-cert-pre-processor | Read best score by merging agg and aggregates columns, with the value in aggregates column as priority, and compute the overall best score for a course. | 
| Assessment Aggregator  | Updates best score and max score to new column (aggregates) | 


### Reporting jobs changes


|  **Data Products**  |  **Changes Required**  | 
|  --- |  --- | 
| Progress Exhaust - V2 | Read best score by merging agg and aggregates columns, with the value in aggregates column as priority. | 





*****

[[category.storage-team]] 
[[category.confluence]] 
