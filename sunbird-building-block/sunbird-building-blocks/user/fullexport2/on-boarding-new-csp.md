This page is draft - actual content is in - [https://project-sunbird.atlassian.net/l/cp/oc3Yg6of](https://project-sunbird.atlassian.net/l/cp/oc3Yg6of)

In Sunbird Lern, some of the components use the cloud support to consume and persistently store data. Also in some cases the data stored in Database or Elastic Search has cloud blob URLs.

SB Lern is cloud agnostic with the help of sunbird-cloud-storage-sdk, sunbird-analytics-service and sunbird-analytics-core repos in project-sunbird and Obsrv git space. Sunbird-cloud-storage-sdk, sunbird-analytics-service and sunbird-analytics-core supports some of most of the popular CSPs, including  _Amazon S3_ ,  _Azure Blob Storage and Google cloud_ .

[https://github.com/project-sunbird/sunbird-cloud-storage-sdk](https://github.com/project-sunbird/sunbird-cloud-storage-sdk)

[https://github.com/Sunbird-Obsrv/sunbird-analytics-core](https://github.com/Sunbird-Obsrv/sunbird-analytics-core)

[https://github.com/Sunbird-Obsrv/sunbird-analytics-service/](https://github.com/Sunbird-Obsrv/sunbird-analytics-service/)

 **Implementation changes to support new CSP** 

For onboarding new CSP, while using any of the above components, the listed configurations need to be updated. Currently sunbird-cloud-storage-sdk and sunbird-analytics-core supports only S3, AWS and GCloud. If any other CSP has to be onboarded, then changes have to be implemented to support new CSP in these libraries. 

New CSP support needs to be added here:

[https://github.com/Sunbird-Obsrv/sunbird-analytics-core](https://github.com/Sunbird-Obsrv/sunbird-analytics-core)

analytics-core/src/main/scala/org/ekstep/analytics/framework/util/DatasetUtil.scala

[https://github.com/Sunbird-Obsrv/sunbird-analytics-service/](https://github.com/Sunbird-Obsrv/sunbird-analytics-service/)

analytics-api-core/src/main/scala/org/ekstep/analytics/api/service/JobAPIService.scala

[https://github.com/project-sunbird/sunbird-cloud-storage-sdk](https://github.com/project-sunbird/sunbird-cloud-storage-sdk) src/main/scala/org/sunbird/cloud/storage/BaseStorageService.scala 

 **UserOrg Service (** [https://github.com/Sunbird-Lern/sunbird-lms-service](https://github.com/Sunbird-Lern/sunbird-lms-service) **):** 

Upgrade cloud-sdk version in core/platform-common/pom.xml


```
<dependency>
            <groupId>org.sunbird</groupId>
            <artifactId>cloud-store-sdk</artifactId>
            <version>1.4.3</version>
</dependency>            
```
 **Batch Service (** [https://github.com/Sunbird-Lern/sunbird-course-service](https://github.com/Sunbird-Lern/sunbird-course-service) **):** 

Upgrade cloud-sdk version in course-mw/sunbird-util/sunbird-platform-core/common-util/pom.xml


```
<dependency>
            <groupId>org.sunbird</groupId>
            <artifactId>cloud-store-sdk</artifactId>
            <version>1.4.3</version>
</dependency>
```
 **Cert-service (** [https://github.com/Sunbird-Lern/cert-service/](https://github.com/Sunbird-Lern/cert-service/) **)** 

Upgrade cloud-sdk version in core/platform-common/pom.xml


```
<dependency>
            <groupId>org.sunbird</groupId>
            <artifactId>cloud-store-sdk</artifactId>
            <version>1.4.3</version>
</dependency>
```
 **Data-products**  ([https://github.com/Sunbird-Lern/data-products](https://github.com/Sunbird-Lern/data-products))

lern-data-products/pom.xml


```
<dependency>
			<groupId>org.sunbird</groupId>
			<artifactId>analytics-job-driver</artifactId>
			<version>2.0</version>
			<scope>provided</scope>
			<exclusions>
				<exclusion>
					<groupId>commons-codec</groupId>
					<artifactId>commons-codec</artifactId>
				</exclusion>
			</exclusions>
</dependency>
<dependency>
			<groupId>org.sunbird</groupId>
			<artifactId>cloud-store-sdk_2.12</artifactId>
			<version>1.4.3</version>
</dependency>
```
lern-data-products/src/main/scala/org/sunbird/core/exhaust/BaseReportsJob.scala

Spark session creation has to be implemented in this file for new CSP.

lern-data-products/src/main/scala/org/sunbird/core/exhaust/OnDemandExhaustJob.scala

Blob container section for new CSP

lern-data-products/src/main/scala/org/sunbird/lms/job/report/BaseReportsJob.scala

Hadoop configurations for new CSP

lern-data-products/src/test/resources/application.conf

ansible/roles/lern-data-products-deploy/templates/common.conf.j2


```
cloud_storage_type="local"
cloud.container.reports="reports"
admin.reports.cloud.container="reports"
# Folder names within container
course.metrics.cloud.objectKey="src/test/resources/reports/"
admin.metrics.cloud.objectKey="src/test/resources/admin-user-reports/"
reports_storage_key="test"
reports_storage_secret="test"
# for only testing uploads to blob store
azure_storage_key=""
azure_storage_secret=""
```


 **Data-pipeline**  ([https://github.com/Sunbird-Lern/data-pipeline](https://github.com/Sunbird-Lern/data-pipeline) )

lms-jobs/credential-generator/certificate-processor/pom.xml

jobs-core/pom.xml


```
<dependency>
            <groupId>org.sunbird</groupId>
            <artifactId>cloud-store-sdk_2.12</artifactId>
            <version>1.4.3</version>
</dependency>
```
kubernetes/helm_charts/datapipeline_jobs/templates/flink_job_deployment.yaml

Flink job check pointing uses cloud storage

ansible/inventory/env/group_vars/all.yml


```
cert_container_name: "{{ cloud_storage_certservice_bucketname }}"
cert_cloud_storage_type: "{{cloud_service_provider}}"
cert_cloud_storage_secret: "{{cloud_private_storage_secret}}"
cert_cloud_storage_key: "{{cloud_private_storage_accountname}}"
cloud_storage_base_url: "{{cloud_storage_base_url}}"
checkpoint_store_type: "{{cloud_service_provider}}"
azure_cloud_account: "{{ cloud_public_storage_accountname }}"
azure_cloud_secret: "{{ cloud_public_storage_secret }}"
cloud_storage_flink_bucketname: "flink-check-points-store"
```
kubernetes/helm_charts/datapipeline_jobs/values.j2

Environment variables referring to CSP:


```
checkpoint_store_type: {{ checkpoint_store_type }}
azure_cloud_account: {{ azure_cloud_account }}
azure_cloud_secret: {{ azure_cloud_secret }}
s3_access_key: {{ s3_storage_key }}
s3_secret_key: {{ s3_storage_secret }}
s3_endpoint: {{ s3_storage_endpoint }}
s3_path_style_access: {{ s3_path_style_access }}
gcloud_client_key: {{ gcloud_client_key }}
gcloud_private_secret: {{ gcloud_private_secret }}
gcloud_project_id: {{ gcloud_project_id }}

statebackend .blob .storage {
            account = "{{ azure_cloud_account }}.blob.core.windows.net"
            container{{ cloud_storage_flink_bucketname }}

cert_container_name = "{{ cert_container_name }}"
    cert_cloud_storage_type = "{{ cert_cloud_storage_type }}"
    cert_cloud_storage_secret = "{{ cert_cloud_storage_secret }}"
    cert_cloud_storage_key = "{{ cert_cloud_storage_key }}"
    cloud_storage_base_url = "{{ cloud_storage_base_url }}"
```
lms-jobs/credential-generator/collection-certificate-generator/src/main/resources/collection-certificate-generator.conf


```
cloud_store_base_path = "https://sunbirddev.blob.core.windows.net"
```
lms-jobs/credential-generator/collection-cert-pre-processor/src/main/resources/collection-cert-pre-processor.conf


```
cloud_store_base_path = "https://sunbirddev.blob.core.windows.net"
```
 **Data Migrations to support new CSP** 

Below scripts can be used to update new CSP blob URL or CNAME URL in ES ad RC DB.

[[Training certificate migration|Training-certificate-migration]]

[[CSP Changes for Course Batch ES and RC ES|CSP-Changes-for-Course-Batch-ES-and-RC-ES]]

 **Environment Variables defind in devops private repo:** 


```
cloud_service_provider
cloud_public_storage_accountname
cloud_public_storage_secret
cloud_public_storage_endpoint
cloud_public_storage_region

cloud_private_storage_accountname
cloud_private_storage_secret
cloud_private_storage_endpoint
cloud_private_storage_region

cloud_storage_{datatype}_bucketname
cloud_storage_base_url
```


 **List of components which implements cloud support:** 



|  **Component Name**  |  **Service**  |  **Functionality**  |  **Configurations**  | 
|  --- |  --- |  --- |  --- | 
| User Org Service | sunbird-lms-service (learner) | File Upload API | sunbird_cloud_service_provider={{cloud_service_provider}}sunbird_account_name={{sunbird_public_storage_account_name}}sunbird_account_key={{sunbird_public_storage_account_key}} | 
| data-products ( OrgAdmin Reports ) | 
1. After generated, Org Consent Report and Geo Reports is saved to blob container.


1. Spark session is created using cloud.



 | cloud_storage_type= azure/aws/gcloud | 
| Batch Service | sunbird-course-service ( LMS) | 
1. Certificate template object that get assigned to course batch have many blob urls ike template, stateImgUrl, previewUrl, url etc. This data is  saved to ES and also to course_batch table in sunbird_courses keyspace in Cassandra.


1. Textbook upload and download APIs use cloud to store and retrieve the files.


1. QRCode list download API fetches a list of qr code image blob URLs from dialcode DB.



 | sunbird_cloud_service_provider={{cloud_service_provider}}sunbird_account_name={{sunbird_public_storage_account_name}}sunbird_account_key={{sunbird_public_storage_account_key}}cloud_storage_base_url | 
| data-pipeline | 
1. Certificate template cloud url store in DB as relative path should be resolved to actual url Before Sending the request to RC to generate certificate. 


1. Flink job checkpointing uses cloud storage.



 | cloud_storage_base_url | 
| data-products | 
1. Exhaust Reports - UserInfo, Progress and Response Exhausts is generated and uploaded to blob. The uploaded URL is stored in job_request table in analytics db in PostgreSQL


1. Spark session is created using cloud.



 | cloud_storage_type= azure/aws/gcloud | 
| cert-service | Old certificates are stored in cloud storage. Whenever user tries to download any specific certificate, cert-service is generating the signed URL and sends this in API response | CONTAINER_NAME={{cert_service_container_name}}CLOUD_STORAGE_TYPE={{cloud_service_provider}}PRIVATE_CLOUD_STORAGE_SECRET={{sunbird_private_storage_account_key}}PRIVATE_CLOUD_STORAGE_KEY={{sunbird_private_storage_account_name}}PUBLIC_CLOUD_STORAGE_KEY={{sunbird_public_storage_account_name}}PUBLIC_CLOUD_STORAGE_SECRET={{sunbird_public_storage_account_key}} | 
| RC | 
1. New certificate generation and download uses certificate template blob url. The certificate object stored in RC registry DB(postgres) has these template urls. Also the same data is stored to ES


1. Helm Charts uses blob to upload the RC schema and credential template and 



 | upstreamurl | 





*****

[[category.storage-team]] 
[[category.confluence]] 
