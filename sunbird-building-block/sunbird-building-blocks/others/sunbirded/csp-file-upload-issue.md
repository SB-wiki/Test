
## Problem Statement


To upload a file using content editor we are passing STATIC HEADERS for blob upload along with the pre-signed URL which is based on every other CSP,  there are multiple  headers which we are passing from client side (i.e Angular App).

Note: as of now we are only using Azure storage where we are sending the additional headers


## Current file upload implementation
1. Create an Asset 


```
URL : action/asset/v1/create

{
    request : {
    "asset": {
        "primaryCategory": "asset",
        "language": [
            "English"
        ],
        "code": "org.ekstep0.5375271337424472",
        "name": "sample.pdf",
        "mediaType": "pdf",
        "mimeType": "application/pdf",
        "createdBy": "56c84dee-7149-47af-902d-0138e080cec0",
        "creator": "globe1 ",
        "channel": "sunbird"
    }
  }
}

Response: 
 "result": {
        "identifier": "do_21385297612840140813763",
        "node_id": "do_21385297612840140813763",
        "versionKey": "1691037125056"
    }

```

1. Generate Pre-signed Url: 


```
URL: action/content/v4/upload/url/do_21385297612840140813763
{
  "request" :
    {
    "content": {
        "fileName": "sample.pdf"
    }
  }
}

Respose:
"result": {
        "identifier": "do_21385297612840140813763",
        "url_expiry": "54000",
        "pre_signed_url": "https://stagingdock.blob.core.windows.net/sunbird-content-dock/content/assets/do_21385297612840140813763/sample.pdf?sv=2017-04-17&se=2023-08-03T19%3A32%3A05Z&sr=b&sp=w&sig=8wDkcisgO9Q6hlmzzb4gc%2BKyMkW1n/kPHLhBjh0tPEg%3D"
    }
```





1. Uploading files

    


```
URL: https://stagingdock.blob.core.windows.net/sunbird-content-dock/content/assets/do_21385297612840140813763/sample.pdf?sv=2017-04-17&se=2023-08-03T19%3A32%3A05Z&sr=b&sp=w&sig=8wDkcisgO9Q6hlmzzb4gc%2BKyMkW1n/kPHLhBjh0tPEg%3D
Request Method: PUT
Request Headers:
Accept: application/json, text/plain, */*,
Content-Type:application/pdf,
X-Ms-Blob-Type: BlockBlob

Payload is the filestream
```


X-Ms-Blob-Type: BlockBlob  this header is getting passed if cloud storage is azure and currently it is hard-coded in the portal angular code


```
addCloudStorageProviderHeaders() {
    let presignedHeaders: any = {};
    switch (this.cloudStorageProvider.toLowerCase()) {
      case 'azure':
        presignedHeaders = {
          'x-ms-blob-type': 'BlockBlob' // This header is specific to azure storage provider.
        };
        break;
      case 'aws':
        break;
      case 'gcloud':
        break;
    }
    return presignedHeaders;
  }
```



## Solutions Proposed



1.  **We get the headers as the part of generating the preSigned URL Only** , so the headers get dynamic and all the building blocks need to take those headers from the api call only, no other config level changes we need to make, below is the method for generating preSignedUrl

    

    The API action/content/v4/upload/url  which is used to get the signed URL, should send the headers is response.

    


```
URL: action/content/v4/upload/url/do_21385297612840140813763
{
  "request" :
    {
    "content": {
        "fileName": "sample.pdf"
    }
  }
}

Respose1:
"result1": {
        "identifier": "do_21385297612840140813763",
        "url_expiry": "54000",
        "pre_signed_url": "https://stagingdock.blob.core.windows.net/sunbird-content-dock/content/assets/do_21385297612840140813763/sample.pdf?sv=2017-04-17&se=2023-08-03T19%3A32%3A05Z&sr=b&sp=w&sig=8wDkcisgO9Q6hlmzzb4gc%2BKyMkW1n/kPHLhBjh0tPEg%3D"
        "cspheaders":{
          'x-ms-blob-type': 'BlockBlob'
        }
    }
    
Response 2: in case of video
    
    "result2": {
        "identifier": "do_21385297612840140813763",
        "url_expiry": "54000",
        "pre_signed_url": "https://stagingdock.blob.core.windows.net/sunbird-content-dock/content/assets/do_21385297612840140813763/sample.pdf?sv=2017-04-17&se=2023-08-03T19%3A32%3A05Z&sr=b&sp=w&sig=8wDkcisgO9Q6hlmzzb4gc%2BKyMkW1n/kPHLhBjh0tPEg%3D"
        "cspheaders":{
         'x-ms-blob-content-type': 'video/mp4',
         'x-ms-blob-type': 'BlockBlob'
        }
    }
```





    1. Pros:


    1. faster and not require much changes and can be taken within the timelines


    1. only one block need to make the change and other’s can consume directly 



    
    1. Cons: 


    1. can the API know which CSP provider we are referring to and what headers we need as API response 





    

    
1.  **We add a method in CSP SDK** 


    1. We need to create a method in CSP SDK for every CSP to return static headers

    


```

Methods in SDK

getCSPHeader(){
  return header = {
    'x-ms-blob-type': 'BlockBlob'
  }
}

This function we need to add for every could service provider file in cloud SDK

```



    1. Portal Backend (i.e program service in case of coKreat) needed to expose a new API to access SDK methods 


    1. Client will make a new API call to backed to get the headers before initializing the editors 

    


```
URL: content/program/v1/getCSPHeaders
```

    1. Pros

    generic and elaborated approach


    1. Cons:

    we need to make a lot of changes including SDK, Backend and Frontend.



    

    







*****

[[category.storage-team]] 
[[category.confluence]] 
