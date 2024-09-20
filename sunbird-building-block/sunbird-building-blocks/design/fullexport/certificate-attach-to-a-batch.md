  * [Introduction:](#introduction:)
  * [Background:](#background:)
  * [Problem Statement:](#problem-statement:)
  * [Key design problems:](#key-design-problems:)
  * [Solution:](#solution:)
    * [Create: Cert Template for a tenant](#create:-cert-template-for-a-tenant)
    * [Get: Certificate template for a tenant](#get:-certificate-template-for-a-tenant)
    * [Create: Certificate rules for a tenant ](#create:-certificate-rules-for-a-tenant-)
    * [Get: Certificate rules for a tenant](#get:-certificate-rules-for-a-tenant)
    * [Create: Certificate templates list of a tenant](#create:-certificate-templates-list-of-a-tenant)
    * [Create: Attach certificate to a batch of the course](#create:-attach-certificate-to-a-batch-of-the-course)
    * [Get: Certificate attached to a batch of the course](#get:-certificate-attached-to-a-batch-of-the-course)

## Introduction:
This document describes how to issue/assign the certificate to a batch of the specific course.


## Background:
 **Jira Issues** 


* UI designs: [https://project-sunbird.atlassian.net/browse/SH-641](https://project-sunbird.atlassian.net/browse/SH-641)


* Related stories


    * [https://project-sunbird.atlassian.net/browse/SH-597](https://project-sunbird.atlassian.net/browse/SH-597)


    * [https://project-sunbird.atlassian.net/browse/SH-638](https://project-sunbird.atlassian.net/browse/SH-638)


    * [https://project-sunbird.atlassian.net/browse/SH-639](https://project-sunbird.atlassian.net/browse/SH-639)


    * [https://project-sunbird.atlassian.net/browse/SH-640](https://project-sunbird.atlassian.net/browse/SH-640)



    


## Problem Statement:

1. How to assign the specific certificate to a batch(Of a course)?




## Key design problems:

1. How to create an independent module/component of issues/assign certificate?


1. How to assign cert to any trackable content?


1. How to preview the certificate template?




## Solution:
[https://projects.invisionapp.com/share/YTY9E6H2BZV#/screens/427016703](https://projects.invisionapp.com/share/YTY9E6H2BZV#/screens/427016703)


### Create: Cert Template for a tenant
POST v2/org/preferences/create **Request** 


```
{
    "request": {
        "orgId": "0126825293972439041",   // rootOrgIg or ChannelId
        "key": "iGOTCourseTemplate",
        "data": {
                    "template": "https://preprodall.blob.core.windows.net/user/certificate/File-01301994007487283297.zip",
                    "identifier": "iGOTCourseTemplate",
                    "previewUrl": "https://sunbirddev.blob.core.windows.net/e-credentials/svgcerts/cert.svg",
                    "name": "Acknowledgement Certificate",
                    "issuer": {
                        "name": "iGOT",
                        "publicKey": [
                            "33"
                        ],
                        "url": "https://igot.gov.in/igot/"
                    },
                    "signatoryList": [
                        {
                            "image": "https://igot.gov.in/tenant/igot/logo.png",
                            "name": "iGOT",
                            "id": "iGOT",
                            "designation": "GOVT"
                        }
                    ]
                }
    }
}
```
 **Response** 


```

```



### Get: Certificate template for a tenant
POST v2/org/preferences/read **Request** 


```
request: {
    "orgId":"0126825293972439041",   // rootOrgIg or ChannelId
    "key": "iGOTCourseTemplate"
}
```
 **Response** 


```
{
    "id": "api.org.preferences.read",
    "ver": "v2",
    "ts": "2020-08-13 18:35:50:148+0000",
    "params": {
        "resmsgid": null,
        "msgid": "3c75d002-15a6-3d5e-8dcd-1bf6179548b2",
        "err": null,
        "status": "success",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "response": {
            "updatedBy": null,
            "data": {
                "template": "https://preprodall.blob.core.windows.net/user/certificate/File-01301994007487283297.zip",
                "identifier": "iGOTCourseTemplate",
                "previewUrl": "https://sunbirddev.blob.core.windows.net/e-credentials/svgcerts/cert.svg",
                "name": "Acknowledgement Certificate",
                "issuer": {
                    "name": "iGOT",
                    "publicKey": [
                        "33"
                    ],
                    "url": "https://igot.gov.in/igot/"
                },
                "signatoryList": [
                    {
                        "image": "https://igot.gov.in/tenant/igot/logo.png",
                        "name": "iGOT",
                        "id": "iGOT",
                        "designation": "GOVT"
                    }
                ]
            },
            "createdBy": "8454cb21-3ce9-4e30-85b5-fade097880d8",
            "updatedOn": null,
            "createdOn": 1597343407470,
            "key": "iGOTCourseTemplate",
            "orgId":"0126825293972439041"
        }
    }
}
```



### Create: Certificate rules for a tenant 


POST v2/org/preferences/create **Request** 


```
{
    "request": {
        "orgId": "0126825293972439041",   // rootOrgIg or ChannelId
        "key": "certRules",  // Unique key for the form/page
        "data": {
            "templateName": "certRules",
            "action": "save",
            "fields": [
                {
                    "code": "certTypes",
                    "dataType": "text",
                    "name": "certTypes",
                    "label": "Certificate type",
                    "description": "Select certificate",
                    "editable": true,
                    "inputType": "select",
                    "required": true,
                    "displayProperty": "Editable",
                    "visible": true,
                    "renderingHints": {
                        "fieldColumnWidth": "twelve"
                    },
                    "range": [
                        {
                            "name": "Completion certificate",
                            "value": {
                                "enrollment": {
                                    "status": 2
                                }
                            }
                        },
                        {
                            "name": "Merit certificate",
                            "value": {
                                "score": ">= 60"
                            }
                        }
                        ],
                        "index": 1
                    },
                    {
                        "code": "issueTo",
                        "dataType": "text",
                        "name": "issueTo",
                        "label": "Issue certificate to",
                        "description": "Select",
                        "editable": true,
                        "inputType": "select",
                        "required": true,
                        "displayProperty": "Editable",
                        "visible": true,
                        "renderingHints": {
                            "fieldColumnWidth": "twelve"
                        },
                        "range": [
                            {
                                "name": "All",
                                "value": {
                                    "user": {
                                        "rootid": ""
                                    }
                                }
                            },
                            {
                                "name": "My state teacher",
                                "rootOrgId": ""
                            }
                        ],
                        "index": 2
                    }
                ]
            }
        }
    }
```



### Get: Certificate rules for a tenant
POST v2/org/preferences/read **Request** 


```
{
   "request": {
       "orgId": "0126825293972439041",   // rootOrgIg or ChannelId
       "key":   "certRules", //mandatory
   }
}
```
 **Response:** 


```
{
    "id": "api.org.preferences.read",
    "ver": "v2",
    "ts": "2020-08-13 06:24:54:762+0000",
    "params": {
        "resmsgid": null,
        "msgid": "3c75d002-15a6-3d5e-8dcd-1bf6179548b2",
        "err": null,
        "status": "success",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "response": {
            "updatedBy": null,
            "data": {
                "templateName": "certRules",
                "action": "save",
                "fields": [
                    {
                        "code": "certTypes",
                        "dataType": "text",
                        "name": "certTypes",
                        "label": "Certificate type",
                        "description": "Select certificate",
                        "editable": true,
                        "inputType": "select",
                        "required": true,
                        "displayProperty": "Editable",
                        "visible": true,
                        "renderingHints": {
                            "fieldColumnWidth": "twelve"
                        },
                        "range": [
                            {
                                "name": "Completion certificate",
                                "value": {
                                    "enrollment": {
                                        "status": 2
                                    }
                                }
                            },
                            {
                                "name": "Merit certificate",
                                "value": {
                                    "score": ">= 60"
                                }
                            }
                        ],
                        "index": 1
                    },
                    {
                        "code": "issueTo",
                        "dataType": "text",
                        "name": "issueTo",
                        "label": "Issue certificate to",
                        "description": "Select",
                        "editable": true,
                        "inputType": "select",
                        "required": true,
                        "displayProperty": "Editable",
                        "visible": true,
                        "renderingHints": {
                            "fieldColumnWidth": "twelve"
                        },
                        "range": [
                            {
                                "name": "All",
                                "value": {
                                    "user": {
                                        "rootid": ""
                                    }
                                }
                            },
                            {
                                "name": "My state teacher",
                                "rootOrgId": ""
                            }
                        ],
                        "index": 2
                    }
                ]
            },
            "createdBy": "8454cb21-3ce9-4e30-85b5-fade097880d8",
            "updatedOn": null,
            "createdOn": 1597299843372,
            "key": "certRules",
            "orgId":"0126825293972439041"
        }
    }
}
```



### Create: Certificate templates list of a tenant
POST /api/org/v2/preferences/create **Request** 


```
{
    "request": {
        "orgId":"0126825293972439041",   // rootOrgIg or ChannelId
        "key": "certList",  
        "data": {
            "code": "teamplate",
            "dataType": "text",
            "name": "template",
            "label": "",
            "description": "certs templates list",
            "inputType": "template",
            "index": 1,
            "range": [
                {
                    "name": "iGOTCourseTemplate",   // certificate identifier
                    "displayName": "",
                    "value": "https://sunbirddev.blob.core.windows.net/e-credentials/svgcerts/cert.svg",  // certificate preview url
                    "index": 1
                },
                {
                    "name": "SunbirdCert",
                    "displayName": "",
                    "value": "https://sunbirddev.blob.core.windows.net/e-credentials/svgcerts/cert.svg",
                    "index": 2
                }
            ]
        }
    }
}
```



### Create: Attach certificate to a batch of the course
POST /api/course/batch/cert/v1/template/addNote:


*  **PreviewUrl**  - This is mandatory for the certificate preview



 **Request** 


```
{
    "request": {
        "batch": {
            "courseId": "do_11308028601097420812366",
            "batchId": "0130838444540149762",
            "template": {
                "identifier": "iGOTCourseTemplate",
                "criteria": {
                    "enrollment": {
                        "status": 2
                    },
                    "user": {
                        "rootOrgId": "ORG_001"
                    }
                },
                "name": "Acknowledgement Certificate",
                "template": "https://preprodall.blob.core.windows.net/user/certificate/File-01301994007487283297.zip",
                "previewUrl": "https://sunbirddev.blob.core.windows.net/e-credentials/svgcerts/cert.svg",
                "issuer": {
                    "name": "iGOT",
                    "publicKey": [
                        "33"
                    ],
                    "url": "https://igot.gov.in/igot/"
                },
                "signatoryList": [
                    {
                        "image": "https://igot.gov.in/tenant/igot/logo.png",
                        "name": "iGOT",
                        "id": "iGOT",
                        "designation": "GOVT"
                    }
                ]
            }
        }
    }
}
```



### Get: Certificate attached to a batch of the course
GET /api/course/v1/batch/read/0130838444540149762NOTE:

cert_templates.previewUrl:    To show the preview of the certificate while managing the certificate

cert_templates.criteria.enrolment:    To identify the  **“certificate type”** 


* enrolment.status: "2”  indicates  **Completion certificate** 


* enrolment.score: ">=80”  indicates  **Merit certificate** 



cert_templates.criteria.user:    To identify the certificate can be  **“issue to whom“** 


* user.rootOrgId: "ORG_001"  to  **the state teachers** only


* user.{}  to  **all** users



 **Request** 


```

```
 **Response** 


```
{
    "id": "api.course.batch.read",
    "ver": "v1",
    "ts": "2020-08-13 13:35:28:724+0000",
    "params": {
        "resmsgid": null,
        "msgid": "bc0eb914-d084-43bb-a5ee-81cd9fe571d2",
        "err": null,
        "status": "success",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "response": {
            "identifier": "0130838444540149762",
            "createdFor": [
                "ORG_001"
            ],
            "endDate": "2020-09-13",
            "description": "",
            "updatedDate": "2020-08-13 09:55:04:569+0000",
            "cert_templates": {
                "iGOTCourseTemplate": {
                    "template": "https://preprodall.blob.core.windows.net/user/certificate/File-01301994007487283297.zip",
                    "identifier": "iGOTCourseTemplate",
                    "previewUrl": "https://sunbirddev.blob.core.windows.net/e-credentials/svgcerts/cert.svg",  
                    "criteria": {
                        "user": {  
                            "rootOrgId": "ORG_001"
                        },
                        "enrollment": {
                            "status": 2
                        }
                    },
                    "name": "Acknowledgement Certificate",
                    "issuer": {
                        "name": "iGOT",
                        "publicKey": [
                            "33"
                        ],
                        "url": "https://igot.gov.in/igot/"
                    },
                    "signatoryList": [
                        {
                            "image": "https://igot.gov.in/tenant/igot/logo.png",
                            "name": "iGOT",
                            "id": "iGOT",
                            "designation": "GOVT"
                        }
                    ]
                }
            },
            "batchId": "0130838444540149762",
            "createdDate": "2020-08-11 12:17:18:173+0000",
            "createdBy": "8454cb21-3ce9-4e30-85b5-fade097880d8",
            "mentors": [],
            "name": "Sudip Mukherjee",
            "id": "0130838444540149762",
            "enrollmentType": "open",
            "enrollmentEndDate": null,
            "courseId": "do_11308028601097420812366",
            "startDate": "2020-08-11",
            "status": 1
        }
    }
}
```


*****

[[category.storage-team]] 
[[category.confluence]] 
