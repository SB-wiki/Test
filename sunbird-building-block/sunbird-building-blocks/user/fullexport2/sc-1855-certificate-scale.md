    * [release-3.2 ](#release-3.2-)
  * [Pre-Reads](#pre-reads)
  * [API endPoint](#api-endpoint)
  * [SVG template variables](#svg-template-variables)
This is taken as part of an effort to move away from HTML templates to SVG templates. The PDF generation in the backend with nodeJs and JAVA scripts took time of about 1-2s, thereby limiting our issue rate. We believe SVG templates can save 60-70 of that time.

The SVG template characteristics are as follows:


### release-3.2 

1. All font, logos, images are absolute referenced - ‘http://’ , rather than local references.




## Pre-Reads

1. [[Ecreds - Phase3 and SB rollout|Ecreds---Phase3-and-SB-rollout]]


1. [[Credentials for everyone|Credentials-for-everyone]]


1. [https://project-sunbird.atlassian.net/wiki/spaces/SBDES/pages/edit-v2/1583677441](https://project-sunbird.atlassian.net/wiki/spaces/SBDES/pages/edit-v2/1583677441)  - how tenant pref APIs are used to store these values 





The following enhancements shall support these:


1. v2/certs/generate 

    Existing (v1) cert generate api, returns pdfUrl, cert data, access code , where pdf is generated using print service and uploaded to cloud. So we have to cut off the pdf generation in cert-service. Instead of sending pdfUrl in response, embed the SVG image in printURI field.

    The qrCodeImage will be base64 converted and embedded in the SVG image itself - completely self-contained.


1. /certs/v2/registry/download/{id}

    Existing (v1) api expects pdfUrl. 


1. /certs/v2/registry/add

    Existing (v1) Api expects pdfUrl, In v2 no need of sending  pdfUrl, as in jsonData we embeded the SVG image in printURI field






## API endPoint
POST /v2/certs/generateRequestThe request will be the same as v1 cert generate with the following differences:


1. htmlTemplate is removed


1. svgTemplate is added


1. Allowing  API to accept dynamic template attributes key-value pairs, the attributes must be passed in the related object(data.releated)




```json
{
    "request": {
        "certificate":{
            "svgTemplate" : "SVG file",  
            "issuedDate": "2020-06-11",
            "courseName": "",
            "data": [
                {
                    "recipientName": "",
                    "recipientId": "",
                    "related": {
                        "anyKey": "anyValue",
                        "user_declared_state": "AP"
                    } // optional, contains dynamic template attributes 
                }
            ],
            "basePath": "",
            "criteria": {
                "narrative": ""
            },
            "name": "",
            "issuer": {
                "name": "",
                "url": ""
            },
            "signatoryList": [
                {
                    "image": "",
                    "name": "",
                    "id": "",
                    "designation": ""
                }
            ]
        }
    }
}
```
Response:Note: pdfURL will not appear in response.


```json
{
    "id": null,
    "ver": null,
    "ts": null,
    "params": null,
    "responseCode": "OK",
    "result": {
        "response": [
            {
                "jsonData": ""
                "jsonUrl": "",
                "accessCode": "",
                "recipientId": "",
                "id": ""
            }
        ]
    }
}
```
GET /certs/v2/registry/download/{id} This will be available in /certreg - cert_registry_service_prefix in the api gateway.

Response
```json

{
   "id": api.certreg.download2,
    "ver": v1,
    "ts": 2019-10-17 05:33:12:879+0000,
    "params": null,
    "responseCode": "OK",
    "result": {
        "printUri": "data:image/svg+xml,%3C svg..."
    }
}
```
POST /certs/v2/registry/addRequest
```json
{
    "request": {
        "recipientId":"user_id",
        "id": "cert_id",
        "recipienType":"entity/Individual" //optional param
        "accessCode": "access_code,
        "jsonData":{
            "id":"http://localhost:8080/_schemas/Certificate/d5a28280-98ac-4294-a508-21075dc7d475","type":["Assertion","Extension","extensions:CertificateExtension"],"issuedOn":"2019-08-31T12:52:25Z","recipient":{"identity":"ntptest103","type":["phone"],"hashed":false,"name":"Aishwarya","@context":"http://localhost:8080/_schemas/context.json"},"badge":{"id":"http://localhost:8080/_schemas/Badge.json","type":["BadgeClass"],"name":"Sunbird installation","description":"Certificate of Appreciation in National Level ITI Grading","image":"https://certs.example.gov/o/dgt/HJ5327VB1247G","criteria":{"type":["Criteria"],"id":"http://localhost:8080/_schemas/Certificate/d5a28280-98ac-4294-a508-21075dc7d475","narrative":"For exhibiting outstanding performance"},"issuer":{"context":"http://localhost:8080/_schemas/context.json","id":"http://localhost:8080/_schemas/Issuer.json","type":["Issuer"],"name":"NIIT"},"@context":"http://localhost:8080/_schemas/context.json"},"expires":"2019-09-30T12:52:25Z","verification":{"type":["SignedBadge"],"creator":"http://localhost:8080/_schemas/publicKey.json"},"revoked":false,"validFrom":"2019-06-21","@context":"http://localhost:8080/_schemas/context.json"
        },
       "jsonUrl": "string "  //optional param
        "revoked": false/true,   //Optional Param
        "reason":"reason for revoked //optional param "
        "introUrl":"https://introurl.com",
         "related":{
            "type":"course-completion", // type of template or a string will be of use
            "any_other_keys": "values",
        }
    }
}
```
Response
```json
{
   ""id": "api.certs.registry.add",
    "ver": "v2",
    "ts": "1597408565306"
    "ts": 2019-10-17 05:33:12:879+0000,
    "params": null,
    "responseCode": "OK",
    "result": {
        "id": "cert_id"
    }
}
```

## SVG template variables
Syntax - ${variable_name}



|  **variable name**  |  **Description**  | 
|  --- |  --- | 
| ${certificateName} |  | 
| ${$certificateDescription} |  | 
| ${recipientName} |  | 
| ${recipientId} |  | 
| ${issuedDate} |  | 
| ${expiryDate} |  | 
| ${signatory0Image} |  | 
| ${signatory0Designation} |  | 
| ${signatory1Image} |  | 
| ${signatory1Designation} |  | 
| ${courseName} |  | 
| ${qrCodeImage} |  | 
| ${issuerName} |  | 





*****

[[category.storage-team]] 
[[category.confluence]] 
