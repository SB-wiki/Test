CREATE EVENT =>  /event/v4/createREQUEST:


```
{
    "request": {
        "content": {
            "name": "test event",
            "code": "1234",
            "startDate": "01/03/2021",
            "endDate": "01/03/2021",
            "startTime": "11:00",
            "endTime": "13:00",
            "onlineProvider": "Zoom",
            "registrationEndDate": "25/02/2021",
            "eventType": "Online"
        }
    }
}
```


RESPONSE:


```
{
    "id": "api.event.create",
    "ver": "4.0",
    "ts": "2021-02-22T16:43:10Z+05:30",
    "params": {
        "resmsgid": "ad911e95-f955-42ec-bd9d-53c3000509a3",
        "msgid": null,
        "err": null,
        "status": "successful",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "identifier": "do_11322182566085427211",
        "node_id": "do_11322182566085427211",
        "versionKey": "1613992390626"
    }
}
```


READ EVENT => /event/v4/read/:identifierRESPONSE:


```
{
    "id": "api.content.read",
    "ver": "4.0",
    "ts": "2021-02-22T16:54:38Z+05:30",
    "params": {
        "resmsgid": "403254ab-4553-4028-bd80-0ffa073b1638",
        "msgid": null,
        "err": null,
        "status": "successful",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "content": {
            "trackable": {
                "enabled": "Yes",
                "fixedBatch": "Yes",
                "fixedBatchId": "event_batch_id"
            },
            "identifier": "do_11322182566085427211",
            "lastStatusChangedOn": "2021-02-22T16:43:10.626+0530",
            "audience": [
                "Student"
            ],
            "code": "1234",
            "visibility": "Default",
            "endDate": "01/03/2021",
            "onlineProvider": "Zoom",
            "language": [
                "English"
            ],
            "eventType": "Online",
            "languageCode": [
                "en"
            ],
            "createdOn": "2021-02-22T16:43:10.626+0530",
            "version": 2,
            "objectType": "Event",
            "versionKey": "1613992390626",
            "registrationEndDate": "25/02/2021",
            "leafNodesCount": 1,
            "name": "test event",
            "lastUpdatedOn": "2021-02-22T16:43:10.626+0530",
            "startTime": "11:00",
            "endTime": "13:00",
            "contentType": "Event",
            "startDate": "01/03/2021",
            "status": "Live"
        }
    }
}
```
UPDATE EVENT => /event/v4/update/:identifierREQUEST:


```
{
    "request": {
        "content": {
            "identifier": "do_11322182566085427211",
            "name": "standalone event",
            "code": "123",
            "startDate": "03/03/2021",
            "endDate": "04/03/2021",
            "versionKey": "1613719131567",
            "startTime": "11:00",
            "endTime": "13:00",
            "onlineProvider": "Zoom",
            "registrationEndDate": "25/02/2021",
            "eventType": "Online",
            "status": "Live"
        }
    }
}
```


RESPONSE:


```
{
    "id": "api.content.update",
    "ver": "4.0",
    "ts": "2021-02-22T17:40:49Z+05:30",
    "params": {
        "resmsgid": "200328ff-796a-421b-b35f-b8061085e60d",
        "msgid": null,
        "err": null,
        "status": "successful",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "identifier": "do_11322182566085427211",
        "node_id": "do_11322182566085427211",
        "versionKey": "1613995849274"
    }
}
```


CREATE EVENTSET => /eventset/v4/createREQUEST:


```
{
    "request": {
        "collection": {
            "name": "eventset 4",
            "code": "123",
            "startDate": "01/03/2021",
            "endDate": "02/03/2021",
            "schedule": {
                "type": "NON_RECURRING",
                "value": [
                    {
                        "startDate": "01/03/2021",
                        "endDate": "01/03/2021",
                        "startTime": "11:00",
                        "endTime": "13:00",
                        "name": "event 4: 11-1"
                    },
                    {
                        "startDate": "02/03/2021",
                        "endDate": "02/03/2021",
                        "startTime": "19:00",
                        "endTime": "21:00",
                        "name": "event 4: 19-21"
                    }
                ]
            },
            "onlineProvider": "Zoom",
            "registrationEndDate": "25/02/2021",
            "eventType": "Online"
        }
    }
}
```
RESPONSE:


```
{
    "id": "api.eventSet.create",
    "ver": "4.0",
    "ts": "2021-02-22T17:44:48Z+05:30",
    "params": {
        "resmsgid": "529105bd-c086-4210-9c87-380d74be42c6",
        "msgid": null,
        "err": null,
        "status": "successful",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "identifier": "do_11322185594386022413",
        "node_id": "do_11322185594386022413",
        "versionKey": "1613996088096"
    }
}
```


READ EVENTSET => /eventset/v4/read/:identifierRESPONSE:


```
{
    "id": "api.collection.read",
    "ver": "4.0",
    "ts": "2021-02-22T17:46:33Z+05:30",
    "params": {
        "resmsgid": "6d87a213-f6e8-4984-bcd5-b77c282b5873",
        "msgid": null,
        "err": null,
        "status": "successful",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "content": {
            "trackable": {
                "enabled": "Yes",
                "fixedBatch": "Yes",
                "fixedBatchId": "event_batch_id"
            },
            "identifier": "do_11322182566085427211",
            "lastStatusChangedOn": "2021-02-22T16:43:10.626+0530",
            "audience": [
                "Student"
            ],
            "code": "1234",
            "visibility": "Default",
            "endDate": "01/03/2021",
            "onlineProvider": "Zoom",
            "language": [
                "English"
            ],
            "eventType": "Online",
            "languageCode": [
                "en"
            ],
            "createdOn": "2021-02-22T16:43:10.626+0530",
            "version": 2,
            "objectType": "Event",
            "versionKey": "1613992390626",
            "registrationEndDate": "25/02/2021",
            "leafNodesCount": 1,
            "name": "test event",
            "lastUpdatedOn": "2021-02-22T16:43:10.626+0530",
            "startTime": "11:00",
            "endTime": "13:00",
            "contentType": "Event",
            "startDate": "01/03/2021",
            "status": "Live"
        }
    }
}
```


GET EVENTSET HIERARCHY => /eventset/v4/hierarchy/:identifierRESPONSE:


```
{
    "id": "api.collection.read",
    "ver": "4.0",
    "ts": "2021-02-22T17:47:53Z+05:30",
    "params": {
        "resmsgid": "34ca9d63-5929-4846-9b8f-87a31b06fa6f",
        "msgid": null,
        "err": null,
        "status": "successful",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "content": {
            "trackable": {
                "enabled": "Yes",
                "fixedBatch": "Yes",
                "fixedBatchId": "event_batch_id"
            },
            "identifier": "do_11322185594386022413",
            "lastStatusChangedOn": "2021-02-22T17:44:48.096+0530",
            "audience": [
                "Student"
            ],
            "code": "123",
            "visibility": "Default",
            "endDate": "02/03/2021",
            "childNodes": [
                "do_11322185585855692811",
                "do_11322185594016563212"
            ],
            "onlineProvider": "Zoom",
            "language": [
                "English"
            ],
            "eventType": "Online",
            "languageCode": [
                "en"
            ],
            "createdOn": "2021-02-22T17:44:48.096+0530",
            "version": 2,
            "objectType": "EventSet",
            "versionKey": "1613996088096",
            "schedule": {
                "type": "NON_RECURRING",
                "value": [
                    {
                        "startDate": "01/03/2021",
                        "endDate": "01/03/2021",
                        "startTime": "11:00",
                        "endTime": "13:00",
                        "name": "event 4: 11-1"
                    },
                    {
                        "startDate": "02/03/2021",
                        "endDate": "02/03/2021",
                        "startTime": "19:00",
                        "endTime": "21:00",
                        "name": "event 4: 19-21"
                    }
                ]
            },
            "registrationEndDate": "25/02/2021",
            "children": [
                {
                    "trackable": "{\"enabled\":\"Yes\",\"fixedBatch\":\"Yes\",\"fixedBatchId\":\"event_batch_id\"}",
                    "lastStatusChangedOn": "2021-02-22T17:44:46.446+0530",
                    "audience": [
                        "Student"
                    ],
                    "code": "123",
                    "visibility": "Default",
                    "endDate": "01/03/2021",
                    "onlineProvider": "Zoom",
                    "language": [
                        "English"
                    ],
                    "eventType": "Online",
                    "version": 2,
                    "createdOn": "2021-02-22T17:44:46.446+0530",
                    "versionKey": "1613996086446",
                    "registrationEndDate": "25/02/2021",
                    "leafNodesCount": 1,
                    "name": "event 4: 11-1",
                    "lastUpdatedOn": "2021-02-22T17:44:46.446+0530",
                    "startTime": "11:00",
                    "endTime": "13:00",
                    "startDate": "01/03/2021",
                    "status": "Live"
                },
                {
                    "trackable": "{\"enabled\":\"Yes\",\"fixedBatch\":\"Yes\",\"fixedBatchId\":\"event_batch_id\"}",
                    "lastStatusChangedOn": "2021-02-22T17:44:46.456+0530",
                    "audience": [
                        "Student"
                    ],
                    "code": "123",
                    "visibility": "Default",
                    "endDate": "02/03/2021",
                    "onlineProvider": "Zoom",
                    "language": [
                        "English"
                    ],
                    "eventType": "Online",
                    "version": 2,
                    "createdOn": "2021-02-22T17:44:46.456+0530",
                    "versionKey": "1613996086456",
                    "registrationEndDate": "25/02/2021",
                    "leafNodesCount": 1,
                    "name": "event 4: 19-21",
                    "lastUpdatedOn": "2021-02-22T17:44:46.456+0530",
                    "startTime": "19:00",
                    "endTime": "21:00",
                    "startDate": "02/03/2021",
                    "status": "Live"
                }
            ],
            "name": "eventset 4",
            "lastUpdatedOn": "2021-02-22T17:44:48.096+0530",
            "startDate": "01/03/2021",
            "status": "Live"
        }
    }
}
```


UPDATE EVENTSET => /v1/eventset/updateREQUEST:


```
{
    "request": {
        "objectType": "EventSet",
        "identifier": "do_113221678843125760115",
        "fixedBatchId": "event_batch_id",
        "content": {
            "identifier": "do_113221678843125760115",
            "name": "eventset 4.1 updated",
            "code": "123",
            "startDate": "03/03/2021",
            "endDate": "04/03/2021",
            "versionKey": "1613719131567",
            "schedule": {
                "type": "NON_RECURRING",
                "value": [
                    {
                        "startDate": "04/03/2021",
                        "endDate": "04/03/2021",
                        "startTime": "11:00",
                        "endTime": "13:00",
                        "name": "event 4.11 11am - 1pm"
                    }
                ]
            },
            "onlineProvider": "Zoom",
            "registrationEndDate": "25/02/2021",
            "eventType": "Online",
            "status": "Live"
        },
        "operation": "updateContent"
    }
}
```


ENROLL EVENT => /v1/event/enrollREQUEST:


```
{
    "request" : {
        "courseId": "do_11322182566085427211",
        "userId": "871ac12e-2170-4c6c-a07d-e933c1f64259",
        "fixedBatchId": "event_batch_id"
    }
}
```


UNENROLL EVENT => /v1/event/unenrollREQUEST:


```
{
    "request" : {
        "courseId": "do_11322127469293568015",
        "userId": "871ac12e-2170-4c6c-a07d-e933c1f64259",
        "fixedBatchId": "event_batch_id"
    }
}
```


GET USER ENROLLED EVENTS => /v1/user/event/list/:uidRESPONSE:


```
{
    "id": "api.user.event.list",
    "ver": "v1",
    "ts": "2021-02-22 12:09:53:965+0530",
    "params": {
        "resmsgid": null,
        "msgid": "2f274490-3215-4ee8-b6e4-5f96bb2383d5",
        "err": null,
        "status": "success",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "courses": [
            {
                "dateTime": 1613972575662,
                "lastReadContentStatus": null,
                "enrolledDate": "2021-02-22 11:12:55:662+0530",
                "addedBy": "04b5b73b-c647-44f9-9e16-1fbd1fcc696e",
                "contentId": "do_11322166143296307218",
                "active": true,
                "description": null,
                "courseLogoUrl": null,
                "batchId": "event_batch_id-do_11322166143296307218",
                "userId": "871ac12e-2170-4c6c-a07d-e933c1f64259",
                "content": {},
                "contentStatus": {},
                "completionPercentage": null,      ****** not maintained ******
                "issuedCertificates": [], 
                "courseName": null,
                "certificates": [],
                "completedOn": null,               ****** not maintained ******
                "leafNodesCount": null,
                "progress": 0,                     ****** not maintained ******
                "certstatus": null,
                "lastReadContentId": null,
                "courseId": "do_11322166143296307218",
                "collectionId": "do_11322166143296307218",
                "status": 0                        ****** not maintained ****** 
            },
            {
                "dateTime": 1613974555685,
                "lastReadContentStatus": null,
                "enrolledDate": "2021-02-22 11:45:55:685+0530",
                "addedBy": "bd8a3be7-16a8-498c-bb5c-84190e126382",
                "contentId": "do_113221678822645760114",
                "active": true,
                "description": null,
                "courseLogoUrl": null,
                "batchId": "event_batch_id-do_113221678822645760114",
                "userId": "871ac12e-2170-4c6c-a07d-e933c1f64259",
                "content": {},
                "contentStatus": {},
                "completionPercentage": null,
                "issuedCertificates": [],
                "courseName": null,
                "certificates": [],
                "completedOn": null,
                "leafNodesCount": null,
                "progress": 0,
                "certstatus": null,
                "lastReadContentId": null,
                "courseId": "do_113221678822645760114",
                "collectionId": "do_113221678822645760114",
                "status": 0
            }
        ]
    }
}
```


GET EVENT PARTICIPANTS => /v1/event/participants/listREQUEST:


```
{
    "request" : {
        "courseId": "do_11321992075936563213",
        "fixedBatchId": "event_batch_id"
    }
}
```
RESPONSE:


```
{
    "id": "api.event.participants.list",
    "ver": "v1",
    "ts": "2021-02-22 18:28:54:958+0530",
    "params": {
        "resmsgid": null,
        "msgid": "f475544f-a973-4fb9-ba51-9d2080f8a678",
        "err": null,
        "status": "success",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "participants": {
            "count": 1,
            "participants": [
                "871ac12e-2170-4c6c-a07d-e933c1f64259"
            ]
        }
    }
}
```
ENROLL EVENTSET => /v1/eventset/enrollREQUEST:


```
{
    "request" : {
        "courseId": "do_113221678843125760115",
        "userId": "871ac12e-2170-4c6c-a07d-e933c1f64259",
        "fixedBatchId": "event_batch_id"
    }
}
```


UNENROLL EVENTSET => /v1/eventset/unenrollREQUEST:


```
{
    "request" : {
        "courseId": "do_113221678843125760115",
        "userId": "871ac12e-2170-4c6c-a07d-e933c1f64259",
        "fixedBatchId": "event_batch_id"

    }
}
```


UPDATE USER EVENT PROGRESS => /v1/user/event/state/updateREQUEST:


```
{
    "request": {
        "userId": "871ac12e-2170-4c6c-a07d-e933c1f64259",
        "courseId": "do_113221678821859328113",
        "fixedBatchId": "event_batch_id",
        "status": 2,
        "progress": 1
    }
}
```


READ USER EVENT PROGRESS => /v1/user/event/state/readREQUEST:


```
{
    "request": {
        "userId": "871ac12e-2170-4c6c-a07d-e933c1f64259",
        "courseId": "do_113221678821859328113",
        "fixedBatchId": "event_batch_id"
    }
}
```
RESPONSE:


```
{
    "id": "api.user.event.state.read",
    "ver": "v1",
    "ts": "2021-02-22 14:54:33:832+0530",
    "params": {
        "resmsgid": null,
        "msgid": "8295223b-bf1b-496e-8dba-54103e18becc",
        "err": null,
        "status": "success",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "response": [
            {
                "lastAccessTime": null,
                "contentId": "do_113221678821859328113",
                "progress": 1,
                "viewCount": null,
                "batchId": "event_batch_id-do_113221678821859328113",
                "completedCount": 1,
                "courseId": "do_113221678821859328113",
                "lastCompletedTime": "2021-02-22 14:52:47:767+0530",
                "status": 2
            }
        ]
    }
}
```




*****

[[category.storage-team]] 
[[category.confluence]] 
