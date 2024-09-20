# Credentials-for-everyone

#### \*

```
* [Purpose](#purpose)
* [Solution diagram](#solution-diagram)
* [Certificate Registry](#certificate-registry)
* [Release scope](#release-scope)
* [Certificate-Registry APIs](#certificate-registry-apis)
* [Open questions](#open-questions)
* [Resolved questions](#resolved-questions)
```

Prior art: \[\[Ecreds - Phase3 and SB rollout|Ecreds---Phase3-and-SB-rollout]]

#### Purpose

We want to start issuing credentials for all, including _non_ on-boarded users. These may be individuals such as teachers and students as well as institutions.

#### Solution diagram

![](<../../../../User/Fullexport2/images/storage/eCreds\_solution\_and\_arch-Page-2 - proposed (1).png>)

#### Certificate Registry

The certificate registry is where the certificates are deposited. It is envisioned that this has both on-boarded and external certificates of users and things (like schools). In this view, the following schema is proposed.

schema

```js
"id": "certificate id, text", 
"recipient": {
    "name": "name of the student, teacher or institution", 
    "email": "email of the student, teacher or institution, optional (encrypted)",
	"phone": "phone number of the student, teacher or institution, optional (encrypted)",
    "id": "user or org external identifier in Sunbird, optional. Could also be a URI preferably or UUID",
    "type" : "one of individual, entity"
},
"accessCode": "certificate access code",
"pdfUrl": "complete url of the pdf certificate, text. Example: http://dev.sunbirded.org/public/certs/uuid.pdf",
"jsonUrl": "complete url of the json certificate, text. Example: http://dev.sunbirded.org/public/certs/uuid.json",
"data": {
    "complete raw data json": "of the certificate"
},
"createdBy": "uri of the creator, text",
"updatedBy": "uri of the user doing update, text",
"isRevoked": "defaults to false, indicates whether or not the certificate is valid, boolean",
"reason" : "reason of revoke",
"createdAt": "datetime, system-filled",
"updatedAt": "datetime, system-filled",
"related" : {
    "type": "one of course-completion, course-performance, assessment,offline-course,best-student,best-teacher,best-school",
    "anyKey": "anyValue",
	"key1": "value1"
}

```

Why these in schema _id_ : The id of the certificate, complete URI is different from the registry identifier to that certificate.

_recipient_ : Except name, all other attributes are part of the raw json data. The type helps identify if the cert is awarded to a person or entity. Whether the person is a student, doctor, teacher is hard for us to construct/provide. So, the registry will stick to an individuals. Further details about the capacity of the individual or who is the individual is not a concern of the registry.

_data:_ The entire raw certification json data is preserved here, in case the URLs don't work or unreachable later. Imagine, some company deposits certificate into the registry, but then goes missing. The certificates could be still valid. So, we like to preserve it.

_createdBy, updatedBy_ : certificate-registry doesn't have any&#x20;

_related_ : A raw object where the depositor can store some related values for easy retrieval/search later.&#x20;

Sensitive informationThe name of the recipient (in case of user) is stored in plain text. Phone, email is not used in the certificate raw data. It is only used by the service to communicate certificate link. This information is stored in an encrypted format here in the registry, so as to map (migrate to respective users or orgs) later.&#x20;

#### Release scope

For the GJ experiment, Oct 25, encryption will not happen. This will be taken up in 2.6 or later.

#### Certificate-Registry APIs

/add - Deposit the certificateRequest

```
{
    "request": {
        "recipientId":"user_id",
        "id": "cert_id",
        "recipienType":"entity/Individual" //optional param
        "accessCode": "access_code,
        "jsonData":{
        	"id":"http://localhost:8080/_schemas/Certificate/d5a28280-98ac-4294-a508-21075dc7d475","type":["Assertion","Extension","extensions:CertificateExtension"],"issuedOn":"2019-08-31T12:52:25Z","recipient":{"identity":"ntptest103","type":["phone"],"hashed":false,"name":"Aishwarya","@context":"http://localhost:8080/_schemas/context.json"},"badge":{"id":"http://localhost:8080/_schemas/Badge.json","type":["BadgeClass"],"name":"Sunbird installation","description":"Certificate of Appreciation in National Level ITI Grading","image":"https://certs.example.gov/o/dgt/HJ5327VB1247G","criteria":{"type":["Criteria"],"id":"http://localhost:8080/_schemas/Certificate/d5a28280-98ac-4294-a508-21075dc7d475","narrative":"For exhibiting outstanding performance"},"issuer":{"context":"http://localhost:8080/_schemas/context.json","id":"http://localhost:8080/_schemas/Issuer.json","type":["Issuer"],"name":"NIIT"},"@context":"http://localhost:8080/_schemas/context.json"},"expires":"2019-09-30T12:52:25Z","verification":{"type":["SignedBadge"],"creator":"http://localhost:8080/_schemas/publicKey.json"},"revoked":false,"validFrom":"2019-06-21","@context":"http://localhost:8080/_schemas/context.json"
        	
        },
        "pdfUrl": "https://anc.com",
        "jsonUrl": "string "  //optional param
        "revoked": false/true,   //Optional Param
        "reason":"reason for revoked //optional param "
        "introUrl":"https://introurl.com",
        "completionUrl":"https://completionUrl.com"
    }
}
```

Response

```
{
   "id": api.certreg.add,
    "ver": v1,
    "ts": 2019-10-17 05:33:12:879+0000,
    "params": null,
    "responseCode": "OK",
    "result": {
        "id": "cert_id"
    }
}
```

/validate - Validate the access code and upon success get the details from the registryRequest

```
{
    "request": {
        "certId": "cert_id",
        "accessCode": "access_code"
    }
}
```

Response

```java
{
   "id": api.certreg.validate,
    "ver": v1,
    "ts": 2019-10-17 05:33:12:879+0000,
    "params": null,
    "responseCode": "OK",
    "result": {
        "response": {
            "pdf": "https://anc.com",
            "json": {
                "badge": {
                    "image": "https://certs.example.gov/o/dgt/HJ5327VB1247G",
                    "criteria": {
                        "narrative": "For exhibiting outstanding performance",
                        "id": "http://localhost:8080/_schemas/Certificate/d5a28280-98ac-4294-a508-21075dc7d475",
                        "type": [
                            "Criteria"
                        ]
                    },
                    "name": "Sunbird installation",
                    "description": "Certificate of Appreciation in National Level ITI Grading",
                    "id": "http://localhost:8080/_schemas/Badge.json",
                    "type": [
                        "BadgeClass"
                    ],
                    "@context": "http://localhost:8080/_schemas/context.json",
                    "issuer": {
                        "context": "http://localhost:8080/_schemas/context.json",
                        "name": "NIIT",
                        "id": "http://localhost:8080/_schemas/Issuer.json",
                        "type": [
                            "Issuer"
                        ]
                    }
                },
                "expires": "2019-09-30T12:52:25Z",
                "recipient": {
                    "identity": "ntptest103",
                    "name": "Aishwarya",
                    "hashed": false,
                    "type": [
                        "phone"
                    ],
                    "@context": "http://localhost:8080/_schemas/context.json"
                },
                "id": "http://localhost:8080/_schemas/Certificate/d5a28280-98ac-4294-a508-21075dc7d475",
                "validFrom": "2019-06-21",
                "type": [
                    "Assertion",
                    "Extension",
                    "extensions:CertificateExtension"
                ],
                "revoked": false,
                "@context": "http://localhost:8080/_schemas/context.json",
                "verification": {
                    "creator": "http://localhost:8080/_schemas/publicKey.json",
                    "type": [
                        "SignedBadge"
                    ]
                },
                "issuedOn": "2019-08-31T12:52:25Z"
            },
            "batchId": "batchid123",
            "courseId": "courseId"
        }
    }
}
```

/verify - Verify the certificate JSON2 dataRequest

```js
```

Response

```js
```

/download - Gets a signed URL to the certificate Request

```
{
    "request": {
       "pdfUrl":"/relative path fo pafFile"
    }
}
```

Response

```
{
    "id": api.certreg.download,
    "ver": v1,
    "ts": 2019-10-17 05:33:12:879+0000,
    "responseCode": "OK",
    "params":{
        resmsgid:null
        msgid:e5adfcb9-9165-2641-f45d-b80d27cc140f
            err:null
            status:success
}
    "result": {
        "signedUrl": "https://sunbirddev.blob.core.windows.net/dev-e-credentials/relative%20path%20fo%20rpsdfhd?sv=2017-04-17&se=2019-10-15T09%3A36%3A29Z&sr=b&sp=r&sig=jtdr1muN7PE%2BZEGbpWpnRR0Y%2BoUy0mncB/%2BmIKqSWZI%3D"
    }
}
```

#### Open questions

#### Resolved questions

1. Which service takes in the CSV and how they get converted to registry API? - Program backend will do this using the existing Cassandra database support - likely to use existing tables bulk\_upload, bulk\_upload\_process.

***

\[\[category.storage-team]] \[\[category.confluence]]
