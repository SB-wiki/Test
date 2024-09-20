# How-to--ECreds---SB-2.3.0-5

SB introduced eCreds in v2.3.0/5 as an experiment with bare minimal UI support. Most of the activities, prerequisites are done in backend with help of implementation and devops team. It is advised that this is done in the supervision of engineering or implementation cum devops monitor engineering. Since certificate generation is not an automated thing, this can be done in a day-light at the request of PM.

Refer to [PRD](https://project-sunbird.atlassian.net/wiki/spaces/PRD/pages/1063092344/eCreds) for details. The list of individual integration pieces are mentioned here and step\[s] associated to be executed on each item after. This is not a design document, but just a quick executive summary of solutioning we are envisioning.

1. Identify the root org and note down org id.&#x20;
2. Against the root org, identify a set of reserved keys from enc-service.
3. Call update root org with the keys identified in step 2.&#x20;
4. Identify the course and batch id to which we are interested to issue certificates.
5. Get the HTML template zip from ticket - TBD and upload it the eCreds container (owned by cert-service). This html zip has some signature images that is good to keep as private/confidential.
6.  All the above information, along with the following will be attached to a course/batch metadata.

    "issuer" : {

```
   "name": "Gujarat Council of Educational Research and Training",
```

```
   "url": "https://gcert.gujarat.gov.in/gcert/"

    }
```

1. Invoke /issue API
   1. Triggers a certificate generate event to Kafka topic
   2. The consumer of this topic will do the following:
   3. Invoke /generate API against the cert-service
   4. Invoke /certs/add API against the learner-service to deposit the certificates to the user-registry
   5. Notify the user that the certificate is available to download.

### Detailed steps

Individual step procedures are to be documented here for reference.

#### 1. Identify the root org id.

&#x20; To identify root org used org search end point as follow:

```js
curl -X POST \
  https://dev.sunbirded.org/api//course/v1/batch/list \
  -H 'Authorization: Bearer {api-key}' \
  -H 'Content-Type: application/json' \
  -H 'X-Consumer-ID: X-Consumer-ID' \
  -H 'X-Device-ID: X-Device-ID' \
  -H 'cache-control: no-cache' \
  -H 'ts: 2017-05-25 10:18:56:578+0530' \
  -d '{
    "request": {
        "filters": {
            "batchId":["01284169026368307244","01284169242542899246","01282684567237427212","01284169718189260844","01284093466818969624","0128310849258864641"]
        },
        "offset": 0,
        "limit": 20
       
    }
}'
```

&#x20; &#x20;

```js
curl -X POST \
  {baseUrl}/api/org/v1/search \
  -H 'Authorization: Bearer {api-key}' \
  -H 'Content-Type: application/json' \
  -d '{
    "params": {},
    "request": {
        "filters": {
            "isRootOrg": true, // this will provide all rootOrg only
            "status": "1"    // all rootOrg with active status
        },
        "fields": [
            "id",
            "orgName",
            "channel"
        ]
    }
}'

For more details refer api doc: http://docs.sunbird.org/latest/apis/orgapi/#operation/Organisation%20Search
```

&#x20;   &#x20;

#### 2. Against the root org, identify a set of reserved keys from enc-service.

The enc-service doesn't have an API to add/delete keys. The keys are pre-generated and the service is capable to add keys, on demand basis. This is by service design and one has to peep into the table for getting the keys. The implementation team selects keys in some orderly fashion and assigns it to the root org. I propose to maintain a table like this for internal references and prevent accidental re-use of keys.

| rootOrgId | rootOrgName | key identifiers | comments | added by |
| --------- | ----------- | --------------- | -------- | -------- |
|           |             |                 |          |          |

Refer to details here - \[\[Sunbird enc-service|Sunbird-enc-service]]

#### 3. Call assign key api for root org with the keys identified in step 2.

```js
curl -X PATCH \
  {BaseUrl}/api/org/v1/assign/key \
  -H 'Authorization: {{api_key}}' \
  -H 'Content-Type: application/json' \
  -H 'X-Authenticated-User-Token: {{token}}' \
  -H 'cache-control: no-cache' \
  -d '{
    "request": {
        "id": "01268765289340108820120",
        "signKeys": [
            "demo1",
            "demo2"
        ],
        "encKeys": [
            "demo3",
            "demo4"
        ]
    }
}'

Api to get X-Authenticated-User-Token

curl -X POST \
  {baseUrl}/auth/realms/{realmName}/protocol/openid-connect/token \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'cache-control: no-cache' \
  -d 'client_id={clientName}&username={userName}&password={password}&grant_type=password'


ref: Ecreds - Phase3 and SB rollout
```

#### 4. Identify the course and batch id to which we are interested to issue certificates.

#### 5. Get the HTML template zip from ticket - TBD and upload it the eCreds container (owned by cert-service). This html zip has some signature images that is good to keep as private/confidential.

#### 6. Attach details to a course/batch metadata.

```bash
curl -X PATCH \
  https://staging.ntp.net.in/action/system/v3/content/update/{{courseID}} \
  -H 'Accept: */*' \
  -H 'Accept-Encoding: gzip, deflate' \
  -H 'Cache-Control: no-cache' \
  -H 'Connection: keep-alive' \
  -H 'Content-Length: 17916' \
  -H 'Content-Type: application/json' \
  -H 'Cookie: PLAY_FLASH=channel=ORG_001&source=&actorId=X-Consumer-ID&did=X-Device-ID&actorType=consumer&requestId=8e27cbf5-e299-43b0-bca7-8347f7e5abcf&signupType=' \
  -H 'Host: localhost:8080' \
  -H 'Postman-Token: 1f19dd7b-3c7c-4c62-8824-7291c53f70f8,ee3d70fd-b077-4824-bbb1-9f29194c4d47' \
  -H 'User-Agent: PostmanRuntime/7.15.2' \
  -H 'cache-control: no-cache' \
  -H 'x-authenticated-user-token: {{authToken}}' \
  -d '{
    "request": {
        "content": {
        	"certVideoUrl": "https://sunbirddev.blob.core.windows.net/sunbird-content-dev/content/assets/do_112831862871203840114/small.mp4",
            "certTemplate": [{
            	"name": "100PercentCompletionCertificate",
                "issuer": {
                    "name": "Gujarat Council of Educational Research and Training",
                    "url": "https://gcert.gujarat.gov.in/gcert/",
                    "publicKey": ["1", "2"]
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
                	"id": "5768"
                },
                "htmlTemplate": "http://sunbirddev.blob.core.windows.net/dev-e-credentials/v1/certificate.zip",
                "notifyTemplate": {
                	"subject": "Course completion certificate",
        			"stateImgUrl": "https://sunbirddev.blob.core.windows.net/orgemailtemplate/img/File-0128212938260643843.png",
                	"regardsperson": "Chairperson",
        			"regards": "Minister of Gujarat",
        			"emailTemplateType": "defaultCertTemp"
                }
            }]
        }
    }
}
```

**Note:** For release-2.3.5 the name of the certificate should be **"100PercentCompletionCertificate"**

#### 7. Invoke /issue API

```bash
curl -X POST \
  https://staging.ntp.net.in/api/course/batch/cert/v1/issue \
  -H 'Authorization: Bearer {{api-key}}' \
  -H 'Content-Type: application/json' \
  -H 'Postman-Token: 6e277f2e-bbbb-4d56-b744-157421383078' \
  -H 'X-authenticated-user-token: {{authToken}}' \
  -H 'cache-control: no-cache' \
  -d '{
    "request": {
        "batchId": "{{batchId}}", 
        "courseId": "{{courseId}}", 
        "certificate": "100PercentCompletionCertificate",
        "filters": {
            "status" : "2"
        }
    }
}'
```

***

\[\[category.storage-team]] \[\[category.confluence]]
