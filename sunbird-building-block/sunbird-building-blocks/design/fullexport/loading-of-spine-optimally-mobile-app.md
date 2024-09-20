# Loading-of-spine-optimally-(mobile-app)

### Introduction

This wiki explains the downloading the light weighted spine ecar if available. And downloading of thumbnails when user visit the detail page then consider those downloaded thumbnail as a part of exported ecar. [SB-7105](https://project-sunbird.atlassian.net/browse/SB-7105)

### Background

Current version of spine ecar is bundled with manifest.json (details of the TextBook and its units) and folders for all the contents (holding the thumbnail images) and Menifest.json contains the relative path of all the thumbnails as appicon. Since all the thumbnail images are already present in the bundle, sometime (if hierarchy is big) ecar size is becoming huge which needs more bandwidth for downloading the ecar.&#x20;

### Problem Statement

Download the light weight ecar for any content which mymeType is 'application/vnd.ekstep.content-collection' and when user visits the content detail for any content inside that TextBook/Collection then download the appIcon to make it available locally and add that appIcon as part of ecar.

### Proposed Design

#### Downloading of light weighted spine ecar:

* Before downloading any content check the mymeType of that content. If the mymeType is application/vnd.ekstep.content-collection then check the available variants for that content .
* If variants **online** (light weight spine ecar) and **spine** (regular spine with thumbnail images) is available then download the light weight spine ecar.

#### Exporting of light weighted spine ecar (including the downloaded thumbnail images):

Solution 1:  **If appIcon is having image URL ("appIcon": "\<Azure/S3 path>/1db4c446ed0425fdd694cad0ca8e1c80\_1496381357005.thumb.jpeg")**

* When user explore the content then download the thumbnail image for that individual content in the existing content folder.
* After downloading the thumbnail image update the **appIcon**  (as light weighted ecar is having the image URL) value with the relative path.&#x20;
* Bundle the downloaded thumbnail image as a part of exported ecar for that TextBook/Collection.

Solution 2: If appIcon is having relative path ("appIcon": "do\_31268439334042828814811/1db4c446ed0425fdd694cad0ca8e1c80\_1496381357005.thumb.jpeg") and base URL for azure/s3.

* When user explore the content then download the thumbnail image for that individual content in the existing content folder.
* After downloading the thumbnail image no need to update the **appIcon**  (assuming relative path and base URL will be separately in content metadata).
* Bundle the downloaded thumbnail image as a part of exported ecar for that TextBook/Collection.

&#x20; &#x20;

***

\[\[category.storage-team]] \[\[category.confluence]]
