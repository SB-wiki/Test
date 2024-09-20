# Adoption-of-Sunbird-DIAL-Context

This document explains implementation/adoption of Sunbird DIAL context. Document details about 3 areas.

1.  How to extend the Sunbird DIAL Context Vocabulary?

    **Why -** Each sunbird adopter wants to update the specific information in the DIAL code context(JSON response of the DIAL code) on QR code scan. Hence any adopter can define the DIAL code context properties/vocabulary that should be present in the DIAL context(JSON response).

We will be detailing how an adopter can extend the Sunbird DIAL context vocabulary to define his specific context information.

1.  How to add/update the DIAL context by any micro-services(ex: content-service)?

    **Why -** Here we are considering the DIAL context is updating by content-service(Sunbird knowlg services). When the DIAL code is linked to any content/collection, the specific information has to be updated/stamped against the DIAL code by content-service.

    We will be detailing how the DIAL context information can be mapped/configured to micro-service(ex: content-service).
2.  How to update the context of existing DIAL codes?(data migration)

    **Why -** Migration of the existing DIAL code to update the context information against each DIAL codes present in the current system.

    We will be detailing how the existing DIAL codes can be updated with the context information.

Repositories:&#x20;

[https://github.com/project-sunbird/sunbird-dial-service/tree/release-5.0.0](https://github.com/project-sunbird/sunbird-dial-service/tree/release-5.0.0)

[https://github.com/project-sunbird/knowledge-platform-jobs/tree/release-5.0.0](https://github.com/project-sunbird/knowledge-platform-jobs/tree/release-5.0.0)

### 1. How to extend the Sunbird DIAL context?&#x20;

'jsonld-schema' folder is used to save context and json-ld (vocabulary) files. In order to extend the Sunbird DIAL Context vocabulary or to implement custom context:

1. Create ‘jsonld-schema’ folder in the private repository.
2. Create a new folder under 'jsonld-schema' folder (Ex: jsonld-schema/{ **adopter-name}** ).&#x20;
3. The {adopter-name} folder should contain a 'context.json' file which is the adopter’s custom context file.&#x20;
4. Specify the adopter folder name in **'jsonld.type'** attribute in 'application.conf' file for application to refer to a custom context.&#x20;
5. One can also define 'contextValidation.json' (optional) in the adopter folder, similar to the one in the ‘sb’ folder. This file will be referred to perform data type validation of the incoming requests. If defined, context data input validation will happen when DIAL code update **v2 API call** is made with 'contextInfo'.&#x20;
6. Custom ‘context.json’ should have a reference of the 'sb' vocabulary (schema.jsonld).
7. Upload the private repository ‘jsonld-schema’ folder to blob storage.
8. Update the ‘jsonld-schema’ folder path to the **‘jsonld.basePath’** property blob location.

### 2. How to add/update the DIAL context by any micro-services(ex: content-service)?

In order to ease the updation of DIAL context with content information when DIAL code is linked to a content/collection/collection unit, sunbird has updated ‘content-publish’ flink job to invoke the new [‘](https://knowlg.sunbird.org/learn/product-and-developer-guide/knowlg-jobs#dialcode-context-updater)[dialcode-context-updater’](https://knowlg.sunbird.org/learn/product-and-developer-guide/knowlg-jobs#dialcode-context-updaterhttps://knowlg.sunbird.org/learn/product-and-developer-guide/knowlg-jobs#dialcode-context-updater) flink job via ‘post-publish-processor’ flink job. ‘dialcode-context-updater’ flink job uses ‘contextMapping.json’ file to prepare the input data as per the DIAL code context configured in the Sunbird DIAL Service. ‘dialcode\_context\_updater.context\_map\_path’ property mentioned in the ‘dialcode-context-updater.conf’ is used to specify the path of ‘contextMapping.json’. (Ref: [https://raw.githubusercontent.com/project-sunbird/knowledge-platform-jobs/dialcode-context-updater/dialcode-context-updater/src/main/resources/contextMapping.json](https://raw.githubusercontent.com/project-sunbird/knowledge-platform-jobs/dialcode-context-updater/dialcode-context-updater/src/main/resources/contextMapping.json)). At the moment, [‘contextMapping.json’](https://github.com/project-sunbird/knowledge-platform-jobs/blob/release-5.0.0/dialcode-context-updater/src/main/resources/contextMapping.json) file packaged in Sunbird is in reference to the [‘sbed’ ‘context.json’](https://github.com/project-sunbird/sunbird-dial-service/blob/release-5.0.0/jsonld-schema/sbed/context.json) file.

### 3. How to update the context of existing DIAL codes?(Data Migration)?

In order to update content context information to the already linked DIAL codes, there are 2 solutions:

1. Re-publish the content/collections after deploying and configuring the ‘DIAL service’, ‘content-publish’, ‘post-publish-processor’ and ‘dialcode-context-updater’ flink jobs.
2. Push kafka events in below format to ‘dialcode-context-updater’ flink job input topic ( _**\{{env\_name\}}.dialcode.context.job.request**_ ).

Format: {"eid":"BE\_JOB\_REQUEST","ets": **$** epochTime,"mid":"LP. **$** epochTime. **$** {UUID. _randomUUID_ ()}","actor":{"id":"DIAL code context update Job","type":"System"},"context":{"pdata":{"ver":"1.0","id":"org.ekstep.platform"},"channel":" _**$channel**_ ","env":"dev"},"object":{"ver":"1.0","id":" _**$dialcode**_ "},"edata":{"action":" _**$action**_ ","iteration":1,"dialcode":" _**$dialcode**_ ","identifier": " _**$contentId**_ "},"identifier": " _**$contentId**_ "}

Note:  _**$contentId**_ is content/collection/collection unit identifier

_**$channel**_ should be the channel of the DIAL code and content.&#x20;

_**$dialcode**_ is the DIAL code to which content context is to be updated.

_**$action**_ is either ‘dialcode-context-update‘ or ‘dialcode-context-delete’.

Please note that DIAL Context module implementation requires NGIX side API onboarding. Please refer to ticket [SB-29005 System JIRA](https://browse/SB-29005)

```
curl --location --request GET 'https://dev.sunbirded.org/dial/U3W2X2' \
--header 'Accept: application/ld+json'
```

***

\[\[category.storage-team]] \[\[category.confluence]]
