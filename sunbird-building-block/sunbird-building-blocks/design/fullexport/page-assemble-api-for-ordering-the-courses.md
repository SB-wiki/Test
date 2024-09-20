Once LMS is deployed, please follow below steps.

Please note, the below curls are pointing to dev env


1. Run Neo4jElasticSearchSyncTool jenkins job with below settings

    -> command: syncbatch

    -> parameters: --objectType batch-detail-update -> to update all courses

    --objectType batch-detail-update --courseIds <comma separated courseIDs> -> to update a finite set of courseIds


1. Create new section for My state trainings as below




```
curl -L -X POST 'https://dev.sunbirded.org/api/data/v1/page/section/create' \
-H 'Accept: application/json' \
-H 'Content-Type: application/json' \
-H 'x-authenticated-user-token: {{authToken}}' \
-H 'Authorization: Bearer {{api-key}}' \
--data-raw '{
    "request": {
        "name": "My State Trainings",
        "dynamicFilters": "ignore",
        "searchQuery": {
            "request": {
                "filters": {
                    "contentType": [
                        "Course"
                    ],
                    "status": [
                        "Live"
                    ],
                    "objectType": [
                        "Content"
                    ]
                },
                "exists": [
                    "batches.batchId"
                ],
                "sort_by": {
                    "me_averageRating": "desc",
                    "batches.startDate": "desc"
                },
                "limit": 10
            }
        },
        "sectionDataType": "Content"
    },
    "display": {
        "name": {
            "en": "My State Trainings"
        }
    }
}'
```
 3. Create a new section for Featured Trainings as below:


```
curl -L -X POST 'https://dev.sunbirded.org/api/data/v1/page/section/create' \
-H 'Accept: application/json' \
-H 'Content-Type: application/json' \
-H 'x-authenticated-user-token: {{authToken}}' \
-H 'Authorization: Bearer {{api-key}}' \
--data-raw '{
    "request": {
        "name": "Featured Trainings",
        "searchQuery": {
            "request": {
                "filters": {
                    "contentType": [
                        "Course"
                    ],
                    "status": [
                        "Live"
                    ],
                    "objectType": [
                        "Content"
                    ]
                },
                "exists": [
                    "batches.batchId"
                ],
                "sort_by": {
                    "me_averageRating": "desc",
                    "batches.startDate": "desc"
                },
                "limit": 10
            }
        },
        "sectionDataType": "Content"
    },
    "display": {
        "name": {
            "en": "Featured Trainings"
        }
    }
}'
```
 4. Update the Page Info with the Ids generated from the above requests.


```
curl -L -X PATCH 'https://dev.sunbirded.org/api/data/v1/page/update' \
-H 'Accept: application/json' \
-H 'Content-Type: application/json' \
-H 'x-authenticated-user-token: {{authToken}}' \
-H 'Authorization: Bearer {{api-key}}' \
--data-raw '{
 "request":{
        "name":"Course",
        "id":"{{Course PageID}}",
        "portalMap":[
           {
            "id":"{{My State Trainings sectionId}}",
            "index":1,
            "group":1
            
          },
           {
            "id":"{{Featured Trainings Trainings sectionId}}",
             "index":2,
            "group":2
          },
          {
            "id":"{{Latest Courses sectionId}}",
            "index":3,
            "group":3
            
          },
           {
            "id":"{{PopularCourses sectionId}}",
             "index":4,
            "group":4
          }
        ],
        "appMap":[
           {
            "id":"{{My State Trainings sectionId}}",
            "index":1,
            "group":1
            
          },
           {
            "id":"{{Featured Trainings Trainings sectionId}}",
             "index":2,
            "group":2
          },
          {
            "id":"{{Latest Courses sectionId}}",
            "index":3,
            "group":3
            
          },
           {
            "id":"{{PopularCourses sectionId}}",
             "index":4,
            "group":4
          }
        ]
        
      }
   }'
```
Similarly get the pages that needs to updated and update the pages with sections in the specified order.

 5. Use the below request having section filter for the state specific courses section.


```
curl -L -X POST 'https://dev.sunbirded.org/api/data/v1/page/assemble' \
-H 'Content-Type: application/json' \
-H 'X-Consumer-ID: X-Consumer-ID' \
-H 'ts: 2017-05-25 10:18:56:578+0530' \
-H 'X-msgid: 8e27cbf5-e299-43b0-bca7-8347f7e5abcf' \
-H 'X-Device-ID: X-Device-ID' \
-H 'Authorization: Bearer {{api-key}}' \
--data-raw '{
    "request": {
        "source": "web",
        "name": "Course",
        "filters": {
            
        },
        "sections": {
        	"MyStateTrainingID": {
        		"filters": {
        			"batches.createdFor": ["tenant ID"]
        		}
        	}
        	
        }
        
        
    }
}'
```


*****

[[category.storage-team]] 
[[category.confluence]] 
