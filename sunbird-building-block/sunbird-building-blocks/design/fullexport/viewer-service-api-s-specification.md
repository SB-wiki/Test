Introduction:This wiki give the details about Viewer Service API(s) Spec design details.


## Base Request Spec:

*  **Authorization**  and  **x-authenticated-user-token**  are mandatory headers in every request


*  **UserId** will be captured using the user-token from headers for all api requests




```json
{
    "id": "api.view", // required. id of the api request
    "ver": "1.0",  // required. Current version of api 
    "ts": "2021-01-01T00:00:00+05:30", //mandatory. Timestamp of the request
    "params": {
        "msgid": "4f04da60-1e24-4d31-aa7b-1daf91c46341" // unique request message id, UUID
    },
    "request": {                  // required
        ....
        ....                            
    }       
    
```
 **API Spec** 

note **Content View Start** 

 **Content View Start** 

POST - /v1/view/start **Request Spec:** 


```json
{
    "id": "api.view.start",
    "ver": "v1",
    "ts": "2021-06-23 05:37:40:575+0000",
    "params": {
       "msgid": "5e763bc2-b072-440d-916e-da787881b1b9"
    },
    "request": {
        "contentId": "{{contentId}}", // required
        "collectionId" : "{{collectionId}}" // optional
        "contextId": "{{batchId}}" // optional
    }
}
```
 **Sample Requests:** 

Sample1:  consume organic content


```json
{
    "id": "api.view.start",
    "ver": "v1",
    "ts": "2021-06-23 05:37:50:175+0000",
    "params": {
       "msgid": "5e763bc2-b072-440d-916e-da787881b1b9"
    }
    "request": {
      "contentId" : "content_123"
  }
```
Sample2:  consume content through collection


```json
{
    "id": "api.view.start",
    "ver": "v1",
    "ts": "2021-06-23 05:37:40:575+0000",
    "params": {
       "msgid": "5e763bc2-b072-440d-916e-da787881b1b9"
    }
    "request": {
      "contentId" : "content_123"
      "collectionId" : "collection_123"      
    }
```
Sample3:  consume content through context


```json
{
    "id": "api.view.start",
    "ver": "v1",
    "ts": "2021-06-23 05:37:40:575+0000",
    "params": {
       "msgid": "5e763bc2-b072-440d-916e-da787881b1b9"
    }
    "request": {
      "contentId" : "content_123",
      "contextId" : "context_123"   
    }
```
 **Response:** 

200 Ok Response:


```json
{
    "id": "api.view.start",
    "ver": "v1",
    "ts": "2021-06-23 05:37:40:575+0000",
    "params": {
        "resmsgid": null,
        "msgid": "5e763bc2-b072-440d-916e-da787881b1b9",
        "err": null,
        "status": "success",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "{{contentId}}": "Progress started"
    }
}
```
4XX or 5XX Error Response:


```json
{
    "id": "api.view.start",
    "ver": "v1",
    "ts": "2021-06-23 05:37:40:575+0000",
    "params": {
        "resmsgid": null,
        "msgid": "5e763bc2-b072440d-916e-da787881b1b9",
        "err": ERR_Error_Code,
        "status": "failed",
        "errmsg": ERR_error_msg
    },
    "responseCode": "BAD_REQUEST"/"SERVER_ERROR",
    "result": {
      // error message
    }
}
```
 **Sample Response:** Sample1:  Valid Request


```json
{
    "id": "api.view.start",
    "ver": "v1",
    "ts": "2021-06-23 05:37:40:575+0000",
    "params": {
        "resmsgid": null,
        "msgid": "5e763bc2-b072-440d-916e-da787881b1b9",
        "err": null,
        "status": "success",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "content_123": "Progress started"
    }
}
```
Sample2:  InValid Request


```json
{
    "id": "api.view.start",
    "ver": "v1",
    "ts": "2021-06-23 05:37:40:575+0000",
    "params": {
        "resmsgid": null,
        "msgid": "5e763bc2-b072-440d-916e-da787881b1b9",
         "err": "CLIENT_ERROR",
        "status": "FAILED",
        "errmsg": ERR_error_msg
    },
    "responseCode": "BAD_REQUEST",
    "result": {
        "request.contentId": "Content Id cannot be empty"
    }
}
```
Sample3:  Invalid ContextId in Request


```json
{
    "id": "api.view.start",
    "ver": "v1",
    "ts": "2021-06-23 05:37:40:575+0000",
    "params": {
        "resmsgid": null,
        "msgid": "5e763bc2-b072-440d-916e-da787881b1b9",
         "err": "CLIENT_ERROR",
        "status": "FAILED",
        "errmsg": ERR_error_msg
    },
    "responseCode": "BAD_REQUEST",
    "result": {
        "request.contextId": "Invalid Context Id"
    }
}
```


note **Content View Update** 

 **Content View Update** 

POST - /v1/view/update **Request:** 


```json
{
    "id": "api.view.update",
    "ver": "v1",
    "ts": "2021-06-23 05:37:40:575+0000",
    "params": {
       "msgid": "5e763bc2-b072-440d-916e-da787881b1b9"
    }
    "request": {
        "contentId": "{{contentId}}",        // required   
        "collectionId" : "{{collectionId}}", //optional
        "contextId": "{{batchId}}",          // optional
        "progressDetails": {                 // required. Progress details specific 
         ...                                      for each mimetype 
         ...                                              
        },
        "timeSpent" : {{timeSpent}}          // required
    }
}
```
 **Sample Requests:** 

Sample1: Without Context


```json
{
    "id": "api.view.update",
    "ver": "v1",
    "ts": "2021-06-23 05:37:40:575+0000",
    "params": {
       "msgid": "5e763bc2-b072-440d-916e-da787881b1b9"
    }
    "request": {
      "contentId" : "content_123",
      "progressDetails" : {
         "mimetype" : "appliation/pdf",
         "progress" : 20
       }
       "timespent" : 10
}
```
Sample1: With Context


```json
{
    "id": "api.view.update",
    "ver": "v1",
    "ts": "2021-06-23 05:37:40:575+0000",
    "params": {
       "msgid": "5e763bc2-b072-440d-916e-da787881b1b9"
    }
    "request": {
      "contentId" : "content_123",
      "collectionId" : "collection_123",
      "contextId" : "context_123",
      "progressDetails" : {
         "mimetype" : "application/pdf",
         "progress" : 20
       }
      "timespent" : 10
}
```


 **Response:** 


```json
200 OK:
{
    "id": "api.view.update",
    "ver": "v1",
    "ts": "2021-06-23 contents05:37:40:575+0000",
    "params": {
        "resmsgid": null,
        "msgid": "5e763bc2-b072-440d-916e-da787881b1b9",
        "err": null,
        "status": "success",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "{{contentId}}": "Progress Updated"
    }
}

4XX or 5XX Error:
{
    "id": "api.view.update",
    "ver": "v1",
    "ts": "2021-06-23 05:37:40:575+0000",
    "params": {
        "resmsgid": null,
        "msgid": "5e763bc2-b072-440d-916e-da787881b1b9",
        "err": ERR_Error_Code,
        "status": "failed",
        "errmsg": ERR_error_msg
    },
    "responseCode": "BAD_REQUEST"/"SERVER_ERROR",
    "result": {
    }
}
```
note **Content View End** 

 **Content View End** 

POST - /v1/view/end **Request:** 


```json
{
    "id": "api.view.end",
    "ver": "v1",
    "ts": "2021-06-23 05:37:40:575+0000",
    "params": {
       "msgid": "5e763bc2-b072-440d-916e-da787881b1b9"
    }
    "request": {
        "contentId": "{{contentId}}"          //required.
        "collectionId" : "{{collectionId}}",  // required.only when 
                                                   contextId present in request 
        "contextId": "{{batchId}}",           // optional
    }
}
```
 **Sample Request:** 

Sample1: Without Context


```json
{
    "id": "api.view.end",
    "ver": "v1",
    "ts": "2021-06-23 05:37:40:575+0000",
    "params": {
       "msgid": "5e763bc2-b072-440d-916e-da787881b1b9"
    }
    "request": {
      "contentId" : "content_123"
    }
```
Sample2: With Context


```json
{
    "id": "api.view.end",
    "ver": "v1",
    "ts": "2021-06-23 05:37:40:575+0000",
    "params": {
       "msgid": "5e763bc2-b072-440d-916e-da787881b1b9"
    }
    "request": {
      "contentId" : "content_123",
      "collectionId" : "collection_123",
      "contextId" : "context_123"   
    }
```


 **Response:** 


```json
{
    "id": "api.view.end",
    "ver": "v1",
    "ts": "2021-06-23 05:37:40:575+0000",
    "params": {
        "resmsgid": null,
        "msgid": "5e763bc2-b072-440d-916e-da787881b1b9",
        "err": null,
        "status": "success",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "{{contentId}}": "Progress ended"
    }
}

```
note **Content View Read** 

 **Content View Read** 

POST - /v1/view/read **Request:** 


```json
{
    "id": "api.view.read",
    "ver": "v1",
    "ts": "2021-06-23 05:37:40:575+0000",
    "params": {
       "msgid": "5e763bc2-b072-440d-916e-da787881b1b9"
    }
    "request": {
        "contentId": {{contentId}}, //required
        "collectionId" : "{{collectionId}}", //optional 
        "contextId": "{{batchId}}"   // optional
     }
}
```
 **Response:** 


```json
{
    "id": "api.view.read",
    "ver": "v1",
    "ts": "2021-06-23 05:37:40:575+0000",
    "params": {
        "resmsgid": null,
        "msgid": "5e763bc2-b072-440d-916e-da787881b1b9",
        "err": null,
        "status": "success",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
      "userId" : "{{userId}}",
      "contentId" : "{{contentId}}",
      "type" : "content"
      contents:[{
    	"collectionId": "{{collectionId}}",
    	"contextId": "{{batchId}}",  
        "contentId": "{{contentId}}",
        "status" : "{{content_status}}"  
        "progressDetails": "{}"
        }]
    }
}

```
Sample Response:

Sample1: Without context(organic consumption)


```
{
    "id": "api.view.read",
    "ver": "v1",
    "ts": "2021-06-23 05:37:40:575+0000",
    "params": {
        "resmsgid": null,
        "msgid": "5e763bc2-b072-440d-916e-da787881b1b9",
        "err": null,
        "status": "success",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
    	"userId": "user_123"
        "contentId": "content_123",
        "type": "content"
        "contents":[{
           "contentid" : "content_123",
           "collectionid" :"content_123",
           "contenxtid" : "content_123"
           "status" : "1",
           "progressDetails": {
             "mimeType" : "application/video"
              "progress" :20
            }
        }]
    }
}
```
Example2: With context or collection


```json
{
    "id": "api.view.read",
    "ver": "v1",
    "ts": "2021-06-23 05:37:40:575+0000",
    "params": {
        "resmsgid": null,
        "msgid": "5e763bc2-b072-440d-916e-da787881b1b9",
        "err": null,
        "status": "success",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
    	"userId": "user_123"
        "contentId": "content_123",
        "type": "content"
        "contents":[{
           "contentid" : "content_123",
           "collectionid" :"collection_123",
           "contenxtid" : "context_123"
           "status" : "1",
           "progressDetails": {
             "mimeType" : "application/video"
              "progress" :20
            }
        }]
    }
}
```
POST - /v1/view/read?context=all **Request:** 


```json
{
    "id": "api.view.read.contextall",
    "ver": "v1",
    "ts": "2021-06-23 05:37:40:575+0000",
    "params": {
       "msgid": "5e763bc2-b072-440d-916e-da787881b1b9"
    }
    "request": {                      // either of the three options is mandatory
        "contentId": "{{contentId}}" //optional
        "collectionId" : "{{collectionId}}", //optional
        "contextId" : "{{contextId}}" //optional
     }
}
```
 **Response:** 


```json
{
  "id": "api.view.read.contextall",
  "ver": "v1",
  "ts": "2021-06-23 05:37:40:575+0000",
  "params": {
    "resmsgid": null,
    "msgid": "5e763bc2-b072-440d-916e-da787881b1b9",
    "err": null,
    "status": "success",
    "errmsg": null
  },
  "responseCode": "OK",
  "result": {
    ...
    ...                               //requested_data
    "type": "contextall",
    "contents" : [                    // List of all contents irresepcitvie of context
     ]
   }            
}

```
 **Sample Response:** 


```json
{
  "id": "api.view.read.contextall",
  "ver": "v1",
  "ts": "2021-06-23 05:37:40:575+0000",
  "params": {
    "resmsgid": null,
    "msgid": "5e763bc2-b072-440d-916e-da787881b1b9",
    "err": null,
    "status": "success",
    "errmsg": null
  },
  "responseCode": "OK",
  "result": {
  "userId" : "user_123",
  "collectionId" : "collection_123"
  "contents":[
    {
      "userid" :"user_123",
      "contentId": "content_123",
      "status": "1",
      "progressDetails": {
        "progress": 20,
        "timespent": 10
      }
    },
    {
      "userid" : "user_123"
      "collectionId": "collection_!23",
      "contextId": "context_123",
      "contentId": "content_123",
      "progressDetails": {
        "progress": 20,
        "timespent": 10
      },
      "status": "2"
    }
  ]
  }
}
```


note **Content Submit Assess** 

 **Content Submit Assess** 

POST - /v1/assessment/submit **Request:** 


```json
{
    "id": "api.assess.submit",
    "ver": "v1",
    "ts": "2021-06-23 05:37:40:575+0000",
    "params": {
       "msgid": "5e763bc2-b072-440d-916e-da787881b1b9"
    }     
    "request": {
        "contentId": "{{contentId}}",         // required  
        "collectionId" : "{{collectionId}}",  // required
        "contextId": "{{batchId}}",           // required 
        "attemptId" : "{{attemptId}}",        // required
        "assessments": [{
            {{assess_event}}      // required for self-assess contents
        }]
    }
}
```
 **Response:** 


```
{
    "id": "api.view.assess",
    "ver": "v1",
    "ts": "2021-06-23 05:37:40:575+0000",
    "params": {
        "resmsgid": null,
        "msgid": "5e763bc2-b072-440d-916e-da787881b1b9",
        "err": null,
        "status": "success",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "{{contentId}}": "Score Updated"
    }
}

```
note **Content Assesment Read** 

 **Content Assesment Read** 

POST - /v1/assessment/read **Request:** 


```json
{
    "request": {
        "contentId" : "{{contentId}}",    //required
        "collectionId" : "{{collectionId}}", //required
        "contextId": "{{batchId}}"   // required
   }
}
```
 **Response:** 


```json
{
    "id": "api.assessment.read",
    "ver": "v1",
    "ts": "2021-06-23 05:37:40:575+0000",
    "params": {
        "resmsgid": null,
        "msgid": "5e763bc2-b072-440d-916e-da787881b1b9",
        "err": null,
        "status": "success",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
    	"userId": "{{userId}}",
        "contentId" : "{{contentId}}"
    	"collectionId": "{{collectionId}}",
    	"contextId": "{{batchId}}",
        "assessments": [{
          "attemptId" : "{{attemptId}}",
    	  "score": {{score}},
    	  "max_score": {{max_score}}
        },{
          "attemptId" : "{{attemptId}}",
    	  "score": {{score}},
    	  "max_score": {{max_score}}
        }
        ]
    }
}

```
note **Viewer Summary - All enrolments** 

 **Viewer Summary - All enrolments** 

GET - /v1/summary/list/:userId **Response:** 


```json
{
  "id": "api.summary.list",
  "ver": "v1",
  "ts": "2021-06-23 05:59:54:984+0000",
  "params": {
    "resmsgid": null,
    "msgid": "95e4942d-cbe8-477d-aebd-ad8e6de4bfc8",
    "err": null,
    "status": "success",
    "errmsg": null
  },
  "responseCode": "OK",
  "result": {
    "summary": [
      {
        "userId": "{{userId}}",
        "collectionId": "{{collectionId}}",
        "contextId": "{{batchId}}",
        "enrolledDate": 1624275377301,
        "active": true,
        "contentStatus": {
          "{{contentId}}": {{status}}
        },
        "assessmentStatus": {
          "assessmentId": {
            "score": {{best_score}},
            "max_score": {{max_score}}
          }
        },
        "collection": {
          "identifier": "{{collectionId}}",
          "name": "{{collectionName}}",
          "logo": "{{logo Url}}",
          "leafNodesCount": {{leafNodeCount}},
          "description": "{{description}}"
        },
        "issuedCertificates": [{
          "name": "{{certName}}",
          "id": "certificateId",
          "token": "{{certToken}}",
          "lastIssuedOn": "{{lastIssuedOn}}"
        }],
        "completedOn": {{completion_date}},
        "progress": {{progress}},
        "status": {{status}}
      }
    ]
  }
}
```
Sample Response:

Sample1 **:** 


```json
{
  "id": "api.summary.list",
  "ver": "v1",
  "ts": "2021-06-23 05:59:54:984+0000",
  "params": {
    "resmsgid": null,
    "msgid": "95e4942d-cbe8-477d-aebd-ad8e6de4bfc8",
    "err": null,
    "status": "success",
    "errmsg": null
  },
  "responseCode": "OK",
  "result": {
    "summary": [
      {
        "userId": "user_123",
        "collectionId": "collection_123",
        "contextId": "context_123",
        "enrolledDate": 1624275377301,
        "active": true,
        "contentStatus": {
          "content_123": 2,
          "content_456": 1
        },
        "assessmentStatus": {
          "content_123": {
            "score": {{best_score}},
            "max_score": {{max_score}}
          }
        },
        "collection": {
          "identifier": "collection_123",
          "name": "Mathematics",
          "logo": "http://logoimage",
          "leafNodesCount": 4,
          "description": "Dummy Collection"
        },
        "issuedCertificates": [{
          "name": "Certificate-1",
          "id": "cert_123",
          "token": "sdfjkldjk23j2kj2k3jk2",
          "lastIssuedOn": "1624275377301"
        }],
        "completedOn": "2021-09-10",
        "progress": 70,
        "status": 1
      }
    ]
  }
}
```


note **Viewer Summary - Specific enrolment** 

 **Viewer Summary - Specific enrolment** 

POST - /v1/summary/read **Request:** 


```
{
    "request": {
        "userId": "{{userId}}", // required
        "collectionId" : "{{collectionId}}", // required
        "contextId": "{{batchId}}" //required
    }
}
```
 **Response:** 


```json
{
  "id": "api.summary.read",
  "ver": "v1",
  "ts": "2021-06-23 05:59:54:984+0000",
  "params": {
    "resmsgid": null,
    "msgid": "95e4942d-cbe8-477d-aebd-ad8e6de4bfc8",
    "err": null,
    "status": "success",
    "errmsg": null
  },
  "responseCode": "OK",
  "result": {
        "userId": "{{userId}}",
        "collectionId": "{{collectionId}}",
        "contextId": "{{batchId}}",
        "enrolledDate": 1624275377301,
        "active": true,
        "contentStatus": {
          "{{contentId}}": {{status}}
        },
        "assessmentStatus": {
          "assessmentId": {
            "score": {{best_score}},
            "max_score": {{max_score}}
          }
        },
        "collection": {
          "identifier": "{{collectionId}}",
          "name": "{{collectionName}}",
          "logo": "{{logo Url}}",
          "leafNodesCount": {{leafNodeCount}},
          "description": "{{description}}"
        },
        "issuedCertificates": [{
          "name": "{{certName}}",
          "id": "certificateId",
          "token": "{{certToken}}",
          "lastIssuedOn": "{{lastIssuedOn}}"
        }],
        "completedOn": {{completion_date}},
        "progress": {{progress}},
        "status": {{status}}
  }
}

```
note **Viewer Summary Download - Default Format : CSV** 

 **Viewer Summary Download - Default Format : CSV** 

GET - /v1/summary/download/:userId **Response:** 


```
{
    "id": "api.summary.download",
    "ver": "v1",
    "ts": "2021-06-23 05:37:40:575+0000",
    "params": {
        "resmsgid": null,
        "msgid": "5e763bc2-b072-440d-916e-da787881b1b9",
        "err": null,
        "status": "success",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
      "url": "{{userId}}_viewer_summary.csv"
    }
}
```
GET - /v1/summary/download/:userId?format=json **Response:** 


```json
{
    "id": "api.summary.download",
    "ver": "v1",
    "ts": "2021-06-23 05:37:40:575+0000",
    "params": {
        "resmsgid": null,
        "msgid": "5e763bc2-b072-440d-916e-da787881b1b9",
        "err": null,
        "status": "success",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
      "url": "{{userId}}_viewer_summary.json"
    }
}
```
note **Viewer Summary Delete** 

 **Viewer Summary Delete** 

DELETE - /v1/summary/delete/:userId?all - To Delete all enrolments **Response:** 


```json
Response: 
{
    "id": "api.summary.delete",
    "ver": "v1",
    "ts": "2021-06-23 05:37:40:575+0000",
    "params": {
        "resmsgid": null,
        "msgid": "5e763bc2-b072-440d-916e-da787881b1b9",
        "err": null,
        "status": "success",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
     "{{userid}}" : "Enrolment Deleted Succesfully"
    }
}

```
DELETE - /v1/summary/delete/:userId - To Delete specific enrolments **Request:** 


```
{
    "request": {
        "userId": "{{userId}}",   // required
        "collectionId" : "{{collectionId}}",  // required
        "contextId": "{{batchId}}"  // required
    }
}
```
 **Response:** 


```json
Response: 
{
    "id": "api.summary.delete",
    "ver": "v1",
    "ts": "2021-06-23 05:37:40:575+0000",
    "params": {
        "resmsgid": null,
        "msgid": "5e763bc2-b072-440d-916e-da787881b1b9",
        "err": null,
        "status": "success",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
     "{{userid}}" : "Enrolment Deleted Succesfully"
    }
}

```

### Clarifications:

* For assessment submit, do we need consider the assess events without context as well





*****

[[category.storage-team]] 
[[category.confluence]] 
