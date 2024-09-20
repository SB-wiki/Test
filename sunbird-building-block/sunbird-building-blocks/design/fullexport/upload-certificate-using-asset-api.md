  * [Introduction:](#introduction:)
  * [Background:](#background:)
  * [Problem Statement:](#problem-statement:)
  * [Key design problems:](#key-design-problems:)
  * [How to get certificates using asset API](#how-to-get-certificates-using-asset-api)
    * [Curl:](#curl:)
  * [How to get default certificate layouts using asset API?](#how-to-get-default-certificate-layouts-using-asset-api?)
  * [How to upload/create a new certificate template using a certificate layout(asset) or existing certificate template?](#how-to-upload/create-a-new-certificate-template-using-a-certificate-layout(asset)-or-existing-certificate-template?)
  * [How to upload/create an asset(used for uploading logos, signatures)](#how-to-upload/create-an-asset(used-for-uploading-logos,-signatures))
  * [How to copy & use the existing certificate template](#how-to-copy-&-use-the-existing-certificate-template)
  * [How to get asset details(for do_id)](#how-to-get-asset-details(for-do_id))

## Introduction:
This document describes how to upload certificate & use asset API’s for certificate


## Background:
Jira Issue [https://project-sunbird.atlassian.net/browse/SH-1228?](https://project-sunbird.atlassian.net/browse/SH-1228?)


## Problem Statement:

1. How to upload certificate using asset API




## Key design problems:

1. How to get a certificate using asset API(deprecate the existing preference API)


1. How to get default certificate layouts using asset API?


1. How to upload/create new certificate template using certificate layout(asset) or existing certificate template?



 **Attaching cert to a batch(till R3.3.0):** The below code is used to attach certificate to a batch(without using asset API)


```
{
                "identifier": "template_01_preprod_001",
                "criteria": {
                    "enrollment": {
                        "status": 2
                    }
                },
                "name": "Course completion certificate",
                "issuer": {
                    "name": "Gujarat Council of Educational Research and Training",
                    "url": "https://gcert.gujarat.gov.in/gcert/"
                },
                "signatoryList": [
                    {
                        "image": "https://cdn.pixabay.com/photo/2014/11/09/08/06/signature-523237__340.jpg",
                        "name": "CEO Gujarat",
                        "id": "CEO",
                        "designation": "CEO"
                    }
                ],
                "notifyTemplate": {
                    "subject": "Completion certificate",
                    "stateImgUrl": "https://sunbirddev.blob.core.windows.net/orgemailtemplate/img/File-0128212938260643843.png",
                    "regardsperson": "Chairperson",
                    "regards": "Minister of Gujarat",
                    "emailTemplateType": "defaultCertTemp"
                }
            }

```

## How to get certificates using asset API
To get all the certificate templates or layouts use the search API call with filters certType & channel





|  **“certType”:**  |  **Description**  | 
|  --- |  --- | 
| “cert template” | to get all the actual certificate templates that can attach to a batch | 
| “cert template layout” | to get all the certificate template layouts that can be used to create a new certificate template | 

 **“channel”:**  is used in the filter to get the certificate templates/layouts specific to channel

 _API endpoint:_ 


```
POST: /api/content/v1/search
```
 _API request body_ :


```
{ 
    "request": { 
        "filters":{
            "certType": "cert template",
            "channel": "in.ekstep"
        },
        "fields": ["indentifier","name","code","certType","data","issuer","signatoryList","artifactUrl","primaryCategory","channel"],
        "limit": 100
    }
}
```
 _Response :_ 


```
{
    "id": "api.content.search",
    "ver": "1.0",
    "ts": "2020-10-20T08:06:07.832Z",
    "params": {
        "resmsgid": "1bb27580-12ab-11eb-8b6f-697e327a8237",
        "msgid": "1bb0c7d0-12ab-11eb-8b6f-697e327a8237",
        "status": "successful",
        "err": null,
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "count": 1,
        "content": [
            {
                "identifier": "do_1131331781014077441222",
                "certType": "cert template",
                "code": "Test_Template_prad_2",
                "data": "{\"title\":\"Course Completion Certificate\"}",
                "primaryCategory": "Certificate Template",
                "channel": "in.ekstep",
                "name": "Test_Template_prad_2",
                "artifactUrl": "https://sunbirddev.blob.core.windows.net/sunbird-content-dev/content/do_1131331781014077441222/artifact/file-0130860005482086401.svg",
                "issuer": "{\"name\":\"Gujarat Council of Educational Research and Training\",\"url\":\"https://gcert.gujarat.gov.in/gcert/\"}",
                "objectType": "Content",
                "signatoryList": "[{\"image\":\"https://cdn.pixabay.com/photo/2014/11/09/08/06/signature-523237__340.jpg\",\"name\":\"CEO Gujarat\",\"id\":\"CEO\",\"designation\":\"CEO\"}]"
            }
        ]
    }
}
```

### Curl:

```
curl --location --request POST 'https://dev.sunbirded.org/action/composite/v3/search' \
--header 'Content-Type: application/json' \
--header 'user-id: ilimi' \
--header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiIyZThlNmU5MjA4YjI0MjJmOWFlM2EzNjdiODVmNWQzNiJ9.gvpNN7zEl28ZVaxXWgFmCL6n65UJfXZikUWOKSE8vJ8}}' \
--data-raw '{ 
    "request": { 
        "filters":{
            "certType": "cert template",
            "channel": "in.ekstep"
        },
        "fields": ["indentifier","name","code","certType","data","issuer","signatoryList","artifactUrl","primaryCategory","channel"],
        "limit": 100
    }
}'
```

## How to get default certificate layouts using asset API?
Same as API search API with only change "certType": ”cert template layout”.




## How to upload/create a new certificate template using a certificate layout(asset) or existing certificate template?
 **Create API (logo/signature create to get do_Id)**  _API endpoint:_ 


```
POST: /api/asset/v1/create
```
 _API request:_ 


```
{
    "request": {
        "asset": {
            "name": "2 logo 2 signature ",
            "code": "Cert template",
            "mimeType": "image/svg+xml",
            "license": "CC BY 4.0",
            "primaryCategory": "Certificate Template",
            "mediaType": "image",
            "issuer": {
                "name": "Gujarat Council of Educational Research and Training",
                "url": "https://gcert.gujarat.gov.in/gcert/"
            },
            "signatoryList": [ ],
            "certType": "cert template layout",
            "data": {
                "title": "",
                "signatoryList": [ ],
                "logos": [ ]
            }               
        }
    }
}
```
 _API response:_ 


```
{
    "id": "api.asset.create",
    "ver": "4.0",
    "ts": "2020-10-20T12:51:47ZZ",
    "params": {
        "resmsgid": "3554a675-ac5f-45c3-bf1e-c68ffb67b3ad",
        "msgid": null,
        "err": null,
        "status": "successful",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "identifier": "do_1131334005307883521282",
        "node_id": "do_1131334005307883521282",
        "versionKey": "1603198306987"
    }
}
```
 **Curl:** 
```
curl --location --request POST 'https://dev.sunbirded.org/api/asset/v1/create' \
--header 'X-Channel-Id: in.ekstep' \
--header 'x-authenticated-user-token: eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJsclI0MWpJNndlZmZoQldnaUpHSjJhNlowWDFHaE53a21IU3pzdzE0R0MwIn0.eyJqdGkiOiI2ZjBkMzY2Yy01NTU2LTQ4NGQtODUxNy1hY2E0MjAzMGExY2YiLCJleHAiOjE2MDMyNTg0OTIsIm5iZiI6MCwiaWF0IjoxNjAzMTcyMDkyLCJpc3MiOiJodHRwczovL2Rldi5zdW5iaXJkZWQub3JnL2F1dGgvcmVhbG1zL3N1bmJpcmQiLCJhdWQiOiJwcm9qZWN0LXN1bmJpcmQtZGV2LWNsaWVudCIsInN1YiI6ImY6NWE4YTNmMmItMzQwOS00MmUwLTkwMDEtZjkxM2JjMGZkZTMxOjg0NTRjYjIxLTNjZTktNGUzMC04NWI1LWZhZGUwOTc4ODBkOCIsInR5cCI6IkJlYXJlciIsImF6cCI6InByb2plY3Qtc3VuYmlyZC1kZXYtY2xpZW50IiwiYXV0aF90aW1lIjowLCJzZXNzaW9uX3N0YXRlIjoiMGIyODlhMjUtOWEwOS00OTE1LTliOGMtZjlkNWVjZWZlN2M0IiwiYWNyIjoiMSIsImFsbG93ZWQtb3JpZ2lucyI6WyJodHRwczovL2Rldi5zdW5iaXJkZWQub3JnIl0sInJlYWxtX2FjY2VzcyI6eyJyb2xlcyI6WyJ1bWFfYXV0aG9yaXphdGlvbiJdfSwicmVzb3VyY2VfYWNjZXNzIjp7ImFjY291bnQiOnsicm9sZXMiOlsibWFuYWdlLWFjY291bnQiLCJtYW5hZ2UtYWNjb3VudC1saW5rcyIsInZpZXctcHJvZmlsZSJdfX0sIm5hbWUiOiJNZW50b3IgRmlyc3QgVXNlciIsInByZWZlcnJlZF91c2VybmFtZSI6Im50cHRlc3QxMDQiLCJnaXZlbl9uYW1lIjoiTWVudG9yIEZpcnN0IiwiZmFtaWx5X25hbWUiOiJVc2VyIiwiZW1haWwiOiJ1c2VydGVzdDE0QHRlc3Rzcy5jb20ifQ.TG7eu4ywTUBfoRryauqrS_Ua_7-JdVEb0SV_Y8mJDlvItbCTSEUHI-MFqqkWZW25EPW5fxb1m2e1cQNX-pgium3ZyGv5gw0ezGeFZNADtoHe_vpiUYk-rfaqERb412PFWoM_bzf5dizwcilQC3plNwZF_QZ06myQCxC9TJ5Y0NfOWzInyGBLIbPVMVRbgICYTQCn5zDT0y7SWxxQL0OTbF9W2jkGia6KvGaafxSBEpCQ3phgf7wd1SYze-yEX3O1bGw1OwjwFPx7OCEsxRx6O76LFeBpznGzTvclvLI5yVlpLCTW-sEexcFxan_xxITXp7uPVUhyx_6yL1kQut64nw' \
--header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiIyZThlNmU5MjA4YjI0MjJmOWFlM2EzNjdiODVmNWQzNiJ9.gvpNN7zEl28ZVaxXWgFmCL6n65UJfXZikUWOKSE8vJ8' \
--header 'Content-Type: application/json' \
--header 'Cookie: 81f30cf708470b974874c8a96a6bcdb2=7v4hvjcksoj5hm3dvvklovsjm3; AWSELB=83D53DFF08C363B9195F6717118E44E326DE55CB79D96008C712C86602AF58D177147ABD9A230B5C96CE358AAD7B1487DBFC845B66F4A16100ED949FD5E6A1597965F2B7A7' \
--data-raw '{
    "request": {
        "asset": {
            "name": "2 logo 2 signature ",
            "code": "Cert template",
            "mimeType": "image/svg+xml",
            "license": "CC BY 4.0",
            "primaryCategory": "Certificate Template",
            "mediaType": "image",
            "issuer": {
                "name": "Gujarat Council of Educational Research and Training",
                "url": "https://gcert.gujarat.gov.in/gcert/"
            },
            "signatoryList": [ ],
            "certType": "cert template layout",
            "data": {
                "title": "",
                "signatoryList": [ ],
                "logos": [ ]
            }
               
        }
    }
}'
```


 **Upload API (logo/signature upload to blob storage to get artifactUrl)**  _API endpoint:_ 


```
POST: api/asset/create
```
 _API request:_ 


```
"form": 'file=@/home/vinu/Documents/Portal/certificates/templates/template-4.svg'
```
 _API response:_ 


```
{
    "id": "api.asset.upload",
    "ver": "4.0",
    "ts": "2020-10-20T12:52:46ZZ",
    "params": {
        "resmsgid": "37ae10f5-aa4e-4d20-9ccb-8a291ddc793f",
        "msgid": null,
        "err": null,
        "status": "successful",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "identifier": "do_1131334005307883521282",
        "artifactUrl": "https://sunbirddev.blob.core.windows.net/sunbird-content-dev/content/do_1131334005307883521282/artifact/template-4.svg",
        "content_url": "https://sunbirddev.blob.core.windows.net/sunbird-content-dev/content/do_1131334005307883521282/artifact/template-4.svg",
        "node_id": "do_1131334005307883521282",
        "versionKey": "1603198366375"
    }
}
```
 **Curl:** 
```
curl --location --request POST 'https://dev.sunbirded.org/api/asset/v1/upload/do_1131334005307883521282' \
--header 'x-authenticated-user-token: eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJsclI0MWpJNndlZmZoQldnaUpHSjJhNlowWDFHaE53a21IU3pzdzE0R0MwIn0.eyJqdGkiOiI2ZjBkMzY2Yy01NTU2LTQ4NGQtODUxNy1hY2E0MjAzMGExY2YiLCJleHAiOjE2MDMyNTg0OTIsIm5iZiI6MCwiaWF0IjoxNjAzMTcyMDkyLCJpc3MiOiJodHRwczovL2Rldi5zdW5iaXJkZWQub3JnL2F1dGgvcmVhbG1zL3N1bmJpcmQiLCJhdWQiOiJwcm9qZWN0LXN1bmJpcmQtZGV2LWNsaWVudCIsInN1YiI6ImY6NWE4YTNmMmItMzQwOS00MmUwLTkwMDEtZjkxM2JjMGZkZTMxOjg0NTRjYjIxLTNjZTktNGUzMC04NWI1LWZhZGUwOTc4ODBkOCIsInR5cCI6IkJlYXJlciIsImF6cCI6InByb2plY3Qtc3VuYmlyZC1kZXYtY2xpZW50IiwiYXV0aF90aW1lIjowLCJzZXNzaW9uX3N0YXRlIjoiMGIyODlhMjUtOWEwOS00OTE1LTliOGMtZjlkNWVjZWZlN2M0IiwiYWNyIjoiMSIsImFsbG93ZWQtb3JpZ2lucyI6WyJodHRwczovL2Rldi5zdW5iaXJkZWQub3JnIl0sInJlYWxtX2FjY2VzcyI6eyJyb2xlcyI6WyJ1bWFfYXV0aG9yaXphdGlvbiJdfSwicmVzb3VyY2VfYWNjZXNzIjp7ImFjY291bnQiOnsicm9sZXMiOlsibWFuYWdlLWFjY291bnQiLCJtYW5hZ2UtYWNjb3VudC1saW5rcyIsInZpZXctcHJvZmlsZSJdfX0sIm5hbWUiOiJNZW50b3IgRmlyc3QgVXNlciIsInByZWZlcnJlZF91c2VybmFtZSI6Im50cHRlc3QxMDQiLCJnaXZlbl9uYW1lIjoiTWVudG9yIEZpcnN0IiwiZmFtaWx5X25hbWUiOiJVc2VyIiwiZW1haWwiOiJ1c2VydGVzdDE0QHRlc3Rzcy5jb20ifQ.TG7eu4ywTUBfoRryauqrS_Ua_7-JdVEb0SV_Y8mJDlvItbCTSEUHI-MFqqkWZW25EPW5fxb1m2e1cQNX-pgium3ZyGv5gw0ezGeFZNADtoHe_vpiUYk-rfaqERb412PFWoM_bzf5dizwcilQC3plNwZF_QZ06myQCxC9TJ5Y0NfOWzInyGBLIbPVMVRbgICYTQCn5zDT0y7SWxxQL0OTbF9W2jkGia6KvGaafxSBEpCQ3phgf7wd1SYze-yEX3O1bGw1OwjwFPx7OCEsxRx6O76LFeBpznGzTvclvLI5yVlpLCTW-sEexcFxan_xxITXp7uPVUhyx_6yL1kQut64nw' \
--header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiIyZThlNmU5MjA4YjI0MjJmOWFlM2EzNjdiODVmNWQzNiJ9.gvpNN7zEl28ZVaxXWgFmCL6n65UJfXZikUWOKSE8vJ8' \
--form 'file=@/home/vinu/Documents/Portal/certificates/templates/template-4.svg'
```



## How to upload/create an asset(used for uploading logos, signatures)
 **Create API (logo/signature create to get do_Id)** 



|  **Upload Image**  |  **Primary Category**  |  **Description**  | 
|  --- |  --- |  --- | 
| Logos | Asset | Publicly accessible to any user. | 
| Signature | CertAsset | To avoid showing these images in any other asset browsers. These images should be private. Laster release we will use as “base64” string instead of uploading to blob. | 

 _API endpoint:_ 


```
POST: /api/content/v1/create
```
 _API request:_ 


```
{
    "request": {
        "content": {
            "name": "Screenshot from 2020-10-03 13-12-22",
            "creator": "Mentor First User",
            "createdBy": "8454cb21-3ce9-4e30-85b5-fade097880d8",
            "code": "org.ekstep0.8822006649194734",
            "mimeType": "image/png",
            "mediaType": "image",
            "contentType": "Asset",
            "channel": "b00bc992ef25f1a9a8d63291e20efc8d"
        }
    }
}
```
 _API response:_ 


```
{
    "id": "api.content.create",
    "ver": "1.0",
    "ts": "2020-10-20T13:30:09.375Z",
    "params": {
        "resmsgid": "5fc27ef0-12d8-11eb-8012-d3733e89099c",
        "msgid": "5fbb7a10-12d8-11eb-8012-d3733e89099c",
        "status": "successful",
        "err": null,
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "content_id": "do_1131334193916805121299",
        "versionKey": "1603200609340"
    }
}
```
 **Curl:** 
```
curl --location --request POST 'https://dev.sunbirded.org/api/content/v1/create' \
--header 'x-authenticated-user-token: eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJsclI0MWpJNndlZmZoQldnaUpHSjJhNlowWDFHaE53a21IU3pzdzE0R0MwIn0.eyJqdGkiOiJhZDAwMzNiOS00NzhlLTQzMTItYWI2Yi00ZmJkODJlYzI1MWQiLCJleHAiOjE2MDMyODU5NTQsIm5iZiI6MCwiaWF0IjoxNjAzMTk5NTU0LCJpc3MiOiJodHRwczovL2Rldi5zdW5iaXJkZWQub3JnL2F1dGgvcmVhbG1zL3N1bmJpcmQiLCJhdWQiOiJwcm9qZWN0LXN1bmJpcmQtZGV2LWNsaWVudCIsInN1YiI6ImY6NWE4YTNmMmItMzQwOS00MmUwLTkwMDEtZjkxM2JjMGZkZTMxOjg0NTRjYjIxLTNjZTktNGUzMC04NWI1LWZhZGUwOTc4ODBkOCIsInR5cCI6IkJlYXJlciIsImF6cCI6InByb2plY3Qtc3VuYmlyZC1kZXYtY2xpZW50IiwiYXV0aF90aW1lIjowLCJzZXNzaW9uX3N0YXRlIjoiY2E2Nzg4NGYtMjYyNC00MGQ2LTgzNmMtMjI3MGYzODdjMjYwIiwiYWNyIjoiMSIsImFsbG93ZWQtb3JpZ2lucyI6WyJodHRwczovL2Rldi5zdW5iaXJkZWQub3JnIl0sInJlYWxtX2FjY2VzcyI6eyJyb2xlcyI6WyJ1bWFfYXV0aG9yaXphdGlvbiJdfSwicmVzb3VyY2VfYWNjZXNzIjp7ImFjY291bnQiOnsicm9sZXMiOlsibWFuYWdlLWFjY291bnQiLCJtYW5hZ2UtYWNjb3VudC1saW5rcyIsInZpZXctcHJvZmlsZSJdfX0sIm5hbWUiOiJNZW50b3IgRmlyc3QgVXNlciIsInByZWZlcnJlZF91c2VybmFtZSI6Im50cHRlc3QxMDQiLCJnaXZlbl9uYW1lIjoiTWVudG9yIEZpcnN0IiwiZmFtaWx5X25hbWUiOiJVc2VyIiwiZW1haWwiOiJ1c2VydGVzdDE0QHRlc3Rzcy5jb20ifQ.kPF0neXX0MRKdR7J4cgGHFIkAbkt-6Ia58L2nwJZopdTSuWdWORlsyDUZHA2O9zD7MKPsu4mnUS_KBQWTMv_4BMdfhX0Ung2MVczEbH14nbPB-FHCPGVU0fzXggLt62TLDEoMMbsaBf9EOZss6vDmrtaxn9is0maTTR3TmVMXtj2_YK30L65vgIitjWIjL7etG7qQO7fAnJAffxL2XOfQSi-oMhZM4U_tjhyEltMyOc1ZkKM2j82qUM52n6qRsGgDduA6duZ27A0IkrBOXplR9_BAV_CpsXbecUieFbE0UpdxZ8aEAT2VAI13mwgEUUn8nArSWtNd5BPO818boM8fA' \
--header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiIyZThlNmU5MjA4YjI0MjJmOWFlM2EzNjdiODVmNWQzNiJ9.gvpNN7zEl28ZVaxXWgFmCL6n65UJfXZikUWOKSE8vJ8' \
--header 'Content-Type: application/json' \
--data-raw '{
    "request": {
        "content": {
            "name": "Screenshot from 2020-10-03 13-12-22",
            "creator": "Mentor First User",
            "createdBy": "8454cb21-3ce9-4e30-85b5-fade097880d8",
            "code": "org.ekstep0.8822006649194734",
            "mimeType": "image/png",
            "mediaType": "image",
            "contentType": "Asset",
            "channel": "b00bc992ef25f1a9a8d63291e20efc8d"
        }
    }
}'
```


 **Upload API (logo/signature upload to blob storage to get** artifactUrl **)**  _API endpoint:_ 


```
POST:/api/content/v1/upload/do_1131334198398730241300
```
 _API request:_ 


```
form 'file=@/home/vinu/Pictures/Application-developer-career-paths-1.png'
```
 _API response:_ 


```
{
    "id": "api.content.upload",
    "ver": "1.0",
    "ts": "2020-10-20T13:38:50.231Z",
    "params": {
        "resmsgid": "9636d070-12d9-11eb-8012-d3733e89099c",
        "msgid": "96005720-12d9-11eb-8012-d3733e89099c",
        "status": "successful",
        "err": null,
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "identifier": "do_1131334198398730241300",
        "artifactUrl": "https://sunbirddev.blob.core.windows.net/sunbird-content-dev/content/do_1131334198398730241300/artifact/application-developer-career-paths-1.png",
        "content_url": "https://sunbirddev.blob.core.windows.net/sunbird-content-dev/content/do_1131334198398730241300/artifact/application-developer-career-paths-1.png",
        "node_id": "do_1131334198398730241300",
        "versionKey": "1603201130147"
    },
    "success": true
}
```
 **Curl:** 
```
curl --location --request POST 'https://dev.sunbirded.org/api/content/v1/upload/do_1131334198398730241300' \
--header 'x-authenticated-user-token: eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJsclI0MWpJNndlZmZoQldnaUpHSjJhNlowWDFHaE53a21IU3pzdzE0R0MwIn0.eyJqdGkiOiJhZDAwMzNiOS00NzhlLTQzMTItYWI2Yi00ZmJkODJlYzI1MWQiLCJleHAiOjE2MDMyODU5NTQsIm5iZiI6MCwiaWF0IjoxNjAzMTk5NTU0LCJpc3MiOiJodHRwczovL2Rldi5zdW5iaXJkZWQub3JnL2F1dGgvcmVhbG1zL3N1bmJpcmQiLCJhdWQiOiJwcm9qZWN0LXN1bmJpcmQtZGV2LWNsaWVudCIsInN1YiI6ImY6NWE4YTNmMmItMzQwOS00MmUwLTkwMDEtZjkxM2JjMGZkZTMxOjg0NTRjYjIxLTNjZTktNGUzMC04NWI1LWZhZGUwOTc4ODBkOCIsInR5cCI6IkJlYXJlciIsImF6cCI6InByb2plY3Qtc3VuYmlyZC1kZXYtY2xpZW50IiwiYXV0aF90aW1lIjowLCJzZXNzaW9uX3N0YXRlIjoiY2E2Nzg4NGYtMjYyNC00MGQ2LTgzNmMtMjI3MGYzODdjMjYwIiwiYWNyIjoiMSIsImFsbG93ZWQtb3JpZ2lucyI6WyJodHRwczovL2Rldi5zdW5iaXJkZWQub3JnIl0sInJlYWxtX2FjY2VzcyI6eyJyb2xlcyI6WyJ1bWFfYXV0aG9yaXphdGlvbiJdfSwicmVzb3VyY2VfYWNjZXNzIjp7ImFjY291bnQiOnsicm9sZXMiOlsibWFuYWdlLWFjY291bnQiLCJtYW5hZ2UtYWNjb3VudC1saW5rcyIsInZpZXctcHJvZmlsZSJdfX0sIm5hbWUiOiJNZW50b3IgRmlyc3QgVXNlciIsInByZWZlcnJlZF91c2VybmFtZSI6Im50cHRlc3QxMDQiLCJnaXZlbl9uYW1lIjoiTWVudG9yIEZpcnN0IiwiZmFtaWx5X25hbWUiOiJVc2VyIiwiZW1haWwiOiJ1c2VydGVzdDE0QHRlc3Rzcy5jb20ifQ.kPF0neXX0MRKdR7J4cgGHFIkAbkt-6Ia58L2nwJZopdTSuWdWORlsyDUZHA2O9zD7MKPsu4mnUS_KBQWTMv_4BMdfhX0Ung2MVczEbH14nbPB-FHCPGVU0fzXggLt62TLDEoMMbsaBf9EOZss6vDmrtaxn9is0maTTR3TmVMXtj2_YK30L65vgIitjWIjL7etG7qQO7fAnJAffxL2XOfQSi-oMhZM4U_tjhyEltMyOc1ZkKM2j82qUM52n6qRsGgDduA6duZ27A0IkrBOXplR9_BAV_CpsXbecUieFbE0UpdxZ8aEAT2VAI13mwgEUUn8nArSWtNd5BPO818boM8fA' \
--header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiIyZThlNmU5MjA4YjI0MjJmOWFlM2EzNjdiODVmNWQzNiJ9.gvpNN7zEl28ZVaxXWgFmCL6n65UJfXZikUWOKSE8vJ8' \
--form 'file=@/home/vinu/Pictures/Application-developer-career-paths-1.png'
```

## How to copy & use the existing certificate template
 _API endpoint:_ 


```
POST: api/asset/create
```
 _API request:_ 


```

```
 _API response:_ 


```

```



## How to get asset details(for do_id)
This is to get the details of the asset/certificate by using do_id

 _API endpoint:_ 


```
GET: /api/content/v1/read/do_1131332776230174721237
```
 _API response:_ 


```
{
    "id": "api.content.read",
    "ver": "1.0",
    "ts": "2020-10-20T11:58:51.970Z",
    "params": {
        "resmsgid": "9ef8d220-12cb-11eb-8012-d3733e89099c",
        "msgid": "9ef6d650-12cb-11eb-8012-d3733e89099c",
        "status": "successful",
        "err": null,
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "content": {
            "ownershipType": [
                "createdBy"
            ],
            "certType": "cert template",
            "code": "Test_Template_prad_2",
            "data": {
                "title": "Course Completion Certificate",
                "signatoryList": [
                    {
                        "image": "https://cdn.pixabay.com/photo/2014/11/09/08/06/signature-523237__340.jpg",
                        "name": "CEO Gujarat",
                        "id": "CEO",
                        "designation": "CEO"
                    }
                ]
            },
            "prevStatus": "Processing",
            "channel": "in.ekstep",
            "downloadUrl": "https://sunbirddev.blob.core.windows.net/sunbird-content-dev/content/do_1131332776230174721237/artifact/template-2.svg",
            "language": [
                "English"
            ],
            "mimeType": "image/svg+xml",
            "variants": {
                "high": "https://sunbirddev.blob.core.windows.net/sunbird-content-dev/content/do_1131332776230174721237/artifact/template-2.svg",
                "medium": "https://sunbirddev.blob.core.windows.net/sunbird-content-dev/content/do_1131332776230174721237/artifact/template-2.svg"
            },
            "idealScreenSize": "normal",
            "createdOn": "2020-10-20T08:41:43.596+0000",
            "issuer": {
                "name": "Gujarat Council of Educational Research and Training",
                "url": "https://gcert.gujarat.gov.in/gcert/"
            },
            "objectType": "Content",
            "primaryCategory": "Certificate Template",
            "contentDisposition": "inline",
            "lastUpdatedOn": "2020-10-20T10:05:34.261+0000",
            "contentEncoding": "identity",
            "artifactUrl": "https://sunbirddev.blob.core.windows.net/sunbird-content-dev/content/do_1131332776230174721237/artifact/template-2.svg",
            "contentType": "Asset",
            "dialcodeRequired": "No",
            "identifier": "do_1131332776230174721237",
            "lastStatusChangedOn": "2020-10-20T10:05:34.248+0000",
            "audience": [
                "Student"
            ],
            "os": [
                "All"
            ],
            "visibility": "Default",
            "cloudStorageKey": "content/do_1131332776230174721237/artifact/template-2.svg",
            "consumerId": "7411b6bd-89f3-40ec-98d1-229dc64ce77d",
            "mediaType": "image",
            "osId": "org.ekstep.quiz.app",
            "languageCode": [
                "en"
            ],
            "version": 2,
            "signatoryList": [
                {
                    "image": "https://cdn.pixabay.com/photo/2014/11/09/08/06/signature-523237__340.jpg",
                    "name": "CEO Gujarat",
                    "id": "CEO",
                    "designation": "CEO"
                }
            ],
            "versionKey": "1603188334261",
            "license": "CC BY 4.0",
            "idealScreenDensity": "hdpi",
            "framework": "NCF",
            "s3Key": "content/do_1131332776230174721237/artifact/template-2.svg",
            "size": 258935,
            "compatibilityLevel": 1,
            "name": "Test_Template_prad_2",
            "status": "Live"
        }
    }
}
```
 **Curl:** 
```
curl --location --request GET 'https://dev.sunbirded.org/api/content/v1/read/do_1131332776230174721237' \
--header 'Content-Type: application/json' \
--header 'user-id: rayuluv' \
--header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiIyZThlNmU5MjA4YjI0MjJmOWFlM2EzNjdiODVmNWQzNiJ9.gvpNN7zEl28ZVaxXWgFmCL6n65UJfXZikUWOKSE8vJ8'
```


Related articles:

[[Certificate: Attach to a batch|Certificate--Attach-to-a-batch]]

[https://project-sunbird.atlassian.net/wiki/spaces/SP/pages/1665925124/Certificate+criteria+verification?focusedCommentId=1679982648](https://project-sunbird.atlassian.net/wiki/spaces/SP/pages/1665925124/Certificate+criteria+verification?focusedCommentId=1679982648)





*****

[[category.storage-team]] 
[[category.confluence]] 
