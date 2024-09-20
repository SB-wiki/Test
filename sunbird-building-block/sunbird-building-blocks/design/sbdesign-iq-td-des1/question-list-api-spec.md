


```
POST  /question/v1/list
```


 **Request Body** 


```json
{
  "request": {
      "search": {
            "identifier": string[]
      }
  }
}
```


 **Response** 

200


```
{
  "id": "api.question.list",
  "ver": "1.0",
  "ts": "2021-02-02T19:28:24ZZ",
  "params": {
    "resmsgid": "8b75d237-1028-4e38-a94a-9ff4ca784d76",
    "msgid": null,
    "err": null,
    "status": "successful",
    "errmsg": null
  },
  "responseCode": "OK",
  "result": {
    "questions": [
      {
        "allowAnonymousAccess": "Yes",
        "identifier": "do_113207924037746688110",
        "lastStatusChangedOn": "2021-02-02T19:50:14.767+0000",
        "code": "question.code",
        "visibility": "Default",
        "showTimer": "No",
        "consumerId": "fa13b438-8a3d-41b1-8278-33b0c50210e4",
        "language": [
          "English"
        ],
        "mimeType": "application/vnd.sunbird.question",
        "languageCode": [
          "en"
        ],
        "createdOn": "2021-02-02T19:50:14.767+0000",
        "version": 1,
        "objectType": "Question",
        "versionKey": "1612295828197",
        "showFeedback": "No",
        "license": "CC BY 4.0",
        "primaryCategory": "Multiple Choice Question",
        "compatibilityLevel": 4,
        "name": "Updated value",
        "contentDisposition": "inline",
        "lastUpdatedOn": "2021-02-02T19:57:08.197+0000",
        "contentEncoding": "gzip",
        "status": "Draft",
        "showSolutions": "No"
      }
    ],
    "count": 1
  }
}
```


400


```
{
  "id": "api.question.list",
  "ver": "1.0",
  "ts": "2020-12-18T09:53:06.734Z",
  "params": {
    "resmsgid": "d4086ce1-4116-11eb-9b0c-abcfbdf41bc3",
    "msgid": null,
    "status": "failed",
    "err": "ERR_REQUEST_FIELDS_IDENTIFIER_MISSING",
    "errmsg": "Required field identifier is missing"
  },
  "responseCode": "CLIENT_ERROR",
  "result": {}
}
```


500




```
{
  "id": "api.question.list",
  "ver": "1.0",
  "ts": "2020-12-18T09:53:06.734Z",
  "params": {
    "resmsgid": "d4086ce1-4116-11eb-9b0c-abcfbdf41bc3",
    "msgid": null,
    "err": "REQUEST_TIMEOUT",
    "status": "failed",
    "errmsg": "Unable to process the request"
  },
  "responseCode": "SERVER_ERROR",
  "result": {}
}
```




 **Assumptions:** 




1. This API always returns a maximum of 20 questions per call


1. Since internally it does parallel calls to get all questions if one question read failed means all others also fail.





*****

[[category.storage-team]] 
[[category.confluence]] 
