
## Overview
This document details the design options for introducing scores as part of group aggregate API and reports.


## Design
Currently, only trackable collections and their progress are stored in user_activity_agg table.

Below is the flow used to show scores in group aggregates.

 **AssessmentAggregator job changes:** 

Create a new process function to compute the best attempted score and store it in user_activity_agg table in below format.



| activity_type | activity_id | user_id | context_id | agg | agg_last_updated | 
|  --- |  --- |  --- |  --- |  --- |  --- | 
| Course | collectionId | user_123 | cb:batch_123 | {'score:assessmentId_1': <best attempted score>,'score:assessmentId_2': <best attempted score>} | {'score:assessmentId_1': ‘timestamp’, 'score:assessmentId_2':: ‘timestamp’} | 

 **Implementation steps:** 


* Read the best score from assessment_aggregate table using courseId, userId, batchId and contentId from the event


* Partial update the agg and agg_last_updated columns in user_activity_agg 



 **Group Aggregate API changes:** 

The response contains the score aggregates also if the collection contains self assessments.

 **Response:** 


```
{
    "id": "api.group.activity.agg",
    "ver": "v1",
    "ts": "2021-04-14 17:49:30:782+0530",
    "params": {
        "resmsgid": null,
        "msgid": "70b89413-fe1f-482a-b92a-e27d4af0ae4f",
        "err": null,
        "status": "success",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "activity": {
            "id": "collectionId",
            "type": "Course",
            "agg": [
                {
                    "metric": "enrolmentCount",
                    "lastUpdatedOn": 1618390479814,
                    "value": 1 <totla number of enrolments>
                }
            ]
        },
        "groupId": "groupId",
        "members": [
            {
                "agg": [
                    {
                        "metric": "completedCount",
                        "value": 2,
                        "lastUpdatedOn": 1596647700613
                    },
                    {
                        "metric": "score:assessmentId_1",
                        "value": 10, <best attempted score>
                        "lastUpdatedOn": 1618390479814
                    },
                    {
                        "metric": "score:assessmentId_2",
                        "value": 20, <best attempted score>
                        "lastUpdatedOn": 1618390479814
                    }
                ],
                "name": "",
                "role": "admin",
                "status": "active",
                "createdBy": "userId",
                "userId": "userId"
            }
        ]
    }
}
```


*****

[[category.storage-team]] 
[[category.confluence]] 
