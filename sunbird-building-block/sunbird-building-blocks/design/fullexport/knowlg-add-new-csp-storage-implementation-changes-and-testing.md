# Knowlg---Add-New-CSP-Storage---Implementation-Changes-&-Testing

### Background

This document details the integration points for any new CSP provider with the Sunbird-Knowledge platform. (Latest as of December 2022. Sunbird-Knowlg release-5.2.0)

![](../../../../Design/FullExport/images/storage)

* In the above diagram, Knowlg components marked in yellow colour shows its connections with cloud storage and marked in orange colour shows it’s connections with cloud media service (used to generate video streaming).
* Knowlg has verified with Azure, AWS and GCP(GCP MediaService integration is pending).
* Knowlg has below flink jobs which interact with cloud storage for upload/download operation:
  * asset-enrichment
  * content-publish
  * qrcode-image-generator
  * live-node-publisher
* knowlg-api-service transforms cloud related metadata (e.g: downloadUrl, appIcon, etc) but doesn't interact with cloud storage.
  * e.g: the service convert cloud specific path (absolute path) to cloud neutral path (relative path) and vice versa.
* In order to add support for any other cloud storage (e.g: OCI) under Knowlg components, below steps need to be followed:

### knowlg-api-service:

#### Git Repos:

[https://github.com/project-sunbird/knowledge-platform](https://github.com/project-sunbird/knowledge-platform)

[https://github.com/project-sunbird/sunbird-learning-platform](https://github.com/project-sunbird/sunbird-learning-platform)

**Latest branch** : release-5.2.0

* The Service need only configuration change to maintain relative path in database while write operation and return the absolute path for cloud related metadata while read operation.

**Config Changes:**

* Override value for below variables under private devops repo (file path: **ansible/inventory/\<env\_name>/Core/common.yml** ) for new storage account:

cloud\_storage\_content\_bucketnamecloudstorage\_replace\_absolute\_pathcloudstorage\_relative\_path\_prefixcloudstorage\_base\_pathvalid\_cloudstorage\_base\_urls

Configuration File Reference:

[https://github.com/project-sunbird/sunbird-devops/blob/b61a35fad0362ea7eb0bb688ff0bc12ffc811571/ansible/roles/stack-sunbird/templates/content-service\_application.conf#L484](https://github.com/project-sunbird/sunbird-devops/blob/b61a35fad0362ea7eb0bb688ff0bc12ffc811571/ansible/roles/stack-sunbird/templates/content-service\_application.conf#L484)

**Deployment:**

* After Configuration Change, Deploy the content and taxonomy service.

#### Testing:

* Test Content Create & Read API with some metadata having cloud path (e.g: appIcon)

The key integration points present at the below files

Knowledge-Platform repo:

[StorageService.scala](https://github.com/project-sunbird/knowledge-platform/blob/release-5.2.0/platform-modules/mimetype-manager/src/main/scala/org/sunbird/cloudstore/StorageService.scala) → Integration points of collecting to org.sunbird.cloud.storage library. This SunbirdCloudStage SDK has to support for new CSP providers.

Sunbird cloud-storage-sdk version upgrade location. Knowlg is using the 1.4.3 version.

[https://github.com/project-sunbird/knowledge-platform/blob/release-5.2.0/platform-modules/mimetype-manager/pom.xml](https://github.com/project-sunbird/knowledge-platform/blob/release-5.2.0/platform-modules/mimetype-manager/pom.xml)

```
 <dependency>
      <groupId>org.sunbird</groupId>
      <artifactId>cloud-store-sdk</artifactId>
      <version>1.4.3</version>
  </dependency>
```

**flink jobs:**

#### Git Repo:

[https://github.com/project-sunbird/knowledge-platform-jobs](https://github.com/project-sunbird/knowledge-platform-jobs)

#### **Code Changes:**

* Flink jobs uses **cloud-storage-sdk** for cloud storage operations. So first the sdk need a code change to have support for new cloud storage provider (e.g: OCI).
* Sunbird cloud-storage-sdk is a utility which provides methods for cloud upload/download operations.
* Link to cloud-storage-sdk git repo: [https://github.com/project-sunbird/sunbird-cloud-storage-sdk/tree/scala-2.12-with-latest](https://github.com/project-sunbird/sunbird-cloud-storage-sdk/tree/scala-2.12-with-latest)
* Once the cloud-storage-sdk new version is published in maven central, we need to update the version in jobs-core module [https://github.com/project-sunbird/knowledge-platform-jobs/blob/e576a50834529c9984ca1cb5012f8ca0c59a5a29/jobs-core/pom.xml#L84](https://github.com/project-sunbird/knowledge-platform-jobs/blob/e576a50834529c9984ca1cb5012f8ca0c59a5a29/jobs-core/pom.xml#L84)
* Knowlg flink jobs are using the cloud-storage-sdk version 1.4.3

**Configuration Changes:**

* Override value for below variables under private devops repo (file path: **ansible/inventory/\<env\_name>/Knowledge-Platform/common.yml** ) for new storage account:

| **Variable Name**                             | **Description**                                                                                                                                     | **Example Value**                                                                                                                                                                                                                                                                                   |
| --------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| cloud\_public\_storage\_accountname           | unique key to identify the storage account                                                                                                          | sunbirddevbbpublic                                                                                                                                                                                                                                                                                  |
| cloud\_public\_storage\_endpoint              | endpoint of a cloud storage account.                                                                                                                | ““                                                                                                                                                                                                                                                                                                  |
| cloud\_public\_storage\_secret                | secret key to access the storage account.                                                                                                           | NA                                                                                                                                                                                                                                                                                                  |
| cloud\_service\_provider                      | storage provider name                                                                                                                               | azure                                                                                                                                                                                                                                                                                               |
| cloud\_storage\_content\_bucketname           | bucket/container name where data will be stored or read from.                                                                                       | sunbird-content-dev                                                                                                                                                                                                                                                                                 |
| cloud\_storage\_dial\_bucketname              | bucket/container name where dial data will be stored or read from.                                                                                  | dial                                                                                                                                                                                                                                                                                                |
| cloudstorage\_base\_path                      | this variable will have either CNAME or base url of cloud storage account                                                                           | "https://sunbirddevbbpublic.blob.core.windows.net"                                                                                                                                                                                                                                                  |
| cloudstorage\_relative\_path\_prefix\_content | this variable will have string value which will replace cloud storage base path & bucket name                                                       | "CONTENT\_STORAGE\_BASE\_PATH"                                                                                                                                                                                                                                                                      |
| cloudstorage\_relative\_path\_prefix\_dial    | this variable will have string value which will replace cloud storage base path & bucket name                                                       | "DIAL\_STORAGE\_BASE\_PATH"                                                                                                                                                                                                                                                                         |
| cloudstorage\_replace\_absolute\_path         | This flag is used to enable or disable the cloud-agnostic data feature.                                                                             | false                                                                                                                                                                                                                                                                                               |
| cloudstorage.metadata.list                    | this variable will have list of metadata which has cloud storage url                                                                                | '\["appIcon", "artifactUrl", "posterImage", "previewUrl", "thumbnail", "assetsMap", "certTemplate", "itemSetPreviewUrl", "grayScaleAppIcon", "sourceURL", "variants", "downloadUrl", "streamingUrl", "toc\_url", "data", "question", "solutions", "editorState", "media", "pdfUrl", "transcripts"]' |
| valid\_cloudstorage\_base\_urls               | This variable will have a list of urls that should be replaced by the CONTENT\_STORAGE\_BASE\_PATH string if the cloud-agnostic feature is enabled. | \["https://sunbirddevbbpublic.blob.core.windows.net"]                                                                                                                                                                                                                                               |

*   Configuration File Reference:

    [https://github.com/project-sunbird/sunbird-learning-platform/blob/59a59270b5419153b902b3d68165a8b5539f872e/kubernetes/helm\_charts/datapipeline\_jobs/values.j2#L731](https://github.com/project-sunbird/sunbird-learning-platform/blob/59a59270b5419153b902b3d68165a8b5539f872e/kubernetes/helm\_charts/datapipeline\_jobs/values.j2#L731)

    [https://github.com/project-sunbird/sunbird-learning-platform/blob/59a59270b5419153b902b3d68165a8b5539f872e/kubernetes/helm\_charts/datapipeline\_jobs/values.j2#L736](https://github.com/project-sunbird/sunbird-learning-platform/blob/59a59270b5419153b902b3d68165a8b5539f872e/kubernetes/helm\_charts/datapipeline\_jobs/values.j2#L736)

**Deployment:**

* Build & Deploy both Job

**Testing:**

* Test Content/Collection Publish Workflow.
  * Content/Collection should be published successfully.
  * metadata having cloud storage file reference should be accessible.
  * e.g: downloadUrl pointing to a file, should be downloadable.

### Media service integration (video-streaming)

#### Git Repo:

[https://github.com/project-sunbird/knowledge-platform-jobs/tree/master/video-stream-generator](https://github.com/project-sunbird/knowledge-platform-jobs/tree/master/video-stream-generator)

* To generate video streaming we have video-streaming-generator flink job.
* Flink job uses the interface [IMediaService](https://github.com/project-sunbird/knowledge-platform-jobs/blob/release-5.2.0/video-stream-generator/src/main/scala/org/sunbird/job/videostream/service/IMediaService.scala) and corresponding cloud media service implementation.
* Currently this job is having the implementation for azure media service and AWS elemental media convert. Similarly other service provide can be also implemented.
* To implement new service provider, implement the [IMediaService](https://github.com/project-sunbird/knowledge-platform-jobs/blob/release-5.2.0/video-stream-generator/src/main/scala/org/sunbird/job/videostream/service/IMediaService.scala) for the respective service provider then override the submitJob, getJob and getStreamingPaths
* Add the respective config in [here](https://github.com/project-sunbird/sunbird-learning-platform/blob/3c4dd2bb4d0a73c21844899d97c459ab7f160345/kubernetes/helm\_charts/datapipeline\_jobs/values.j2#L169).

***

\[\[category.storage-team]] \[\[category.confluence]]
