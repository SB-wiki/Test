# Design-to-get-list-of-ongoing-and-upcoming-open-batches.

**Problem statement :**

\*\*   \*\* Consumer want to show count of upcoming and ongoing open batches for a course.  Since course is stored under learning platform and created batch from course are stored under sunbird-LMS.

There are two different system and they don't know each other apart from validation.&#x20;

Proposed Solution 1:             As of now Sunbird is running a cron job on daily basis, to update some meta data inside course. This scheduler job will do following actions.

&#x20;            \* Select all those batch whose **startDate** <= today date and  **countIncrementStatus** is false.

&#x20;            \* Select all those batch whose **endDate** >= yesterday date  \*\*countDecrementStatus \*\* is false.

&#x20;           \*  Now based on above two query and batch type (open or invite-only) , it will update course meta data as follow.

&#x20;           \*  in case of course going to start now. it will add key as ""c\_" + {"sunbird\_installation"}+ "_open\_batch\_count"  or c_{"sunbird\_installation"}\_private\_batch\_count.  with value as int.

&#x20;           \* in case of batch end , it will decrements count against same key.

| Pros                                                                                                             | Cons |
| ---------------------------------------------------------------------------------------------------------------- | ---- |
| As get course has meta data to indicate open batch count per installation, so no need to make any extra api call |      |

1. This meta data is updated only when course is going to start , it means for upcoming course we can't get it.

\| | | 2.  Data is updated by scheduler job and scheduler job is not 100% guaranteed  | | | 3. Some time due to content attribute changes , it's not able to update the content, so in that case meta data won't be updated.4. TO add meta data for upcoming batch as well , will have more complexity to manage it when upcoming batch changes as ongoing. |

&#x20;&#x20;

&#x20;        Note : So to support solution 1: we need to take following actions:

&#x20;         &#x20;

| Actions |
| ------- |
|         |

1. Need to add meta data for future upcoming batch as well.
2. Need to fix all those content which are failing during update (On Diksha found only 1. do\_31261135182897971215 and on ntp staging and sunbird staging can't find any content,but on sunbird dev found lot more content.)
3. Need to have some fallback  for scheduler job management . so might be instead of once in a day can be run twice in a day.
4. Apart from that during batch creation time itself we can add this meta data.

|

Proposed Solution 2:Sunbird will expose a new api to get open batch count for list for ongoing and upcoming batches.  New api details will be as follows:

&#x20;

```js
URI: /course/v1/search
Methods: POST

Request body:

{
 "request": {
     "filters":{
              "status":["0","1"],     
              "enrollmentType":["open"]
            },
            "offset":0,
            "limit":20,
            "facets":[{"courseId":null}]
       }
}

--- Internal work flow :
  When user call this api , it will do course batch search under ES and all unique courseIds. After getting list of unique courseIds , it will make call to Content search api by passing all those courseIds and Content search response will be provided to caller.

Internal Api call
URI: /content/v1/search
Method: POST
Request body:
{"request":{"filters":{"identifier": ["list of courseId"]},"sort_by":{"createdOn":"desc"}}}



----
Response:
{
    "id": "api.course.search",
    "ver": "v1",
    "ts": "2018-11-20 17:53:00:716+0000",
    "params": {
        "resmsgid": null,
        "msgid": "8e27cbf5-e299-43b0-bca7-8347f7e5abcf",
        "err": null,
        "status": "success",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "response": {
            "count": 8,
            "content": [
                    {
                "ownershipType": [
                    "createdFor"
                ],
                "subject": "Science",
                "channel": "0124511325012951040",
                "downloadUrl": "https://sunbirdstaging.blob.core.windows.net/sunbird-content-staging/ecar_files/do_2126299478299033601672/course-rf-09112018-2_1541742032021_do_2126299478299033601672_1.0_spine.ecar",
                "organisation": [
                    "SunbirdQA 1",
                    "Sunbird QA Tenant"
                ],
                "language": [
                    "English"
                ],
                "mimeType": "application/vnd.ekstep.content-collection",
                "variants": {
                    "spine": {
                        "ecarUrl": "https://sunbirdstaging.blob.core.windows.net/sunbird-content-staging/ecar_files/do_2126299478299033601672/course-rf-09112018-2_1541742032021_do_2126299478299033601672_1.0_spine.ecar",
                        "size": 167578
                    }
                },
                "objectType": "Content",
                "gradeLevel": [
                    "Class 9"
                ],
                "appIcon": "https://sunbirdstaging.blob.core.windows.net/sunbird-content-staging/content/do_2126299478299033601672/artifact/1193-600x337_1524060806727.thumb.jpg",
                "children": [],
                "appId": "staging.sunbird.app",
                "contentEncoding": "gzip",
                "mimeTypesCount": "{\"application/vnd.ekstep.html-archive\":1,\"video/webm\":1,\"application/vnd.ekstep.content-collection\":1,\"video/mp4\":1}",
                "contentType": "Course",
                "identifier": "do_2126299478299033601672",
                "lastUpdatedBy": "bf622d07-ca95-4cc1-9a49-a4518925a4d8",
                "audience": [
                    "Learner"
                ],
                "visibility": "Default",
                "toc_url": "https://sunbirdstaging.blob.core.windows.net/sunbird-content-staging/content/do_2126299478299033601672/artifact/do_2126299478299033601672toc.json",
                "contentTypesCount": "{\"CourseUnit\":1,\"Resource\":3}",
                "consumerId": "dc56def7-ecfd-4001-ab2f-d98251ed40e2",
                "childNodes": [
                    "do_2123236738896609281243",
                    "do_2123717816919900161187",
                    "do_2126299480633671681673",
                    "do_2123717841558814721189"
                ],
                "mediaType": "content",
                "osId": "org.ekstep.quiz.app",
                "graph_id": "domain",
                "nodeType": "DATA_NODE",
                "lastPublishedBy": "9ac4ea92-fea7-45e6-93f3-02aa3172ea58",
                "prevState": "Review",
                "size": 167578,
                "lastPublishedOn": "2018-11-09T05:40:31.997+0000",
                "IL_FUNC_OBJECT_TYPE": "Content",
                "name": "Course RF 09112018 2",
                "status": "Live",
                "code": "org.sunbird.ZwEKh2",
                "description": "Enter description for Course",
                "medium": "Hindi",
                "idealScreenSize": "normal",
                "posterImage": "https://ekstep-public-qa.s3-ap-south-1.amazonaws.com/content/do_21248510612742144014185/artifact/1193-600x337_1524060806727.jpg",
                "createdOn": "2018-11-09T05:34:38.454+0000",
                "contentDisposition": "inline",
                "lastUpdatedOn": "2018-11-09T05:40:31.194+0000",
                "SYS_INTERNAL_LAST_UPDATED_ON": "2018-11-09T08:00:00.413+0000",
                "owner": "Sunbird QA Tenant",
                "creator": "JP Mentor ORg1 user",
                "createdFor": [
                    "012451141730410496558",
                    "0124511325012951040"
                ],
                "IL_SYS_NODE_TYPE": "DATA_NODE",
                "os": [
                    "All"
                ],
                "c_Sunbird_Staging_open_batch_count": 1,
                "pkgVersion": 1,
                "versionKey": "1541742031194",
                "idealScreenDensity": "hdpi",
                "framework": "rj_k-12_1",
                "s3Key": "ecar_files/do_2126299478299033601672/course-rf-09112018-2_1541742032021_do_2126299478299033601672_1.0_spine.ecar",
                "lastSubmittedOn": "2018-11-09T05:39:35.246+0000",
                "createdBy": "bf622d07-ca95-4cc1-9a49-a4518925a4d8",
                "compatibilityLevel": 4,
                "leafNodesCount": 3,
                "IL_UNIQUE_ID": "do_2126299478299033601672",
                "ownedBy": "0124511325012951040",
                "board": "State (Rajasthan)",
                "resourceType": "Course",
                "node_id": 430981
            } ,
            {} 
           ]
        }
    }
}
```

| Pros | Cons |
| ---- | ---- |
|      |      |

1. Easy to manage , later any other changes can be easily incorporated.
2. Only one api call that will handle complete business logic &#x20;
3. Using request body 2 or 3 will provide flexibility to move complete business logic on server side.

|

1. &#x20;new api need to be introduce
2. Some issues with limit and offset. there might be the case one course is used under "N" number of batches , then in another set as well it can come.

\| | | |

\*\* Search open batch based on filter will have issues.Proposed Solution 3:  Sunbird will define new page section to provide open course list under page api.

&#x20;TO achieve this we need to do following modification under page assemble api and get page section .

&#x20;  \* Now section table need to have calling source as well.  which will include (source, indexName, typeName)

&#x20; \* Assemble page business logic will be modified to make call based on source&#x20;

&#x20;\* local source can have multiple search query with query order.

| Pros | Cons |
| ---- | ---- |
|      |      |

1. for consumer only one page assemble api and that will provide complete data

|

1. need to modify existing api , More testing required.
2. &#x20;Due to that requirement table structure need to be modified
3. some data migration alos required with old section.

|

Proposed Solution 4:  User can make another api as batch search api  by passing all courseIds and some extra filters.

&#x20;&#x20;

```js
{"request":{"filters":{ "courseId" : ["do_112634552998936576175","do_112634535631675392173","do_112633845274157056122"],"status":["0","1"],"enrollmentType":"open"},
"sort_by":{"createdDate":"desc"}
}
}
```

| Pros | Cons |
| ---- | ---- |
|      |      |

1. Existing api can be re-used.

|

1. Caller (portal/app) need to make one extra api call and then then need to merge both response
2. Caller need to make one more api call to get my enroll course
3. It can have performance issues .

\| | | |

**Open Questions :**

1. &#x20;If one course have 3  open batches and caller already enrolled for one batch then do we need to sent open batch count as 3 or 2 or for him there is no open batch to do enroll.

***

\[\[category.storage-team]] \[\[category.confluence]]
