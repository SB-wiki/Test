# File-URL-Validation

### Introduction

This wiki explains the URL validate and get metadata API specification.

### Background

As part of upload file using Url link, there is requirement to validate the URL (youtube, google drive, azure and aws). Based on the provider of the URL we will validate the url link.

### Problem Statement

As part of above requirement we are going to provide two APIs:

* Validate URL
* Read URL metadata

### Validate URL API

**POST - asset/v3/validate?field=<** **license(youtube URL link) / size(google drive, others)>** **Request Header:** **Authorisation: //Authorisation keyContent-Type: application/json'** **Request Body**

| {      "request": {           "asset": {                "provider": "\<youtube/googledrive/other>",                "url": ""           }      } } |
| ------------------------------------------------------------------------------------------------------------------------------------------------- |

**Response Body**

| {      "id": "asset.url.validate",      "ver": "1.0",      "ts": "2019-01-11T06:33:04ZZ",      "params": {           "resmsgid": "33b18620-6114-4b40-b439-6587c030bdc5",           "msgid": null,           "err": null,           "status": null,           "errmsg": null      },      "responseCode": "OK",      "result": {           "": {                "value": "",                "valid": \<true/false>           }      } } |
| -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |

**Validation Logic:**

* Currently **youtube**  URL will be validated based on **license**  field
* Currently **google drive** **, azure** and  **AWS**  URL will be validated based on  **size**

### URL Metadata Read API

**POST - asset/v3/url/metadata/read** **Request Header:** **Authorisation: //Authorisation keyContent-Type: application/json'** **Request Body**

| {      "request": {           "asset": {                "provider": "\<youtube/googledrive/other>",                "url": ""           }      } } |
| ------------------------------------------------------------------------------------------------------------------------------------------------- |

**Response Body**

***

\[\[category.storage-team]] \[\[category.confluence]]
