Problem StatementQR code image generation POC is done in Java using Zxing library.

Design a way to expose this usecase for consumption.

Approach 1Package the code as a executable jar

Input - Predetermined set of parameters in a String array

Output - Generated image in a pre-determined path in local node



| Pros | Cons | 
|  --- |  --- | 
| <ul><li>Minimal effort to implement</li><li>Existing capability built in content service, to cache images,  upload to cloud and expose it as API, can be re-used</li></ul> | <ul><li>Not a generic solution. Dependency on content service</li></ul> | 

Approach 2Expose the usecase to consumers directly through an API in Learning Service



| Pros | Cons | 
|  --- |  --- | 
| <ul><li>Generic Solution. All consumers can directly consume the API to generate the QR code images</li></ul> | <ul><li>To avoid generation of same code multiple times, capabilities such as caching images and upload to cloud has to be built from scratch</li></ul> | 

Approach 3The API currently exposed in content service for QR code image generation can consume this API to generate the QR code image.



| Pros | Cons | 
|  --- |  --- | 
| <ul><li>The capabilities built in content service API to cache images and upload to cloud can be re-used</li></ul> | <ul><li>Extra API call to service the image generation request</li></ul> | 



Open Questions:
1. Should the design support multiple QR code image generation per request?
1. In case of API, what should be the response? Image itself or the public url of the image uploaded in the cloud
1. Should the design support capabilities like caching images and upload to cloud?



*****

[[category.storage-team]] 
[[category.confluence]] 
