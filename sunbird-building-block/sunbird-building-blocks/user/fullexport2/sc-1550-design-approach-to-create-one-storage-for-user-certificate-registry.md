# SC-1550-Design-approach-to-create-one-storage-for-user-certificate-registry

* [Problem statement:](sc-1550-design-approach-to-create-one-storage-for-user-certificate-registry.md#problem-statement:)
* [Solution 1:](sc-1550-design-approach-to-create-one-storage-for-user-certificate-registry.md#solution-1:)
* [Solution](sc-1550-design-approach-to-create-one-storage-for-user-certificate-registry.md#solution)
* [Conclusion](sc-1550-design-approach-to-create-one-storage-for-user-certificate-registry.md#conclusion)

### Problem statement: [SC-1550](https://project-sunbird.atlassian.net/browse/SC-1550)

As of now sunbird-system has two certificate-storages for storing certificates in two different services. Learner-sevice is having cassandra as storage, while certificate-registry service has elasticsearch as storage option while generating certificates

Need to have a unified certificate generating service on the platform.

Following are the request data for adding certificate in the learner and user-registry services, small changes are identified with the request bodies.

Certificate-registry add request:

```js
{
    "request": {
        "recipientType": "individual",
        "pdfUrl": "<string>",
        "recipientName": "user1",
        "related": {
            "type": "course-performance"
        },
        "userId": "621170e2-f09f-47fc-ac74-f2ebe5f536b2",
        "id": "11152",
        "accessCode": "11112",
        "jsonData": {
            "id": "http://localhost:8080/_schemas/Certificate/d5a28280-98ac-4294-a508-21075dc7d475",
            "type": [
                "Assertion",
                "Extension",
                "extensions:CertificateExtension"
            ],
            "issuedOn": "2019-08-31T12:52:25Z",
            "badge": {
                "id": "http://localhost:8080/_schemas/Badge.json",
                "type": [
                    "BadgeClass"
                ],
                "name": "Sunbird installation",
                "description": "Certificate of Appreciation in National Level ITI Grading",
                "image": "https://certs.example.gov/o/dgt/HJ5327VB1247G",
                "criteria": {
                    "type": [
                        "Criteria"
                    ],
                    "id": "http://localhost:8080/_schemas/Certificate/d5a28280-98ac-4294-a508-21075dc7d475",
                    "narrative": "For exhibiting outstanding performance"
                },
                "issuer": {
                    "context": "http://localhost:8080/_schemas/context.json",
                    "id": "http://localhost:8080/_schemas/Issuer.json",
                    "type": [
                        "Issuer"
                    ],
                    "name": "NIIT"
                },
                "@context": "http://localhost:8080/_schemas/context.json"
            },
            "expires": "2019-09-30T12:52:25Z",
            "verification": {
                "type": [
                    "SignedBadge"
                ],
                "creator": "http://localhost:8080/_schemas/publicKey.json"
            },
            "revoked": false,
            "validFrom": "2019-06-21",
            "@context": "http://localhost:8080/_schemas/context.json"
        }
    }
    
}
```

Learner-Service add request:

```js
{
    "request": {
        "userId": "621170e2-f09f-47fc-ac74-f2ebe5f536b2",
        "id": "11152",
        "accessCode": "11112",
        "jsonData": {
            "id": "http://localhost:8080/_schemas/Certificate/d5a28280-98ac-4294-a508-21075dc7d475",
            "type": [
                "Assertion",
                "Extension",
                "extensions:CertificateExtension"
            ],
            "issuedOn": "2019-08-31T12:52:25Z",
            "recipient": {
                "identity": "ntptest103",
                "type": [
                    "phone"
                ],
                "hashed": false,
                "name": "Aishwarya",
                "@context": "http://localhost:8080/_schemas/context.json"
            },
            "badge": {
                "id": "http://localhost:8080/_schemas/Badge.json",
                "type": [
                    "BadgeClass"
                ],
                "name": "Sunbird installation",
                "description": "Certificate of Appreciation in National Level ITI Grading",
                "image": "https://certs.example.gov/o/dgt/HJ5327VB1247G",
                "criteria": {
                    "type": [
                        "Criteria"
                    ],
                    "id": "http://localhost:8080/_schemas/Certificate/d5a28280-98ac-4294-a508-21075dc7d475",
                    "narrative": "For exhibiting outstanding performance"
                },
                "issuer": {
                    "context": "http://localhost:8080/_schemas/context.json",
                    "id": "http://localhost:8080/_schemas/Issuer.json",
                    "type": [
                        "Issuer"
                    ],
                    "name": "NIIT"
                },
                "@context": "http://localhost:8080/_schemas/context.json"
            },
            "expires": "2019-09-30T12:52:25Z",
            "verification": {
                "type": [
                    "SignedBadge"
                ],
                "creator": "http://localhost:8080/_schemas/publicKey.json"
            },
            "revoked": false,
            "validFrom": "2019-06-21",
            "@context": "http://localhost:8080/_schemas/context.json"
        },
        "pdfURL": "https://anc.com",
        "otherLink": "heelo.com"
    }
}
```

few changes are necessary if we need to unify the both requests.

### Solution 1:

If we want learner-service to be apt for certificate storage, as of now it has only cassandra support.

Userid is a mandatory field while adding the certificate, changes should be made in order to convert this into optional field so others users can use this.

Need to add elasticsearch support which helps better in searching the certificate details, as of now we are validating the certificate details from cassandra.

Stackholders for certificate-registry need to point to learner-service endpoints and slight change in the request body is necessary

| Pros | Cons                                                                           |
| ---- | ------------------------------------------------------------------------------ |
|      | Any small changes related to certificates need a deployment of learner-service |
|      | Difficult in perspective of maintainability                                    |

### Solution 2:

Certificate-registry can be used to store all user certificate. Since this micro service was built to certificate storage.&#x20;

Currently this service is using only elasticsearch as primary storage. We might need to think about some other DB (cassandra) as primary storage and ES only for search.

If we want certificate-registry to be apt for certificate storage, we have elasticsearch support which is good in searching, but it may not scale high when we are dealing with large amount of data while adding certificates.

It is better if we make cassandra as primary storage for certificates and use elasticsearch for search option.

It means when ever the request comes first it is added to cassandra then a async call is made to add the certificate details to elasticsearch.

Stackholders for learner-service need to point to certificate-registry endpoints and slight change in the request body is necessary.&#x20;

It is better to use this approach with the support of cassandra and elasticsearch.

changes to request body:

```js
{
    "request": {
        "recipientType": "individual",   
        "pdfUrl": "<string>",
        "recipientName": "user1",
        "createdFor": "",                                          //purpose of creating the certificate like course-performance,course-complete
        "externalId": "621170e2-f09f-47fc-ac74-f2ebe5f536b2",      //unique reference to stackholders data(renaming userid to externalId)
        "id": "11152",                                             //mandatory
        "accessCode": "11112",                                     //mandatory
        "jsonData": {
        },
        "issuedBy": "",                                            //certificate issued by state government/private organisation
        "validUpto": "",                                           //certificate valid upto
        "otherLink": "heelo.com"
    }
}
```

Table details:

Existing certificate table details:

```js
CREATE TABLE sunbird.user_cert (
    id text PRIMARY KEY,
    accesscode text,
    createdat timestamp,
    isdeleted boolean,
    oldid text,
    store map<text, text>,
    updatedat timestamp,
    userid text
)
```

It is better to rename the userid to externalId so that gives generic look, and add few more attributes issuedBy, createdBy, status and validupto.

Add api first saves data to cassandra and the then to elasticsearch

Validate api can use elasticsearch for searching the data.

Data Migration:

* Existing data need to be sync between both from cassandra to elasticsearch and from elasticsearch to cassandra.
* This need to be discussed and update, because upto now we have only system to sync data from cassandra to elastic-search but here it requires vice-versa too

| Pros                                                                                                                                              | Cons                                                                      |
| ------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------- |
| Independent microservice which is developed only related to certificate management                                                                |                                                                           |
| Easy to deploy and maintain                                                                                                                       |                                                                           |
| Others stackholders can easily adopt since there are not many mandatory fields in this service. Only certificate id and access code are mandatory |                                                                           |
| It can scale high when cassandra is added  for adding of certificates.                                                                            | It may perform low when elasticsearch alone used for adding certificates. |

Other Observations:

Using Cassandra :

* We can use cassandra when certificate generation is high in number as it has the following features. Will be useful in certificate bulk-upload cases.
* Apache Cassandra can be considered the best database in terms of large amounts of data.
* In terms of performance, scalability cassandra is best.
* Through gossip protocol cassandra itself can handle failure detection(node down) and data lost failure is not possible.

Using ElasticSearch :

* We can prefer elasticsearch if we have less certificates to add and use search scenario in most of the time in out system, Since it has the below features.
* The advantages of Elasticsearch is that it was based on Apache Lucene which is a data retrieval library completely developed in Java which is a fully featured text-based search engine with high-performance indexing and scalability.
* In terms of searching elasticsearch gives better performance.

Using Cassandra and Elasticsearch with event data driven model :

* Cassandra scales good with huge data, I would like to prefer cassandra as main storage store.
* Then using event driven model, we can push the events for kafka, later the messages can be picked and saved in elasticsearch
* So we can use elasticsearch for search scenario where elasticsearch was really good.

### Conclusion

* Will go with the Solution 2 , As Elasticsearch may not scale high when we are dealing with large amount of data while adding certificates.

Useful Links:

[https://docs.datastax.com/en/cassandra/3.0/cassandra/architecture/archDataDistributeFailDetect.html](https://docs.datastax.com/en/cassandra/3.0/cassandra/architecture/archDataDistributeFailDetect.html)

***

\[\[category.storage-team]] \[\[category.confluence]]
