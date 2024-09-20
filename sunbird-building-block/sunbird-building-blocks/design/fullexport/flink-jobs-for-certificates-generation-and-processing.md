# Flink-jobs-for-certificates-generation-and-processing

### Overview

This wiki details the design approach on issuing/generating certificates via flink job.

### Design

The current certificate-generator samza job and cert-service(generateCertificate) API is refactored as flink jobs. Below diagram depicts the flow.

![](<../../../../Design/FullExport/images/storage/design (1).png>)

**Changes in cert-processor**

1. Refactoring cert-processor module from java to scala.
2. Using LRU cache implementation to cache cert-templates in-memory.
3. Instead of downloading the cert-templates file, using file inout stream to read the data and store in-memory.

### Events Structure

#### Issue certificate event

```
{
  "actor": {
    "id": "Course Certificate Pre Processor",
    "type": "System"
  },
  "eid": "BE_JOB_REQUEST",
  "edata": {
    "action": "issue-certificate",
    "iteration": 1,
    "batchId": "batchid",
    "userIds": ["List of user ids"],
    "courseID": "courseId",
    "resIssue": true/false
  },
  "ets": 1564144562948,
  "context": {
    "pdata": {
      "ver": "1.0",
      "id": "org.sunbird.platform"
    }
  },
  "mid": "LP.1564144562948.0deae013-378e-4d3b-ac16-237e3fc6149a",
  "object": {
    "id": "batchId_courseId",
    "type": "CourseCertificatePostProcessor"
  }
}
```

#### Generate certificate event

```
{
    "eid": "BE_JOB_REQUEST",
    "ets": 1563788371969,
    "mid": "LMS.1563788371969.590c5fa0-0ce8-46ed-bf6c-681c0a1fdac8",
    "actor":
    {
        "type": "System",
        "id": "Certificate Generator"
    },
    "context":
    {
        "pdata":
        {
            "ver": "1.0",
            "id": "org.sunbird.platform"
        }
    },
    "object":
    {
        "type": "GenerateCertificate",
        "id": "874ed8a5-782e-4f6c-8f36-e0288455901e"
    },
    "edata":
    {
        "templateId": "cert_template_id",
        "svgTemplate": "template-url.svg",
        "courseName": "courseName",
        "issuedDate": "issuing date in yyyy-MM-dd format",
        "data": [
        {
            "recipientName": "userName",
            "recipientId": "userId"
        }],
        "name": "certificate name",
        "tag": "batchId",
        "issuer": // issuer details
        {
            "name": "Gujarat Council of Educational Research and Training",
            "url": "https://gcert.gujarat.gov.in/gcert/"
        },
        "orgId": "ORG_001",
        "signatoryList": [ // signatoy Details
        {
            "name": "CEO Gujarat",
            "id": "CEO",
            "designation": "CEO",
            "image": "https://cdn.pixabay.com/photo/2014/11/09/08/06/signature-523237__340.jpg"
        }],
        "keys": // If  present in root org details
        {
            "id": "5768"
        },
        "criteria":
        {
            "narrative": "course completion certificate"
        },
        "basePath": "https://{{domain_name}}/certs",
        "related": {
            "courseId": "course-id",
            "type": "course-completion",
            "batchId": "batchId"
        },
        "oldId": "old certificate ID" // if re-Issue=true
    }
}
```

### Clarifications:

1. Needs suggestions on naming conventions of collection-complete-post-processor job name and issue.certificate.request topic

***

\[\[category.storage-team]] \[\[category.confluence]]
