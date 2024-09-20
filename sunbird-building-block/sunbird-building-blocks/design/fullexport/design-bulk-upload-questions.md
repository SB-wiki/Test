# \[Design]-Bulk-Upload-Questions

**Introduction** This wiki explains the design and implementation of bulk upload of questions.

Jira issue: [https://project-sunbird.atlassian.net/browse/SB-23374](https://project-sunbird.atlassian.net/browse/SB-23374)

### **Problem Statement** :

1. Enable Bulk question creation.
2. Enable Bulk question creation and link them to sections(Units).
3. Enable Bulk question creation with common metadata ex: questionType, channel, createdBy, status, licence and BGMS.

**Solution 1:** Create a generate QuML API for various interaction types such that it takes required parameters as input and generates a QuML output. The API takes input as a **CSV** file and JSON body. This API is responsible for validating and creating questions on the platform.

* The endpoint for  **bulk upload of Question**  is /question/v1/bulkupload
* Mandatory fields cannot be null or empty.
* If the server doesn't support the media type, it should return HTTP status code 415 (Unsupported Media Type).

**HEADER PARAMETERS:**

\| Content-Type (\*required) | stringMedia types can be:-

* Application/json
* Multipart/form-data

\| | X-Channel-ID (\\\*required) | stringIt the Unique Id to identify the root organization to which the user belongs |

REQUEST BODY: multipart/form-data

\| file (\*required) | string This is a .csv file. Each line of the file is a data record, separated by commas Here is the file format link: [https://docs.google.com/spreadsheets/d/1ndzapGGV6q8698x-NQzK\_ufln4YX1HQ09jsFsC7kA60/edit#gid=0](https://docs.google.com/spreadsheets/d/1ndzapGGV6q8698x-NQzK\_ufln4YX1HQ09jsFsC7kA60/edit#gid=0) |

Here is an example of a POST request that includes multipart/form-data:

```
curl --location --request POST '<HOST_URL>/question/v1/bulkupload' \
--header 'Authorization: Bearer <TOKEN>' \
--header 'X-Channel-ID: sunbird' \
--form 'File=@"/qumlTest.csv"'
```

REQUEST BODY: application/JSON:

\| fileUrl (\*required) | String This is a CSV file URL. It should be a publicly accessible file URL. | | Additional Properties (Optional) | createdBy, questionType, author, stage OR status |

Here is an example of a POST request that includes JSON data:

```
curl --location --request POST '<HOST_URL>/question/v1/bulkupload' \
--header 'Authorization: Bearer <TOKEN>' \
--header 'X-Channel-ID: sunbird' \
--header 'Content-Type: application/json' \
--data-raw '{
    "request" : {
        "fileUrl": "https://dockstaging.blob.com/do_123/test.csv",
        "questionType": "MCQ",
        "createdBy": "ae94b68c-a535-4dce-8e7a-fb9662b0ad68",
        "author": "SCERT Haryana",
        "status": "Live"
    }
}'
```

Response Samples: \`\`\`￼\` { "id": "api.v1.bulkupload", "ver": "1.0", "ts": "2021-10-20T09:20:59.943Z", "params": { "resmsgid": "09faf370-3187-11ec-b57e-5ffde477525a", "msgid": "095a6db0-3187-11ec-b57e-5ffde477525a", "status": "successful", "err": null, "errmsg": null }, "responseCode": "OK", "result": { "processId": "112ed159-c805-4df5-9da3-3fcd73122cc2", } }

```




|  **Scenario**  |  **API**  | 
|  --- |  --- | 
| Bulk upload Questions only | 
1. Using CSV file


    1.  API will expect CSV file 



    
1. Using fileUrl publicly accessible fileUrl


    1. API will expect json request.



    

 | 
| Bulk upload Questions and link them to QuestionSet | 
1. Using CSV file


    1.  API will expect CSV file 


    1. CSV should have questionSet identifier



    
1. Using fileUrl publicly accessible fileUrl


    1. API will expect fileUrl in request body. 


    1. questionSet identifier need pass in request body.



    

 | 
| Bulk upload Questions and link them to section under QuestionSet | 
1. Using CSV file


    1.  API will expect CSV file 


    1. CSV should have questionSet identifier & section name



    
1. Using fileUrl publicly accessible fileUrl


    1. API will expect fileUrl in request body. 


    1. questionSet identifier need pass in request body.



    

 | 
| Bulk upload Questions with common metadata | 
1. Using CSV file


    1.  API will expect CSV file 


    1. User need to make sure common metadata in CSV.



    
1. Using fileUrl publicly accessible fileUrl


    1. API will expect fileUrl in request body. 


    1. questionSet identifier need pass in request body.


    1. Pass common metadata in request body.



    

 | 

 **Solution 2:** Create a generate QuML API for various interaction types such that it takes required parameters as input and generates a QuML output. The API takes input as an array of questions. 


* The endpoint for  **bulk upload of Question**  is /question/v1/bulkupload


* Mandatory fields cannot be null or empty.



 **HEADER PARAMETERS:** 

| Content-Type (\*required) | stringThe possible media types can be:-<ul><li>Application/json

</li></ul> | 
| X-Channel-ID (\*required) | stringIt the Unique Id to identify the root organization to which the user belongs | 

REQUEST BODY SCHEMA: application/JSON:

JSON The body is the representation of the resource object for creating questions, which is an array of parameters that describes the question.


```

{ "request": { "question": \[ { "metadata": { "framework": "ekstep\_ncert\_k-12", "channel": "01309282781705830427", "name": "TestQuestion", "code": "9ae33d1e-a682-f30c-04b5-9bda236650ac", "mimeType": "application/vnd.sunbird.question", "primaryCategory": "Multiple Choice Question", }, "collection": \[ { "identifier": "do\_11324642736155033614", "unitId": "do\_11324642761348710417" } ], "stage": "Review" } ] } }

````

### Response Samples:

```￼`
{
    "id": "api.v1.bulkupload",
    "ver": "1.0",
    "ts": "2021-10-20T09:20:59.943Z",
    "params": {
        "resmsgid": "09faf370-3187-11ec-b57e-5ffde477525a",
        "msgid": "095a6db0-3187-11ec-b57e-5ffde477525a",
        "status": "successful",
        "err": null,
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "processId": "112ed159-c805-4df5-9da3-3fcd73122cc2",
    }
}
````

**Conclusion:**

***

\[\[category.storage-team]] \[\[category.confluence]]
