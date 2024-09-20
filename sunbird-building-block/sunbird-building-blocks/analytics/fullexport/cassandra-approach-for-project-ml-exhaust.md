# Cassandra-Approach-for-Project-ML-Exhaust

The objective of this document is to explain the Project ML Exhaust via Cassandra Approach in the Program Dashboard CSV.

**Jira Ticket:**

[Cassandra Approach for Project ML Exhaust](https://project-sunbird.atlassian.net/browse/LR-472)

**Github Discussion Forum:**

[https://github.com/orgs/Sunbird-Lern/discussions/103](https://github.com/orgs/Sunbird-Lern/discussions/103)

**Outcome :-**

1. Batch Ingestion and Deletion of Druid Datasource can be avoided
2. Druid will not be used for CSV's
3. Huge Data Volume failure of CSV will be avoided

![](<../../../../Analytics/Fullexport/images/storage/Actual Cassandra Arch.drawio (1).drawio (1) (2).png>)

**Schema of the Kafka Topic:**

**Project Kafka Topic Name** : \{{envName\}}.ml.projects.submissions

**Kafka event format:-**

```
{
        _id : ObjectId
        title : {
            type : String,
            index: true
        },
        description : {
            type : String,
            index: true
        },
        taskReport : {
            type : Object,
            default : {}
        },
        metaInformation : {
            type : Object,
            default : {}
        },
        userId : {
            type : String,
            default : "SYSTEM",
            index: true
        },
        userRole : {
            type : String,
            default : "",
            index: true
        },
        status : {
            type : String,
            default : "started",
            index: true
        },
        lastDownloadedAt : Date,
        syncedAt : Date,
        isDeleted : {
            type : Boolean,
            default : false,
            index: true
        },
        categories : {
            type : Array,
            default : []
        },
        createdBy : {
            type : String,
            default : "SYSTEM",
            index: true
        },
        tasks : {
            type : Array,
            default : []
        },
        entityInformation : {
            type : Object,
            default : {}
        },
        programInformation : {
            type : Object,
            default : {}
        },
        solutionInformation : {
            type : Object,
            default : {}
        },
        updatedBy : {
            type : String,
            default : "SYSTEM"
        },
        projectTemplateId : {
            type : "ObjectId",
            index: true
        },
        projectTemplateExternalId : {
            type : String,
            index: true
        },
        startDate: Date,
        endDate: Date,
        learningResources : {
            type : Array,
            default : []
        },
        entityId : {
            type : String,
            index : true
        },
        programId : {
            type : "ObjectId",
            index : true
        },
        programExternalId : {
            type : String,
            index : true
        },
        solutionId : {
            type : "ObjectId",
            index : true
        },
        solutionExternalId : {
            type : String,
            index : true
        },
        isAPrivateProgram : {
            type : Boolean,
            index : true
        },
        appInformation : Object,
        userRoleInformation : Object,
        hasAcceptedTAndC : {
            type : Boolean,
            default : false
        },
        referenceFrom : {
            type : String,
            index : true
        },
        submissions : Object,
        link : {
            type : String,
            index : true
        },
        taskSequence : {
            type : Array,
            default : []
        },
        completedDate: Date,
        recommendedFor : {
            type : Array,
            default : [] 
        },
        attachments : {
            type : Array,
            default : [] 
        },
        remarks : String,
        userProfile : Object,
        certificate : {
            templateId : "ObjectId",
            osid : {
                type : String,
                index : true,
                unique : true
            },
            transactionId : {
                type : String,
                index : true,
                unique : true
            },
            templateUrl : String,
            status : String,
            eligible : Boolean,
            message : String,
            issuedOn : Date,
            criteria : Object,
            reIssuedAt : Date,
            transactionIdCreatedAt : Date,
            originalTransactionInformation :{
                transactionId : String,
                osid : String
            }
            
        }
    }
```

**Sample JSON Data :-**

```
{
  "certificate": {
    "templateUrl": "certificateTemplates/63ca7f67ad848b0008fd1252/ba9aa220-ff1b-4717-b6ea-ace55f04fc16_20-0-2023-1674216820042.svg",
    "status": "active",
    "criteria": {
      "validationText": "Complete validation message",
      "expression": "C1&&C2&&C3",
      "conditions": {
        "C1": {
          "validationText": "Project Should be submitted.",
          "expression": "C1",
          "conditions": {
            "C1": {
              "scope": "project",
              "key": "status",
              "operator": "==",
              "value": "submitted"
            }
          }
        },
        "C2": {
          "validationText": "Evidence project level validation",
          "expression": "C1",
          "conditions": {
            "C1": {
              "scope": "project",
              "key": "attachments",
              "function": "count",
              "filter": {
                "key": "type",
                "value": "all"
              },
              "operator": ">=",
              "value": 2
            }
          }
        },
        "C3": {
          "validationText": "Evidence task level validation",
          "expression": "C1&&C2&&C3",
          "conditions": {
            "C1": {
              "scope": "task",
              "key": "attachments",
              "function": "count",
              "filter": {
                "key": "type",
                "value": "all"
              },
              "operator": ">=",
              "value": 2,
              "taskDetails": [
                "63c90f8a9329b200098da97e"
              ]
            },
            "C2": {
              "scope": "task",
              "key": "attachments",
              "function": "count",
              "filter": {
                "key": "type",
                "value": "all"
              },
              "operator": ">=",
              "value": 3,
              "taskDetails": [
                "63c90f8a9329b200098da981"
              ]
            },
            "C3": {
              "scope": "task",
              "key": "attachments",
              "function": "count",
              "filter": {
                "key": "type",
                "value": "all"
              },
              "operator": ">=",
              "value": 3,
              "taskDetails": [
                "63c90f8a9329b200098da984"
              ]
            }
          }
        }
      }
    },
    "templateId": "63ca7f67ad848b0008fd1252"
  },
  "userId": "df02dcfe-5c2c-4aed-8bf8-858ba76f4185",
  "userRole": "",
  "status": "started",
  "isDeleted": false,
  "categories": [
    {
      "_id": "5fcfa9a2457d6055e33843ef",
      "externalId": "teachers",
      "name": "Teachers"
    },
    {
      "_id": "5fcfa9a2457d6055e33843f3",
      "externalId": "educationLeader",
      "name": "Education Leader"
    }
  ],
  "createdBy": "df02dcfe-5c2c-4aed-8bf8-858ba76f4185",
  "tasks": [
    {
      "_id": "1e18c0bb-e638-4594-99da-56491f7c5467",
      "createdBy": "9bb884fc-8a56-4727-9522-25a7d5b8ea06",
      "updatedBy": "9bb884fc-8a56-4727-9522-25a7d5b8ea06",
      "isDeleted": false,
      "isDeletable": false,
      "taskSequence": [],
      "children": [],
      "visibleIf": [],
      "hasSubTasks": false,
      "learningResources": [
        {
          "name": "गूगल मीट का उपयोग कैसे करें ? | How to use Google meet",
          "link": "https://staging.sunbirded.org/play/content/do_31236183612671590422835?referrer=utm_source%3Dmobile%26utm_campaign%3Dshare_content",
          "app": "Diksha",
          "id": "do_31236183612671590422835?referrer=utm_source%3Dmobile%26utm_campaign%3Dshare_content"
        }
      ],
      "deleted": false,
      "type": "content",
      "projectTemplateId": "63c90f8b9329b200098da989",
      "projectTemplateExternalId": "IMP_project_with_certificate_903_qa_ak3-1674121098043_IMPORTED",
      "name": "School assessment1",
      "externalId": "IMP_project_with_certificate_903_qa_ak3_1-1674121098043-1674121099646",
      "description": "",
      "sequenceNumber": "1",
      "updatedAt": "2023-03-15T09:31:06.719Z",
      "createdAt": "2023-01-19T09:38:18.229Z",
      "__v": 0,
      "status": "notStarted",
      "referenceId": "63c90f8b9329b200098da98c",
      "isImportedFromLibrary": false,
      "syncedAt": "2023-03-15T09:31:06.719Z"
    },
    {
      "_id": "6d560694-8671-4b38-bfaa-d3f4fb72f022",
      "createdBy": "9bb884fc-8a56-4727-9522-25a7d5b8ea06",
      "updatedBy": "9bb884fc-8a56-4727-9522-25a7d5b8ea06",
      "isDeleted": false,
      "isDeletable": false,
      "taskSequence": [],
      "children": [],
      "visibleIf": [],
      "hasSubTasks": false,
      "learningResources": [
        {
          "name": "Molecular Genetics - Practice-1",
          "link": "https://staging.sunbirded.org/play/content/do_31236183612671590422835?referrer=utm_source%3Dmobile%26utm_campaign%3Dshare_content",
          "app": "Diksha",
          "id": "do_31236183612671590422835?referrer=utm_source%3Dmobile%26utm_campaign%3Dshare_content"
        }
      ],
      "deleted": false,
      "type": "content",
      "projectTemplateId": "63c90f8b9329b200098da989",
      "projectTemplateExternalId": "IMP_project_with_certificate_903_qa_ak3-1674121098043_IMPORTED",
      "name": "School assessment2",
      "externalId": "IMP_project_with_certificate_903_qa_ak3_2-1674121098043-1674121099651",
      "description": "",
      "sequenceNumber": "2",
      "updatedAt": "2023-03-15T09:31:06.719Z",
      "createdAt": "2023-01-19T09:38:18.234Z",
      "__v": 0,
      "status": "notStarted",
      "referenceId": "63c90f8b9329b200098da98f",
      "isImportedFromLibrary": false,
      "syncedAt": "2023-03-15T09:31:06.719Z"
    },
    {
      "_id": "67a2438d-4166-4ab2-a13b-1fa6eacbbb5d",
      "createdBy": "9bb884fc-8a56-4727-9522-25a7d5b8ea06",
      "updatedBy": "9bb884fc-8a56-4727-9522-25a7d5b8ea06",
      "isDeleted": false,
      "isDeletable": false,
      "taskSequence": [],
      "children": [],
      "visibleIf": [],
      "hasSubTasks": false,
      "learningResources": [],
      "deleted": false,
      "type": "simple",
      "projectTemplateId": "63c90f8b9329b200098da989",
      "projectTemplateExternalId": "IMP_project_with_certificate_903_qa_ak3-1674121098043_IMPORTED",
      "name": "School assessment3",
      "externalId": "IMP_project_with_certificate_903_qa_ak3_3-1674121098043-1674121099655",
      "description": "",
      "sequenceNumber": "3",
      "updatedAt": "2023-03-15T09:31:06.719Z",
      "createdAt": "2023-01-19T09:38:18.239Z",
      "__v": 0,
      "status": "notStarted",
      "referenceId": "63c90f8b9329b200098da992",
      "isImportedFromLibrary": false,
      "syncedAt": "2023-03-15T09:31:06.719Z"
    }
  ],
  "updatedBy": "df02dcfe-5c2c-4aed-8bf8-858ba76f4185",
  "learningResources": [],
  "hasAcceptedTAndC": false,
  "taskSequence": [
    "IMP_project_with_certificate_903_qa_ak3_1-1674121098043",
    "IMP_project_with_certificate_903_qa_ak3_2-1674121098043",
    "IMP_project_with_certificate_903_qa_ak3_3-1674121098043"
  ],
  "recommendedFor": [
    {
      "roleId": "5f32d8238e0dc831240405a0",
      "code": "HM"
    }
  ],
  "attachments": [],
  "_id": "6411905aac72bc00099421bc",
  "deleted": false,
  "description": "<Edit this and add your project objective here> Mention the challenge you solved through this project",
  "title": "project with certificate ak3 (In both HT & official role and Teacher role)",
  "metaInformation": {
    "rationale": "",
    "primaryAudience": "",
    "goal": "any",
    "duration": "2 months",
    "successIndicators": "",
    "risks": "",
    "approaches": ""
  },
  "updatedAt": "2023-03-15T09:31:06.839Z",
  "createdAt": "2023-01-19T09:38:18.122Z",
  "solutionId": "6411905aad848b0008fd682a",
  "solutionExternalId": "IMP_project_with_certificate_903_qa_ak3-1674121098043-PROJECT-SOLUTION-1678872666723",
  "programId": "6411905aad848b0008fd6827",
  "programExternalId": "Testing _program _5.1.0.0_627880-1678872666723",
  "taskReport": {
    "total": 3,
    "notStarted": 3
  },
  "solutionInformation": {
    "name": "project with certificate ak3 (In both HT & official role and Teacher role)",
    "externalId": "IMP_project_with_certificate_903_qa_ak3-1674121098043-PROJECT-SOLUTION-1678872666723",
    "description": "<Edit this and add your project objective here> Mention the challenge you solved through this project",
    "_id": "6411905aad848b0008fd682a",
    "certificateTemplateId": "63ca7f67ad848b0008fd1252"
  },
  "programInformation": {
    "_id": "6411905aad848b0008fd6827",
    "name": "Testing program 5.1.0.0",
    "externalId": "Testing _program _5.1.0.0_627880-1678872666723",
    "description": "Testing program 5.1.0.0",
    "isAPrivateProgram": true
  },
  "isAPrivateProgram": true,
  "link": "bd5be55fbc7af08538a87bfa650ffdcc",
  "referenceFrom": "link",
  "userProfile": {
    "maskedPhone": null,
    "tcStatus": null,
    "channel": "dikshapreprodcustodian",
    "profileUserTypes": [
      {
        "type": "administrator",
        "subType": "spd"
      }
    ],
    "updatedDate": "2023-03-15 09:28:59:469+0000",
    "managedBy": null,
    "flagsValue": 0,
    "id": "df02dcfe-5c2c-4aed-8bf8-858ba76f4185",
    "recoveryEmail": "",
    "identifier": "df02dcfe-5c2c-4aed-8bf8-858ba76f4185",
    "updatedBy": "df02dcfe-5c2c-4aed-8bf8-858ba76f4185",
    "externalIds": [],
    "roleList": [
      {
        "name": "Book Creator",
        "id": "BOOK_CREATOR"
      },
      {
        "name": "Membership Management",
        "id": "MEMBERSHIP_MANAGEMENT"
      },
      {
        "name": "Flag Reviewer",
        "id": "FLAG_REVIEWER"
      },
      {
        "name": "Report Viewer",
        "id": "REPORT_VIEWER"
      },
      {
        "name": "Program Manager",
        "id": "PROGRAM_MANAGER"
      },
      {
        "name": "Program Designer",
        "id": "PROGRAM_DESIGNER"
      },
      {
        "name": "System Administration",
        "id": "SYSTEM_ADMINISTRATION"
      },
      {
        "name": "Content Curation",
        "id": "CONTENT_CURATION"
      },
      {
        "name": "Book Reviewer",
        "id": "BOOK_REVIEWER"
      },
      {
        "name": "Content Creator",
        "id": "CONTENT_CREATOR"
      },
      {
        "name": "Org Management",
        "id": "ORG_MANAGEMENT"
      },
      {
        "name": "Course Admin",
        "id": "COURSE_ADMIN"
      },
      {
        "name": "Org Moderator",
        "id": "ORG_MODERATOR"
      },
      {
        "name": "Public",
        "id": "PUBLIC"
      },
      {
        "name": "Admin",
        "id": "ADMIN"
      },
      {
        "name": "Course Mentor",
        "id": "COURSE_MENTOR"
      },
      {
        "name": "Content Reviewer",
        "id": "CONTENT_REVIEWER"
      },
      {
        "name": "Report Admin",
        "id": "REPORT_ADMIN"
      },
      {
        "name": "Org Admin",
        "id": "ORG_ADMIN"
      }
    ],
    "rootOrgId": "0126796199493140480",
    "prevUsedEmail": "",
    "firstName": "52 Reg",
    "isMinor": false,
    "tncAcceptedOn": 1677042698710,
    "allTncAccepted": {
      "groupsTnc": {
        "tncAcceptedOn": "2023-03-08 07:28:00:273+0000",
        "version": "3.5.0"
      }
    },
    "profileDetails": null,
    "phone": "",
    "dob": "2000-12-31",
    "status": 1,
    "lastName": "",
    "tncLatestVersion": "v12",
    "roles": [],
    "prevUsedPhone": "",
    "stateValidated": false,
    "isDeleted": false,
    "organisations": [
      {
        "organisationId": "0126796199493140480",
        "approvedBy": null,
        "channel": "dikshapreprodcustodian",
        "updatedDate": null,
        "approvaldate": null,
        "isSystemUpload": false,
        "isDeleted": false,
        "id": "013738338751504384139",
        "isApproved": null,
        "orgjoindate": "2023-02-22 05:11:34:722+0000",
        "isSelfDeclaration": true,
        "updatedBy": null,
        "orgName": "Staging Custodian Organization",
        "addedByName": null,
        "addedBy": null,
        "associationType": 2,
        "locationIds": [
          "027f81d8-0a2c-4fc6-96ac-59fe4cea3abf",
          "8250d58d-f1a2-4397-bfd3-b2e688ba7141"
        ],
        "orgLocation": [
          {
            "type": "state",
            "id": "027f81d8-0a2c-4fc6-96ac-59fe4cea3abf"
          },
          {
            "type": "district",
            "id": "8250d58d-f1a2-4397-bfd3-b2e688ba7141"
          }
        ],
        "externalId": "101010",
        "userId": "df02dcfe-5c2c-4aed-8bf8-858ba76f4185",
        "isSchool": false,
        "hashTagId": "0126796199493140480",
        "isSSO": false,
        "isRejected": null,
        "locations": [
          {
            "code": "29",
            "name": "Karnataka",
            "id": "027f81d8-0a2c-4fc6-96ac-59fe4cea3abf",
            "type": "state",
            "parentId": null
          },
          {
            "code": "2901",
            "name": "BELAGAVI",
            "id": "8250d58d-f1a2-4397-bfd3-b2e688ba7141",
            "type": "district",
            "parentId": "027f81d8-0a2c-4fc6-96ac-59fe4cea3abf"
          }
        ],
        "position": null,
        "orgLeftDate": null
      },
      {
        "organisationId": "01275630040485068839017",
        "approvedBy": null,
        "channel": "apekx",
        "updatedDate": "2023-02-23 14:08:24:885+0000",
        "approvaldate": null,
        "isSystemUpload": false,
        "isDeleted": false,
        "id": "013753327145500672467",
        "isApproved": false,
        "orgjoindate": "2023-03-15 09:28:59:480+0000",
        "isSelfDeclaration": true,
        "updatedBy": "df02dcfe-5c2c-4aed-8bf8-858ba76f4185",
        "orgName": "MPPS GYARAGONDANAHALLI",
        "addedByName": null,
        "addedBy": "df02dcfe-5c2c-4aed-8bf8-858ba76f4185",
        "associationType": 2,
        "locationIds": [
          "bc75cc99-9205-463e-a722-5326857838f8",
          "2f76dcf5-e43b-4f71-a3f2-c8f19e1fce03",
          "966c3be4-c125-467d-aaff-1eb1cd525923"
        ],
        "orgLocation": [
          {
            "type": "state",
            "id": "bc75cc99-9205-463e-a722-5326857838f8"
          },
          {
            "type": "district",
            "id": "2f76dcf5-e43b-4f71-a3f2-c8f19e1fce03"
          },
          {
            "type": "block",
            "id": "966c3be4-c125-467d-aaff-1eb1cd525923"
          }
        ],
        "externalId": "28226200403",
        "userId": "df02dcfe-5c2c-4aed-8bf8-858ba76f4185",
        "isSchool": true,
        "hashTagId": "01275630040485068839017",
        "isSSO": false,
        "isRejected": false,
        "locations": [
          {
            "code": "28",
            "name": "Andhra Pradesh",
            "id": "bc75cc99-9205-463e-a722-5326857838f8",
            "type": "state",
            "parentId": null
          },
          {
            "code": "2822",
            "name": "ANANTAPUR",
            "id": "2f76dcf5-e43b-4f71-a3f2-c8f19e1fce03",
            "type": "district",
            "parentId": "bc75cc99-9205-463e-a722-5326857838f8"
          },
          {
            "code": "282262",
            "name": "AGALI",
            "id": "966c3be4-c125-467d-aaff-1eb1cd525923",
            "type": "block",
            "parentId": "2f76dcf5-e43b-4f71-a3f2-c8f19e1fce03"
          }
        ],
        "position": null,
        "orgLeftDate": "2023-02-23 14:08:24:885+0000"
      }
    ],
    "provider": null,
    "countryCode": null,
    "tncLatestVersionUrl": "https://obj.stage.sunbirded.org/termsandcondtions/terms-and-conditions-v12.html",
    "maskedEmail": "5.****@yopmail.com",
    "email": "5.****@yopmail.com",
    "rootOrg": {
      "organisationSubType": null,
      "channel": "dikshapreprodcustodian",
      "description": "Pre-prod Custodian Organization",
      "updatedDate": "2022-02-18 09:50:42:752+0000",
      "organisationType": 5,
      "isTenant": true,
      "provider": null,
      "id": "0126796199493140480",
      "isBoard": true,
      "email": null,
      "slug": "dikshapreprodcustodian",
      "isSSOEnabled": null,
      "orgName": "Staging Custodian Organization",
      "updatedBy": null,
      "locationIds": [
        "027f81d8-0a2c-4fc6-96ac-59fe4cea3abf",
        "8250d58d-f1a2-4397-bfd3-b2e688ba7141"
      ],
      "externalId": "101010",
      "orgLocation": [
        {
          "type": "state",
          "id": "027f81d8-0a2c-4fc6-96ac-59fe4cea3abf"
        },
        {
          "type": "district",
          "id": "8250d58d-f1a2-4397-bfd3-b2e688ba7141"
        }
      ],
      "isRootOrg": true,
      "rootOrgId": "0126796199493140480",
      "imgUrl": null,
      "homeUrl": null,
      "createdDate": "2019-01-18 09:48:13:428+0000",
      "createdBy": "system",
      "hashTagId": "0126796199493140480",
      "status": 1
    },
    "tcUpdatedDate": null,
    "userLocations": [
      {
        "code": "2822",
        "name": "ANANTAPUR",
        "id": "2f76dcf5-e43b-4f71-a3f2-c8f19e1fce03",
        "type": "district",
        "parentId": "bc75cc99-9205-463e-a722-5326857838f8"
      },
      {
        "code": "282262",
        "name": "AGALI",
        "id": "966c3be4-c125-467d-aaff-1eb1cd525923",
        "type": "block",
        "parentId": "2f76dcf5-e43b-4f71-a3f2-c8f19e1fce03"
      },
      {
        "code": "28",
        "name": "Andhra Pradesh",
        "id": "bc75cc99-9205-463e-a722-5326857838f8",
        "type": "state",
        "parentId": null
      },
      {
        "code": "28226200403",
        "name": "MPPS GYARAGONDANAHALLI",
        "id": "01275630040485068839017",
        "type": "school",
        "parentId": ""
      }
    ],
    "recoveryPhone": "",
    "userName": "5.2reg_ppdv",
    "userId": "df02dcfe-5c2c-4aed-8bf8-858ba76f4185",
    "declarations": [
      {
        "persona": "default",
        "errorType": null,
        "orgId": "013051342708842496208",
        "status": "SUBMITTED",
        "info": {
          "declared-email": "5.2reg@yopmail.com",
          "declared-ext-id": "Staging",
          "declared-phone": "9538910033",
          "declared-school-name": "MPPS GYARAGONDANAHALLI",
          "declared-school-udise-code": "28226200403"
        }
      }
    ],
    "promptTnC": false,
    "lastLoginTime": 0,
    "createdDate": "2023-02-22 05:11:34:702+0000",
    "framework": {
      "board": [
        "CBSE"
      ],
      "gradeLevel": [
        "Class 5"
      ],
      "id": [
        "ekstep_ncert_k-12"
      ],
      "medium": [
        "English"
      ]
    },
    "createdBy": null,
    "profileUserType": {
      "subType": "spd",
      "type": "administrator"
    },
    "tncAcceptedVersion": "v12"
  },
  "lastDownloadedAt": "2023-03-15T09:31:06.831Z",
  "projectTemplateId": "63c90f8b9329b200098da989",
  "projectTemplateExternalId": "IMP_project_with_certificate_903_qa_ak3-1674121098043_IMPORTED",
  "__v": 0
}
```

Only the New requests submitted from the Program Dashboard after the feature is enabled on the production, data extraction will be from cassandra, Old Requested CSV would already be extracted from druid and stored in the cloud storage.

### Flink Job Real-time Streaming :- Logic -

1. Consume the events from the Kafka topic using **Apache Flink** to perform the real-time streaming.
2. Stream Environment to be created to consume kafka event

```
implicit val env: StreamExecutionEnvironment = FlinkUtil.getExecutionContext(config)
val source = kafkaConnector.kafkaEventSource[Event](config.kafkaInputTopic)
```

1.  Post that we would Pre-Process/Transform/Manipulate the data which to assign column names, data types and values prior to storing the data in the Cassandra Table.

    _**Logical Execution**_ :

    1. After the stream environment is created - connect to the Kafka topic mentioned above with the Kafka connector.
    2. Once done, the following key-value pairs needs to be extracted ( _shown with their data-type_ ):

```
submission_id
project_title 
project_title_editable 
program_id 
program_externalId 
program_name 
solution_id 
private_program 
user_id 
user_sub_type 
user_type 
user_locations
organisation_id 
organisation_name 
board_name 
project_status 
project_description 
project_goal 
area_of_improvement 
project_duration 
project_terms_and_condition 
project_created_type 
project_remarks 
project_evidence 
project_evidence_count 
project_created_date 
project_updated_date 
project_completed_date 
project_last_sync 
project_deleted_flag  
certificate_id 
certificate_status 
certificate_issued_on 
certificate_status_customised 
certificate_template_url 
task_id
task_name 
task_status 
task_date 
task_start_date 
task_end_date 
task_evidence 
task_evidence_status 
task_assigned_to 
task_deleted_flag 
task_remarks 
task_count 
task_evidence_count 
task_sequence
sub_task_id
sub_task_name 
sub_task_status 
sub_task_date 
sub_task_start_date 
sub_task_end_date 
sub_task_deleted_flag
```

1. Once the value is extracted for the respective event - we would need to connect to the Cassandra tables and push the data.
2. As Cassandra **INSERT** and **UPDATE** operations are identical. We use the INSERT operation for all Kafka events, new and updated. When we execute an INSERT statement, Cassandra checks if the record already exists and, if so, updates it. If the record doesn't exist, Cassandra inserts it as a new record.
3. Finally, this entire setup needs to be setup as a job to be run in a Kubernetes cluster. Related configurations files will be added that corresponds to this job

_**Exception Handling**_ :

* Exceptions related to Kafka events
* Exceptions related to Cassandra DB

#### ER diagram :-

![](<../../../../Analytics/Fullexport/images/storage/Cassandra Schema ER Diagram.drawio (1).png>)

#### Cassandra DB Schema :-

*

```
CREATE KEYSPACE IF NOT EXISTS sunbird_programs WITH replication = {
    'class': 'SimpleStrategy',
    'replication_factor': '1'
 };
```

Using already existing keyspace, which was created as part of PII Release

* **Projects Table Schema** :-

```
CREATE TABLE IF NOT EXISTS sunbird_programs.project_enrollment (
    submission_id text,
    project_title text,
    project_title_editable text,  
    program_id text,
    program_externalId text,
    program_name text,
    solution_id text,
    private_program boolean,
    user_id text,
    user_sub_type text, 
    user_type text,
    user_locations map<text,text>,
    organisation_id text,
    organisation_name text,
    board_name text,
    project_status text,
    project_description text,
    project_goal text,
    area_of_improvement text,
    project_duration text,
    project_terms_and_condition text,
    project_created_type text,
    project_remarks text,
    project_evidence list<text>,
    project_evidence_count int,
    task_count int,
    project_created_date timestamp,
    project_updated_date date,
    project_completed_date timestamp,
    project_last_sync timestamp,
    project_deleted_flag boolean,
    certificate_id text,
    certificate_status text,
    certificate_issued_on timestamp,
    certificate_status_customised text,
    certificate_template_url text,
    PRIMARY KEY (program_id,solution_id)
) WITH bloom_filter_fp_chance = 0.01
    AND caching = {'keys': 'ALL', 'rows_per_partition': 'NONE'}
    AND comment = ''
    AND compaction = {'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy', 'max_threshold': '32', 'min_threshold': '4'}
    AND compression = {'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND crc_check_chance = 1.0
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99PERCENTILE';
```

* **Projects Task Table Schema** :-

```
CREATE TABLE IF NOT EXISTS sunbird_programs.project_task_enrollment (
    task_id text,
    task_name text,
    task_status text,
    task_date timestamp,
    task_start_date timestamp,
    task_end_date timestamp,
    task_evidence list<text>,
    task_evidence_status text,
    task_assigned_to text,
    task_deleted_flag boolean,
    task_remarks text,
    task_evidence_count int,
    task_sequence int,
    submission_id text,
    program_id text,
    solution_id text,
    PRIMARY KEY ((task_id,submission_id),program_id,solution_id)
) WITH bloom_filter_fp_chance = 0.01
    AND caching = {'keys': 'ALL', 'rows_per_partition': 'NONE'}
    AND comment = ''
    AND compaction = {'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy', 'max_threshold': '32', 'min_threshold': '4'}
    AND compression = {'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND crc_check_chance = 1.0
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99PERCENTILE';
```

* **Projects Sub Task Table Schema** :-

```
CREATE TABLE IF NOT EXISTS sunbird_programs.project_sub_task_enrollment (
    sub_task_id text,
    sub_task_name text,
    sub_task_status text,
    sub_task_date timestamp,
    sub_task_start_date timestamp,
    sub_task_end_date timestamp,
    sub_task_deleted_flag boolean,
    submission_id text,
    task_id text,
    program_id text,
    solution_id text,
    PRIMARY KEY ((sub_task_id,submission_id,task_id),program_id,solution_id)
) WITH bloom_filter_fp_chance = 0.01
    AND caching = {'keys': 'ALL', 'rows_per_partition': 'NONE'}
    AND comment = ''
    AND compaction = {'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy', 'max_threshold': '32', 'min_threshold': '4'}
    AND compression = {'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND crc_check_chance = 1.0
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99PERCENTILE';
```

#### Flow Diagram for Projects Data-product :-

![](<../../../../Analytics/Fullexport/images/storage/Untitled Diagram.drawio.png>)

**Schedular for the Scala Data Product Jobs :** -

[Lern Model config](https://github.com/Sunbird-Lern/data-products/blob/release-5.1.0/ansible/roles/lern-data-products-deploy/templates/lern-model-config.j2)

[Lern Run Job](https://github.com/Sunbird-Lern/data-products/blob/release-5.1.0/ansible/roles/lern-data-products-deploy/templates/lern-run-job.j2)

**Program Dashboard Datasets for Projects :-**

The **Program Dashboard** contains 3 types of CSV’s in which **Task Detail** and **Filtered Task Detail** CSV’sshould follow the data formatting mentioned in [https://docs.google.com/spreadsheets/d/1yE6G6sugfHiTvIWvl4AazShNr4kUNUcxqWQvZBpghsU/edit#gid=0](https://docs.google.com/spreadsheets/d/1yE6G6sugfHiTvIWvl4AazShNr4kUNUcxqWQvZBpghsU/edit#gid=0) sheet with different scenarios. Logic of this [SB-28998 System JIRA](https://browse/SB-28998) ticket should also be considered.

1. **Project Status CSV :-**

*   **Model/Job Config :-**

    Execution of the data product in the server will be done by updating the config in the model-config.j2 file for the project-status-exhaust data product.

**Note** : dataframe\_delete\_columns are deleted once the sorting is done.

```
"project-status-exhaust")
		echo '{
  "search": {
    "type": "none"
  },
  "model": "org.sunbird.ml.exhaust.ProjectExhaustJob",
  "modelParams": {
    "store": "local",
    "mode": "OnDemand",
    "authorizedRoles": [
      "PROGRAM_MANAGER",
      "PROGRAM_DESIGNER"
    ],
    "id": "project-status-exhaust",
    "keyspace_name": "sunbird_programs",
    "table": [
      {
        "name": "project_enrollment",
        "columns": [
          "user_id",
          "program_externalId",
          "program_name",
          "project_title_editable",
          "project_description",
          "project_completed_date",
          "project_created_date",
          "project_last_sync",
          "project_duration",
          "project_status",
          "user_locations",
          "user_type",
          "user_sub_type",
          "organisation_name",
          "board_name",
          "certificate_status_customised",
          "submission_id",
          "private_program",
          "project_deleted_flag"
        ],
        "user_locations_columns": [
          "state_name",
          "district_name",
          "block_name",
          "school_code",
          "school_name"
        ]
      }
    ],
    "data_formatting":false,
    "dataframe_delete_columns":[
      "private_program",
      "project_deleted_flag"
    ],
    "label_mapping": {
      "user_id": "UUID",
      "submission_id": "Project ID",
      "program_externalId": "Program ID",
      "program_name": "Program Name",
      "project_title_editable": "Project Title",
      "project_description": "Project Objective",
      "project_completed_date": "Project completion date of the user",
      "project_created_date": "Project start date of the user",
      "project_last_sync": "Project last Synced date",
      "project_duration": "Project Duration",
      "project Status": "Project Status",
      "state_name": "Declared State",
      "district_name": "District",
      "block_name": "Block",
      "school_code": "School ID",
      "school_name": "School Name",
      "user_type": "User Type",
      "user_sub_type": "User sub type",
      "organisation_name": "Org Name",
      "board_name": "Declared Board",
      "certificate_status_customised": "Certificate Status"
    },
    "order_of_csv_column": [
      "UUID",
      "User Type",
      "User sub type",
      "Declared State",
      "District",
      "Block",
      "School Name",
      "School ID",
      "Declared Board",
      "Org Name",
      "Program Name",
      "Program ID",
      "Project ID",
      "Project Title",
      "Project Objective",
      "Project start date of the user",
      "Project completion date of the user",
      "Project Duration",
      "Project last Synced date",
      "Project Status",
      "Certificate Status"
    ],
    "sort": [
      "UUID",
      "Program ID",
      "Project ID"
    ],
    "quote_column": [
      "Program Name",
      "Project Title",
      "Project Objective",
      "Project Duration"
    ],
    "sparkElasticsearchConnectionHost": "localhost",
    "sparkRedisConnectionHost": "localhost",
    "sparkUserDbRedisIndex": "0",
    "sparkCassandraConnectionHost": "localhost",
    "sparkUserDbRedisPort": 6381,
    "fromDate": "",
    "toDate": "",
    "key": "ml_reports/",
    "format": "csv"
  },
  "output": [
    {
      "to": "file",
      "params": {
        "file": "ml_reports/"
      }
    }
  ],
  "parallelization": 8,
  "appName": "Project Exhaust"
}' 
;;
```

Few Transformation and Manipulation logic need to be handled :-

* Label Mapping
* Column Ordering
* Sorting the data based on the given sort columns
* **Filter Format from UI :-**

```
{
  "name": "Status Report",
  "encrypt": false,
  "datasetId": "project-status-exhaust",
  "roles": [
    "PROGRAM_MANAGER",
    "PROGRAM_DESIGNER"
  ],
  "configurableFilters": true,
  "filters": [
    {
      "table_name": "project_enrollment",
      "table_filters": [
        {
          "primary": [
            {
              "name": "program_id",
              "operator": "=",
              "value": "$programId"
            },
            {
              "name": "solution_id",
              "operator": "=",
              "value": "$solutionId"
            },
            {
              "name": "user_locations['state_id']",
              "operator": "=",
              "value": "$stateId"
            },
            {
              "name": "user_locations['district_id']",
              "operator": "=",
              "value": "$districtId"
            },
            {
              "name": "organisation_id",
              "operator": "=",
              "value": "$orgId"
            },
            {
              "name": "project_updated_date",
              "operator": ">=",
              "value": "YYYY-MM-DD"
            },
            {
              "name": "project_updated_date",
              "operator": "<=",
              "value": "YYYY-MM-DD"
            }
          ],
          "secondary": [
            {
              "name": "project_status",
              "operator": "in",
              "value": "$project_status"
            },
            {
              "name": "private_program",
              "operator": "=",
              "value": "false"
            },
            {
              "name": "project_deleted_flag",
              "operator": "=",
              "value": "false"
            }
          ]
        }
      ]
    }
  ],
  "uiFilters": [
    {
      "label": "Status",
      "controlType": "multi-select",
      "reference": "project_status",
      "placeholder": "Select status",
      "options": [
        "started",
        "submitted",
        "inProgress"
      ]
    }
  ]
}
```

Format :-

[https://docs.google.com/spreadsheets/d/1hQia9npaxMgjV0WADp5p49DB6b2wLtThBF1yPp-5Mvw/edit#gid=1021328825](https://docs.google.com/spreadsheets/d/1hQia9npaxMgjV0WADp5p49DB6b2wLtThBF1yPp-5Mvw/edit#gid=1021328825)

Job id :-project-status-exhaust

**Required CSV Columns** :-

```
UUID
User Type	
User sub type	
Declared State	
District	
Block	
School Name	
School ID	
Declared Board	
Org Name	
Program Name	
Program ID	
Project ID	
Project Title	
Project Objective	
Project start date of the user	
Project completion date of the user	
Project Duration	 
Project last Synced date	
Project Status	
Certificate Status
```

**Data Query :-**

Query **project\_enrollment** Cassandra Table :-

* Construct the Cassandra Query based on the Primary Filters (program\_id, solution\_id, district\_id,organisation\_id,block\_id,updated\_at) present in the request\_data

select user\_id,user\_sub\_type,user\_type,user\_locations,board\_name,organisation\_name,program\_name,program\_externalId,submission\_id,project\_title\_editable,project\_description,project\_created\_date,project\_status,project\_completed\_date,project\_duration,project\_last\_sync,certificate\_status\_customised,private\_program,project\_deleted\_flag from **project\_enrollment** where program\_id='64119acbad848b0008fd6897' and solution\_id='64119b52ad848b0008fd697f'

Store the result into the spark dataframe

* Filters the above dataframe based on the Secondary Filters (project\_status,private\_program,project\_deleted\_flag) present in the request\_data

```
statusSeq = Seq('started','submitted','inProgress')
df = df.filter(col('project_status').isin(statusSeq) && col('private_program')==='false' && col('project_deleted_flag')==='false')
```

2. **Task Detail CSV:-**

Required Manipulation/Transformation of the Projects Data

Logic of this [SB-28998 System JIRA](https://browse/SB-28998) ticket should also be included

*   **Model/Job Config :-**

    Execution of the data product in the server will be done by updating the config in the model-config.j2 file for the project-task-detail-exhaust data product.

    ```
    Note\* dataframe_delete_columns are deleted once the sorting is done.
    ```

```
"project-task-detail-exhaust")
		echo '{
  "search": {
    "type": "none"
  },
  "model": "org.sunbird.ml.exhaust.ProjectExhaustJob",
  "modelParams": {
    "store": "local",
    "mode": "OnDemand",
    "authorizedRoles": [
      "PROGRAM_MANAGER"
    ],
    "id": "project-task-detail-exhaust",
    "keyspace_name": "sunbird_programs",
    "table": [
      {
        "name": "project_enrollment",
        "columns": [
          "user_id",
          "solution_id",
          "program_externalId",
          "program_name",
          "project_title_editable",
          "project_description",
          "project_status",
          "project_completed_date",
          "project_duration",
          "project_evidence",
          "project_created_date",
          "project_remarks",
          "user_locations",
          "board_name",
          "area_of_improvement",
          "user_type",
          "user_sub_type",
          "organisation_name",
          "private_program",
          "project_deleted_flag"
        ],
        "user_locations_columns": [
          "state_name",
          "district_name",
          "block_name",
          "school_code",
          "school_name"
        ]
      },
      {
        "name": "project_task_enrollment",
        "columns": [
          "submission_id",
          "task_id",
          "task_name",
          "task_remarks",
          "task_evidence",
          "task_deleted_flag"
        ]
      },
      {
        "name": "project_sub_task_enrollment",
        "columns": [
          "submission_id",
          "task_id",
          "sub_task_id",
          "sub_task_name",
          "sub_task_deleted_flag"
        ]
      }
    ],
    "data_formatting":true,
    "dataframe_delete_columns": [
      "project_enrollment.private_program",
      "project_enrollment.project_deleted_flag",
      "project_task_enrollment.submission_id",
      "project_task_enrollment.task_id",
      "project_task_enrollment.task_deleted_flag",
      "project_sub_task_enrollment.submission_id",
      "project_sub_task_enrollment.task_id",
      "project_sub_task_enrollment.sub_task_id",
      "project_sub_task_enrollment.sub_task_deleted_flag"
    ],
    "label_mapping": {
      "user_id": "UUID",
      "solution_id": "Project ID",
      "program_externalId": "Program ID",
      "program_name": "Program Name",
      "project_title_editable": "Project Title",
      "project_description": "Project Objective",
      "project_status": "Project Status",
      "project_duration": "Project Duration",
      "project_created_date": "Project start date of the user",
      "project_completed_date": "Project completion date of the user",
      "state_name": "Declared State",
      "district_name": "District",
      "block_name": "Block",
      "school_code": "School ID",
      "school_name": "School Name",
      "board_name": "Declared Board",
      "user_type": "User Type",
      "user_sub_type": "User sub type",
      "organisation_name": "Org Name",
      "area_of_improvement": "Category",
      "project_evidence": "Project Evidence",
      "project_remarks": "Project Remarks",
      "task_name": "Tasks",
      "task_evidence": "Task Evidence",
      "task_remarks": "Task Remarks",
      "sub_task": "Sub-Tasks"
    },
    "order_of_csv_column": [
      "UUID",
      "User Type",
      "User sub type",
      "Declared State",
      "District",
      "Block",
      "School Name",
      "School ID",
      "Declared Board",
      "Org Name",
      "Program Name",
      "Program ID",
      "Project ID",
      "Project Title",
      "Project Objective",
      "Category",
      "Project start date of the user",
      "Project completion date of the user",
      "Project Duration",
      "Project Status",
      "Tasks",
      "Sub-Tasks",
      "Task Evidence",
      "Task Remarks",
      "Project Evidence",
      "Project Remarks"
    ],
    "sort": [
      "UUID",
      "Program ID",
      "Project ID",
      "Tasks"
    ],
    "quote_column": [
      "Program Name",
      "Project Title",
      "Project Objective",
      "Category",
      "Project Duration",
      "Tasks",
      "Sub-Tasks",
      "Task Remarks",
      "Project Remarks"
    ],
    "sparkElasticsearchConnectionHost": "localhost",
    "sparkRedisConnectionHost": "localhost",
    "sparkUserDbRedisIndex": "0",
    "sparkCassandraConnectionHost": "localhost",
    "sparkUserDbRedisPort": 6381,
    "fromDate": "",
    "toDate": "",
    "key": "ml_reports/",
    "format": "csv"
  },
  "output": [
    {
      "to": "file",
      "params": {
        "file": "ml_reports/"
      }
    }
  ],
  "parallelization": 8,
  "appName": "Project Exhaust"
}' 
;;
```

Few Transformation and Manipulation logic need to be handled :-

* Label Mapping
* Column Ordering
* Sorting the data based on the given sort columns
* **Filter Format from UI :-**

```
{
  "name": "Status Report",
  "encrypt": false,
  "datasetId": "project-task-detail-exhaust",
  "roles": [
    "PROGRAM_MANAGER"
  ],
  "configurableFilters": true,
  "filters": [
    {
      "table_name": "project_enrollment",
      "table_filters": [
        {
          "primary": [
            {
              "name": "program_id",
              "operator": "=",
              "value": "$programId"
            },
            {
              "name": "solution_id",
              "operator": "=",
              "value": "$solutionId"
            },
            {
              "name": "user_locations['district_id']",
              "operator": "=",
              "value": "$districtId"
            },
            {
              "name": "organisation_id",
              "operator": "=",
              "value": "$organisation_id"
            },
            {
              "name": "user_locations['block_id']",
              "operator": "=",
              "value": "$blockId"
            },
            {
              "name": "project_updated_date",
              "operator": ">=",
              "value": "YYYY-MM-DD"
            },
            {
              "name": "project_updated_date",
              "operator": "<=",
              "value": "YYYY-MM-DD"
            },
            {
              "name": "project_status",
              "operator": "=",
              "value": "submitted"
            }
          ],
          "secondary": [
            {
              "name": "private_program",
              "operator": "=",
              "value": "false"
            },
            {
              "name": "project_deleted_flag",
              "operator": "=",
              "value": "false"
            }
          ]
        }
      ]
    },
    {
      "table_name": "project_task_enrollment",
      "table_filters": [
        {
          "primary": [
            {
              "name": "program_id",
              "operator": "=",
              "value": "$program_id"
            },
            {
              "name": "solution_id",
              "operator": "=",
              "value": "$solutionId"
            }
          ],
          "secondary": [
            {
              "name": "task_deleted_flag",
              "operator": "=",
              "value": "false"
            }
          ]
        }
      ]     
    },
    {
      "table_name": "project_sub_task_enrollment",
      "table_filters": [
        {
          "primary": [
            {
              "name": "program_id",
              "operator": "=",
              "value": "$program_id"
            },
            {
              "name": "solution_id",
              "operator": "=",
              "value": "$solutionId"
            }
          ],
          "secondary": [
            {
              "name": "sub_task_deleted_flag",
              "operator": "=",
              "value": "false"
            }
          ]
        }
      ]     
    }
  ],
  "uiFilters": [
    {
      "label": "Status",
      "controlType": "multi-select",
      "reference": "project_status",
      "placeholder": "Select status",
      "options": [
        "started",
        "submitted",
        "inProgress"
      ]
    }
  ]
}
```

Format :-

[https://docs.google.com/spreadsheets/d/1dPB1BcGCql-GggmAxiytD489kcOzQPObWkGnaqlD0-4/edit#gid=314454479](https://docs.google.com/spreadsheets/d/1dPB1BcGCql-GggmAxiytD489kcOzQPObWkGnaqlD0-4/edit#gid=314454479)

Job id :- project-task-detail-exhaust

**Required CSV Columns** :-

```
UUID	
User Type
User sub type
Declared State	
District	
Block	
School Name	
School ID	
Declared Board	
Org Name	
Program Name	
Program ID	
Project ID	
Project Title	
Project Objective	
Category	
Project start date of the user	
Project completion date of the user
Project Duration
Project Status	
Tasks	
Sub-Tasks
Task Evidence
Task Remarks	
Project Evidence	
Project Remarks
```

**Data Query :-**

1. Query **project\_enrollment** Cassandra Table :-

* Construct the Cassandra Query based on the Primary Filters (program\_id, solution\_id, district\_id,organisation\_id,block\_id,updated\_at,project\_status) present in the request\_data

select user\_id,user\_sub\_type,user\_type,user\_locations,board\_name,organisation\_name,program\_name,program\_externalId,submission\_id,project\_title\_editable,project\_description,project\_status,area\_of\_improvement,project\_created\_date,project\_completed\_date,project\_duration,private\_program,project\_deleted\_flag from **project\_enrollment** where program\_id='64119acbad848b0008fd6897' and solution\_id='64119b52ad848b0008fd697f'

Store the result into the spark dataframe

* Filters the above dataframe based on the Secondary Filters (private\_program,project\_deleted\_flag) present in the request\_data

```
df = df.filter(col('private_program')==='false' && col('project_deleted_flag')==='false')
```

2. Query **project\_task\_enrollment** Cassandra Table :-

* Construct the Cassandra Query based on the Primary Filters (program\_id, solution\_id) present in the request\_data

select submission\_id,task\_id,task\_name,task\_evidence,task\_remarks,task\_deleted\_flag from **project\_task\_enrollment** where program\_id='64119acbad848b0008fd6897' and solution\_id='64119b52ad848b0008fd697f'

Store the result into the spark dataframe

* Filters the above dataframe based on the Secondary Filters (task\_deleted\_flag) present in the request\_data

```
df = df.filter(col('task_deleted_flag')==='false')
```

3. Query **project\_sub\_task\_enrollment** Cassandra Table :-

* Construct the Cassandra Query based on the Primary Filters (program\_id, solution\_id) present in the request\_data

select submission\_id,task\_id,sub\_task\_id,sub\_task\_name,sub\_task\_deleted\_flag from **project\_sub\_task\_enrollment** where program\_id='64119acbad848b0008fd6897' and solution\_id='64119b52ad848b0008fd697f'

Store the result into the spark dataframe

* Filters the above dataframe based on the Secondary Filters (sub\_task\_deleted\_flag) present in the request\_data

```
df = df.filter(col('sub_task_deleted_flag')==='false')
```

3. **Filtered Task Detail CSV:-**

*   **Model/Job Config :-**

    Execution of the data product in the server will be done by updating the config in the model-config.j2 file for the project-filtered-task-detail-exhaust data product.

**Note:-** dataframe\_delete\_columns are deleted once the sorting is done.

```
"project-filtered-task-detail-exhaust")
		echo '{
  "search": {
    "type": "none"
  },
  "model": "org.sunbird.ml.exhaust.ProjectExhaustJob",
  "modelParams": {
    "store": "local",
    "mode": "OnDemand",
    "authorizedRoles": [
      "PROGRAM_MANAGER"
    ],
    "id": "project-filtered-task-detail-exhaust",
    "keyspace_name": "sunbird_programs",
    "table": [
      {
        "name": "project_enrollment",
        "columns": [
          "user_id",
          "program_name",
          "project_title_editable",
          "project_description",
          "project_status",
          "project_completed_date",
		  "user_locations",
          "user_type",
          "user_sub_type",
          "organisation_name",
          "project_evidence",
          "project_remarks",
          "private_program",
          "project_deleted_flag"
        ],
        "user_locations_columns": [
          "state_name",
          "district_name",
          "block_name"
        ]
      },
      {
        "name": "project_task_enrollment",
        "columns": [
          "submission_id",
          "task_id",
          "task_name",
          "task_evidence",
          "task_remarks",
          "task_deleted_flag",
          "task_sequence"
        ]
      } 
    ],
    "data_formatting":true,
    "dataframe_delete_columns":[
      "project_enrollment.private_program",
      "project_enrollment.project_deleted_flag",
      "project_task_enrollment.submission_id",
      "project_task_enrollment.task_id",
      "project_task_enrollment.task_deleted_flag",
      "project_task_enrollment.task_sequence"
    ],
    "label_mapping": {
      "user_id": "UUID",
      "program_name": "Program Name",
      "project_title_editable": "Project Title",
      "project_description": "Project Objective",
      "project_status": "Project_status",
      "project_completed_date": "Project completion date of the user",
      "state_name": "Declared State",
      "district_name": "District",
      "block_name": "Block",
      "user_type": "User Type",
      "user_sub_type": "User sub type",
      "organisation_name": "Org Name",
      "task_name": "Tasks",
      "task_evidence": "Task Evidence",
      "task_remarks": "Task Remarks",
      "project_evidence": "Project Evidence",
      "project_remarks": "Project Remarks"
    },
    "order_of_csv_column": [
      "UUID",
 	  "User Type",
      "User sub type",
      "Declared State",
      "District",	
      "Block",	
      "Org Name",	
      "Program Name",
      "Project Title",	
      "Project Objective",	
      "Project Status",	
      "Project Completion Date of the user",
      "Tasks",
      "Task Evidence",
      "Task Remarks",	
      "Project Evidence",	
      "Project Remarks"
    ],
    "sort": [
      "District",
      "Block",
      "UUID",
      "task_sequence"
    ],
    "quote_column": [
      "Program Name",
      "Project Title",
      "Project Objective",
      "Tasks",
      "Task Remarks",
      "Project Remarks"
    ],
    "sparkElasticsearchConnectionHost": "localhost",
    "sparkRedisConnectionHost": "localhost",
    "sparkUserDbRedisIndex": "0",
    "sparkCassandraConnectionHost": "localhost",
    "sparkUserDbRedisPort": 6381,
    "fromDate": "",
    "toDate": "",
    "key": "ml_reports/",
    "format": "csv"
  },
  "output": [
    {
      "to": "file",
      "params": {
        "file": "ml_reports/"
      }
    }
  ],
  "parallelization": 8,
  "appName": "Project Exhaust"
}' 
;;
```

Few Transformation and Manipulation logic need to be handled :-

* Label Mapping
* Column Ordering
* Sorting the data based on the given sort columns
* **Filter Format from UI :-**

```
{
  "name": "Status Report",
  "encrypt": false,
  "datasetId": "project-filtered-task-detail-exhaust",
  "roles": [
    "PROGRAM_MANAGER"
  ],
  "configurableFilters": true,
  "filters": [
    {
      "table_name": "project_enrollment",
      "table_filters": [
        {
          "primary": [
            {
              "name": "program_id",
              "operator": "=",
              "value": "$programId"
            },
            {
              "name": "solution_id",
              "operator": "=",
              "value": "$solutionId"
            },
            {
              "name": "user_locations['district_id']",
              "operator": "=",
              "value": "$districtId"
            },
            {
              "name": "organisation_id",
              "operator": "=",
              "value": "$organisation_id"
            },
            {
              "name": "user_locations['block_id']",
              "operator": "=",
              "value": "$blockId"
            },
            {
              "name": "project_updated_date",
              "operator": ">=",
              "value": "YYYY-MM-DD"
            },
            {
              "name": "project_updated_date",
              "operator": "<=",
              "value": "YYYY-MM-DD"
            },
            {
              "name": "project_status",
              "operator": "=",
              "value": "submitted"
            }
          ],
          "secondary": [
            {
              "name": "private_program",
              "operator": "=",
              "value": "false"
            },
            {
              "name": "project_deleted_flag",
              "operator": "=",
              "value": "false"
            },
            {
              "name": "project_evidence_count",
              "operator": ">",
              "value": "$project_evidence_count"
            },
            {
              "name": "task_count",
              "operator": ">",
              "value": "$task_count"
            }
          ]
        }
      ]
    },
    {
      "table_name": "project_task_enrollment",
      "table_filters": [
        {
          "primary": [
            {
              "name": "program_id",
              "operator": "=",
              "value": "$program_id"
            },
            {
              "name": "solution_id",
              "operator": "=",
              "value": "$solution_id"
            }
          ],
          "secondary": [
            {
              "name": "task_deleted_flag",
              "operator": "=",
              "value": "false"
            },
            {
              "name": "task_evidence_count",
              "operator": ">",
              "value": "$task_evidence_count"
            }
          ]
        }
      ]     
    }        
  ],
  "uiFilters": [
    {
      "label": "Status",
      "controlType": "multi-select",
      "reference": "project_status",
      "placeholder": "Select status",
      "options": [
        "started",
        "submitted",
        "inProgress"
      ]
    }
  ]
}
```

Format :-

[https://docs.google.com/spreadsheets/d/1dPB1BcGCql-GggmAxiytD489kcOzQPObWkGnaqlD0-4/edit#gid=314454479](https://docs.google.com/spreadsheets/d/1dPB1BcGCql-GggmAxiytD489kcOzQPObWkGnaqlD0-4/edit#gid=314454479)

Job id :- project-filtered-task-detail-exhaust

**Required CSV Columns** :-

```
UUID	
User Type
User sub type
Declared State	
District	
Block	
Org Name	
Program Name
Project Title	
Project Objective	
Project Status	
Project Completion Date of the user
Tasks
Task Evidence
Task Remarks	
Project Evidence	
Project Remarks
```

**Data Query :-**

1. Query **project\_enrollment** Cassandra Table :-

* Construct the Cassandra Query based on the Primary Filters (program\_id, solution\_id, district\_id,organisation\_id,block\_id,updated\_at,project\_status) present in the request\_data

select user\_id,user\_sub\_type,user\_type,user\_locations,board\_name,organisation\_name,program\_name,project\_title\_editable,project\_description,project\_status,project\_completed\_date,private\_program,project\_deleted\_flag from **project\_enrollment** where program\_id='64119acbad848b0008fd6897' and solution\_id='64119b52ad848b0008fd697f'

Store the result into the spark dataframe

* Filters the above dataframe based on the Secondary Filters (private\_program,project\_deleted\_flag,project\_evidence\_count,task\_count) present in the request\_data

```
df = df.filter(col('private_program')==='false' && col('project_deleted_flag')==='false' && col('project_evidence_count')===$project_evidence_count && col('task_count')===$task_count)
```

2. Query **project\_task\_enrollment** Cassandra Table :-

* Construct the Cassandra Query based on the Primary Filters (program\_id, solution\_id) present in the request\_data

select submission\_id,task\_id,task\_name,task\_evidence,task\_remarks,task\_deleted\_flag,task\_sequence from **project\_task\_enrollment** where program\_id='64119acbad848b0008fd6897' and solution\_id='64119b52ad848b0008fd697f'

Store the result into the spark dataframe

* Filters the above dataframe based on the Secondary Filters (task\_deleted\_flag,task\_evidence\_count) present in the request\_data

```
df = df.filter(col('task_deleted_flag')==='false' && col('task_evidence_count')===$task_evidence_count)
```

To maintain synchronization between MongoDB and Cassandra, we can consider the following approaches:

1. **From App/Portal store the data directly to Cassandra:** Instead of storing the data in MongoDB first, you can modify your application or portal to directly store the data in Cassandra. This ensures that the data is immediately available in Cassandra and eliminates the need for synchronization. we would need to update our data access layer to write data to Cassandra and handle any schema differences between MongoDB and Cassandra.
2. **Run a cron job to sync the data between MongoDB and CassandraDB:** To periodically sync the data between MongoDB and Cassandra, we can schedule a cron job that runs at a defined interval (e.g., every 5 minutes). The cron job fetches the new or modified data from MongoDB, marks it as "processed" or adds a new key-value pair to track its synchronization status, and then inserts or updates it in Cassandra. This approach ensures regular synchronization between the two databases and allows for eventual consistency.
3. **From App/Portal push the data into Kafka and Flink processes it:** In this approach, the data from the App/Portal is pushed into Kafka, and Flink jobs consume and process the data. Flink performs necessary transformations, flattens the data, and stores it into Cassandra. To handle Cassandra failures, we can implement a backup mechanism where the insert queries are stored in a log file when Cassandra is unavailable. A separate cron job script periodically checks the availability of Cassandra and inserts the pending data once Cassandra is up and running again. This approach ensures data resilience and allows for recovery from Cassandra failures.

***

\[\[category.storage-team]] \[\[category.confluence]]
