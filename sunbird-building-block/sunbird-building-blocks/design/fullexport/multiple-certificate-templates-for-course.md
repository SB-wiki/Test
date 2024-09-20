# Multiple-Certificate-Templates-for-Course

**Problem Statement :**

#### Course Creator should be able to attach more than one certificate template to a course or course-batch so that users receive different certificates based on the defined filter criteria for each template. The creator should also be able to delete one or more certificate templates from the course. After addition or deletion of certificates, the course creator should also be able to view the list the certificate templates attached to a particular course.

[SB-14845 System JIRA](https://browse/SB-14845)

### Solution Approach :

#### 1. Add Certificate Template&#x20;

&#x20;      API Specification : API should take the course id , batch id (optional), certificate name, filters and the metadata of the certificate template which has to be attached for that particular course. Course creator can add new certificate template to the course by specifying  the filter criteria for issuing the certificate, in the filters field of the API.

2. Delete Certificate Template

&#x20;      API Specification : API should take the course id, batch id(optional) and  name of the certificate which the course creator wants to delete.&#x20;

#### 3. Get Certificate Template

&#x20;      API Specification : API should take the course id and  batch id(optional) and return the list of certificate templates attached to the course.

### Table Structure

Certificate templates would be stored in Cassandra table. Below is the table structure with details of each column

\#fdfdfddashedcertificate\_templatesCREATE TABLE IF NOT EXISTS sunbird\_courses.certificate\_templates (

&#x20; courseid text,  // course id

&#x20; batchid text,   // batch id, empty if template is applicable for all the course batches

&#x20; name text,  // name of the certificate template

&#x20; template text,  // template metadata as a string, contains issuer, signatory and other information

&#x20; filters text,  // filters for the certificate

&#x20; addedby text,  // user id

&#x20; lastupdatedon timestamp, // timestamp of certificate update

&#x20; PRIMARY KEY (courseid, name)

);

**API Design :**

* _Add Certificate Template API_

```js
POST /course/batch/cert/v1/template

Request :      

{
    "params": {
        
    },
    "request": {
        "courseId": "do_12347787978775440",
        "batchId": "2364563546476343",       //optional field
        "name": "100PercentCompletionCertificate",
        "filters": {
            "status": "2",
            "assessmentScore": {
                "<": "0.8"
            }
        },
        "template": {
            "issuer": {
                "name": "Gujarat Council of Educational Research and Training",
                "url": "https://gcert.gujarat.gov.in/gcert/",
                "publicKey": [
                    "7",
                    "8"
                ]
            },
            "signatoryList": [
                {
                    "name": "CEO Gujarat",
                    "id": "CEO",
                    "designation": "CEO",
                    "image": "https://cdn.pixabay.com/photo/2014/11/09/08/06/signature-523237__340.jpg"
                }
            ],
            "keys": {
                "id": "9"
            },
            "htmlTemplate": "https://drive.google.com/uc?authuser=1&id=1ryB71i0Oqn2c3aqf9N6Lwvet-MZKytoM&export=download",
            "notifyTemplate": {
                "subject": "Course completion certificate for Course 03092019 Course",
                "stateImgUrl": "https://sunbirddev.blob.core.windows.net/orgemailtemplate/img/File-0128212938260643843.png",
                "regardsperson": "Chairperson",
                "regards": "Minister of Gujarat",
                "emailTemplateType": "defaultCertTemp"
            }
        }
    }   
}     
```

* _Delete  Certificate Template API_

```
DELETE  /course/batch/cert/v1/template

Request : 
                   {
                     "params": { },
                     "request":{
                             "courseId": "do_12347787978775440",
                             "name": "Merit-Certificate"
                           }
                   }
```

\_             \_

* _Get Certificate List API_

```
POST  /course/batch/cert/v1/template/list
  
Request : 
                   {
                     "params": { },
                     "request":{
                             "courseId": "do_12347787978775440" 
                           }
                   }



```

\_      \_

&#x20;    &#x20;

***

\[\[category.storage-team]] \[\[category.confluence]]
