
## Overview
This document explains the assumptions and implementation design to provide assessment score related details and its usage in provide merit(progress + assessment) certificates.

This includes changes in existing APIs related to course progress and certificates and flink jobs for issuing the certificates.


## Assumptions

1. From backend services and jobs, default max number of attempts will be  **25**  attempts, which will be configuration based.


1. If max attempts is defined from the client side and if it is less than  **25** , those many attempts will be considered.


1. In release-3.5, we will be having only one assessment per course.




## Design
The implementation design includes changes related to both APIs and certificate jobs.


### Platform-Courses API
ContentStateRead API will include assessment attempts and corresponding scores with max attempts configured as  **25** in the response.

”fields”: \[“progress”, ”score”] will be introduces in request, which provides details related to both course progress and scores.

 **Request:** 


```json
{
    "request": {
        "userId": "USER_ID",
        "courseId": "COURSE_ID",
        "batchId": "BATCH_ID",
        "contentIds": [LIST_OF_CONTENT_IDS],
        "fields": ["progress", "score"] // default value is progress
    }
}
```
 **Response:** 


```json
"result": {
        "contentList": [
            {
                "lastAccessTime": "Time in yyyy-MM-dd HH:mm:ss:SSS+Z format"2020-10-29 12:58:35:179+0000",
                "contentId": "contentId",
                "progress": 100(progress),
                "viewCount": 6(viewCount),
                "completedCount": 6(number of time content is completed),
                "batchId": "batchId",
                "courseId": "CourseId",
                "collectionId": "CourseId",
                "lastCompletedTime": "Time in yyyy-MM-dd HH:mm:ss:SSS+Z format",
                "status": 2(Status 1->In-progress, 2->Completed),
                "score": [{
                	"attemptId" : "attemptId",
                	"lastAttemptedOn": "Time in yyyy-MM-dd HH:mm:ss:SSS+Z format",,
                	"totalMaxScore": TotalMaxScore(integer)
                	"totalScore": Total Score gained(integer)
                },
                {...}..]
            }
        ]
    }
```



### Certificate issuance and generation jobs
Currently, certificate-pre-processor job has the ability to issue certificate for the users who satisfy both progress and assessment criteria(merit).

Best score of all attempts are considered for merit criteria. The same will be continued.

 **Trigger points:** 


1. For completion certificates, one progress reach 100%, the issue certificate event is sent from course-batch-updater job.


1. If user scores more than merit criteria before/on 100% progress, the existing flow will take care of issuing merit certificate.


1. If user scores merit criteria after 100% progress, the issue certificate event is sent from assessment-aggregator job




## Clarifications
  - What is the expected size of the course(max number of linked contents) with assessment ? This is required to check the size of the response for contentStateRead API with assessments details.


## Conclusion

TODO




*****

[[category.storage-team]] 
[[category.confluence]] 
