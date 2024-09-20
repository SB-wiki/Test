# Print-Service-APIs

_The latest version is_ : v1.0

The Print-service is the primary way to generate PDF from HTML. All of our SDKs and products interact with the print-service in a some way, so understanding how the Print-Service APIs works is crucial.

If you are unfamiliar with the Print-Service, we recommend that you start with these documents:

\| [**Overview** ](https://project-sunbird.atlassian.net/wiki/spaces/UM/pages/1284997145/Print-Servicehttps:/project-sunbird.atlassian.net/wiki/spaces/UM/pages/1284997145/Print-Service)Learn how the Print-Service is structured, and how versions work.[ **Reference** ](https://blog.risingstack.com/pdf-from-html-node-js-puppeteer/)Learn how to read our reference documents so you can easily find what you're looking for. | [**Cert-Service** ](https://project-sunbird.atlassian.net/wiki/spaces/UM/pages/1100414991/Credentials+for+everyone)Learn about the motivation & usage of the print-service. |

Assuming your familiarity with the Print-Service, you can now move to the APIs usage:

## Using the Print-Service API

This document goes into detail about the various operations you can perform with the Print-Service API.

### Host URL

Almost all requests are passed to the dev.sunbirded.org host URL. This service is single exception which use http://print-service:5000 since the service APIs are not onboarded for public user.

### PDF Generate

Due to privacy restrictions, you are only able to get a downloadable url for short period of time, however [refer](https://project-sunbird.atlassian.net/wiki/spaces/UM/pages/1100414991/Credentials+for+everyone#Credentialsforeveryone-/download-GetsasignedURLtothecertificate) download API using which you can regenerate the download url.

**Edges**

* POST /v1/print/pdf where content/type will be _application/json_ .

**Authorization**

* User Bearer authorization key not required, since this is a private container to container call.

**Examples**

Send a POST /v1/print/pdf request, where&#x20;

a) htmlTemplate it’s a mandatory attribute, which is a zip url of the HTML template, which should contains the index.html and may also contains css & images folder for applying styles in index.html.

b) storageParams it’s a optional param, which is a map which has keys:

* path which will have the value of the path, inside which pdf file needs to be stored inside container, followed by the /. if not provided default path value will be taken.
* containerName it’s the name of container in which pdf files needs to be stored, if not provided default container will be chosen to store.

c) context is the map which will have placeholders and their value (ex: $recipientName : John Deo)

d) ttl in response is Time To Live after certain period of the time download link will be expire, refer [this](https://project-sunbird.atlassian.net/wiki/spaces/UM/pages/1100414991/Credentials+for+everyone#Credentialsforeveryone-/download-GetsasignedURLtothecertificate) to re-download.

e) pdfUrl in response will be the downloadable link.

Sample Request

```json
curl --request POST 'http://print-service:5000/v1/print/pdf' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json' \
--data-raw '{
    "request": {
    	"context":{
    		"recipientName":"John Deo"
    	},
        "htmlTemplate": "https://sunbirddev.blob.core.windows.net/user/cert/File-012976173013442560353.zip",
        "storageParams":{
        	"path":"pathToFolder/",
        	"containerName":"blobContainerName"
        }
    }
}
'
```

Sample Response

```json
{
    "id": "api.print.preview.generate",
    "ver": "1.0",
    "ts": 1584511707925,
    "params": {},
    "responseCode": "OK",
    "result": {
        "pdfUrl": "https://sunbirddev.blob.core.windows.net/{{containerName}}/{{path}}/e0f06220-68de-11ea-bdf1-736d5e9612fb.pdf",
        "ttl": 600
    }
}
```

**Docs**

\*\*Note: \*\* htmlTemplate should have the index.html file else PDF generation will be failed. PDF generation will be faster if same template is been provided every time for generation multiple certificates.

### PDF Preview

This API will give you the PDF URL converted from HTML URL.

**Edges**

* POST /v1/print/preview/generate where content/type will be _application/json_ .

**Authorization**

* User Bearer authorization key not required, since this is a private container to container call.

**Examples**

Send a POST /v1/print/preview/generate request, where accept 1 query param named

a) fileUrl it’s a mandatory attribute, whose value is a public URL.

b) ttl is Time To Live after certain period of the time download link will be expire. you need to re-generate the pdf.

c) pdfUrl will be the downloadable link.

Sample Request

```json
curl --location --request POST 'http://print-service:5000/v1/print/preview/generate?fileUrl=https://example.com' \
--header 'Content-Type: application/json'
```

Sample Response

```json
{
    "id": "api.print.preview.generate",
    "ver": "1.0",
    "ts": 1584511707925,
    "params": {},
    "responseCode": "OK",
    "result": {
        "pdfUrl": "https://sunbirddev.blob.core.windows.net/{{containerName}}/{{path}}/e0f06220-68de-11ea-bdf1-736d5e9612fb.pdf",
        "ttl": 600
    }
}
```

\*\*Note: \*\* ttl value is configurable from the service side.

### Health

This API will only check whether the service is up and running along with the components

**Edges**

* GET /health where content/type will be _application/json_ .

**Authorization**

* User Bearer authorization key not required, since this is a private container to container call.

**Examples**

Send a GET /health request, where&#x20;

Sample Request

```json
curl --location --request GET 'http://print-service:5000/health' \
--header 'Content-Type: application/json'
```

Sample Response

```json
{
    "id": "api.health",
    "ver": "1.0",
    "ts": 1584538562454,
    "params": {},
    "responseCode": "OK",
    "result": {}
}
```

***

\[\[category.storage-team]] \[\[category.confluence]]
