 **Configuration Added:** 


* Please check the configuration files and add below configuration.


* For variable information, Please refer to Variable Section.



 **assessment-service:** 


```
cloud_storage_container: "{{ cloud_storage_content_bucketname }}"

cloudstorage {
  metadata.replace_absolute_path={{ cloudstorage_replace_absolute_path | default('false') }}
  metadata.list={{ cloudstorage_metadata_list }}
  relative_path_prefix="{{ cloudstorage_relative_path_prefix | default('CLOUD_STORAGE_BASE_PATH') }}"
  read_base_path="{{ cloudstorage_base_path }}"
  write_base_path={{ valid_cloudstorage_base_urls }}
}
```
Configuration File Link For Reference: 

[https://github.com/project-sunbird/sunbird-devops/blob/release-5.2.0-inquiry_RC1/ansible/roles/stack-sunbird/templates/assessment-service_application.conf](https://github.com/project-sunbird/sunbird-devops/blob/release-5.2.0-inquiry_RC1/ansible/roles/stack-sunbird/templates/assessment-service_application.conf)



 **async-questionset-publish:** 


```
#Cloud Storage Config
    cloud_storage_type: "{{ cloud_service_provider }}"
    cloud_storage_key: "{{ cloud_public_storage_accountname }}"
    cloud_storage_secret: "{{ cloud_public_storage_secret }}"
    cloud_storage_endpoint: "{{ cloud_public_storage_endpoint }}"
    cloud_storage_container: "{{ cloud_storage_content_bucketname }}"
    cloudstorage {
      metadata.replace_absolute_path={{ cloudstorage_replace_absolute_path | default('false') }}
      metadata.list={{ cloudstorage_metadata_list }}
      relative_path_prefix="{{ cloudstorage_relative_path_prefix }}"
      read_base_path="{{ cloudstorage_base_path }}"
      write_base_path={{ valid_cloudstorage_base_urls }}
    }
```
Configuration File Link For Reference: 

[https://github.com/Sunbird-inQuiry/data-pipeline/blob/58d52be036712eff2e90a3842a1885d36d4473a7/kubernetes/helm_charts/datapipeline_jobs/values.j2#L118](https://github.com/Sunbird-inQuiry/data-pipeline/blob/58d52be036712eff2e90a3842a1885d36d4473a7/kubernetes/helm_charts/datapipeline_jobs/values.j2#L118)

 **questionset-republish:** 


```
#Cloud Storage Config
    cloud_storage_type: "{{ cloud_service_provider }}"
    cloud_storage_key: "{{ cloud_public_storage_accountname }}"
    cloud_storage_secret: "{{ cloud_public_storage_secret }}"
    cloud_storage_endpoint: "{{ cloud_public_storage_endpoint }}"
    cloud_storage_container: "{{ cloud_storage_content_bucketname }}"
    cloudstorage {
      metadata.replace_absolute_path={{ cloudstorage_replace_absolute_path | default('false') }}
      metadata.list={{ cloudstorage_metadata_list }}
      relative_path_prefix="{{ cloudstorage_relative_path_prefix }}"
      read_base_path="{{ cloudstorage_base_path }}"
      write_base_path={{ valid_cloudstorage_base_urls }}
    }
```
Configuration File Link For Reference: 

[https://github.com/Sunbird-inQuiry/data-pipeline/blob/58d52be036712eff2e90a3842a1885d36d4473a7/kubernetes/helm_charts/datapipeline_jobs/values.j2#L164](https://github.com/Sunbird-inQuiry/data-pipeline/blob/58d52be036712eff2e90a3842a1885d36d4473a7/kubernetes/helm_charts/datapipeline_jobs/values.j2#L164)



Deprecated variables:
* sunbird_cloud_storage_type


* sunbird_public_storage_account_name


* sunbird_public_storage_account_key


* azure_public_container


* sunbird_content_azure_storage_container


* 



 **Variables Added:** 


* Below table has all variables and its default values present in the configuration file. Please override them with  **values**  as per the environment.

    





|  **variable name**  |  **description**  |  **Default Value Given in the Configuration File**  |  **service/job name which uses variable**  | 
|  --- |  --- |  --- |  --- | 
| cloudstorage_replace_absolute_path | Boolean value is required to enable/disable cloud storage agnostic urls in db. | false | assessment, async-questionset-publish, questionset-republish | 
| cloudstorage_relative_path_prefix | String value is required. This value will be used as prefix for any metadata which holds cloud storage path | CLOUD_STORAGE_BASE_PATH | assessment, async-questionset-publish, questionset-republish  | 
| cloudstorage_metadata_list | Array of String value is required. This array will have list of metadata keys which holds cloud storage path | \["appIcon","posterImage","artifactUrl","downloadUrl","variants","previewUrl","pdfUrl"] | assessment, async-questionset-publish, questionset-republish | 
| cloudstorage_base_path | String value is required. The value could be either cloud specific base path or cname configured for current cloud storage provider. | "https://sunbirddevbbpublic.blob.core.windows.net" | assessment, async-questionset-publish, questionset-republish | 
| valid_cloudstorage_base_urls | Array of String value is required. This array will have list of all cloud path which should be accepted by service.  | \["https://sunbirddevbbpublic.blob.core.windows.net"] | assessment, async-questionset-publish, questionset-republish | 
| cloud_service_provider | String value is required. e.g: azure | azure | async-questionset-publish, questionset-republish | 
| cloud_public_storage_accountname | String value is required.  | NA | async-questionset-publish, questionset-republish | 
| cloud_public_storage_secret | String value is required. | NA | async-questionset-publish, questionset-republish | 
| cloud_public_storage_endpoint | String value is required. It could be empty string | NA | async-questionset-publish, questionset-republish | 
| cloud_storage_content_bucketname | String value is required.  | NA | assessment, async-questionset-publish, questionset-republish | 
|  |  |  |  | 



 **Variables & Values For Sunbird-Ed:** 



|  **Variables**  |  **Value**  | 
|  --- |  --- | 
| cloudstorage_replace_absolute_path | true | 
| cloudstorage_relative_path_prefix | CONTENT_STORAGE_BASE_PATH | 
| valid_cloudstorage_base_urls | \["https://sunbirdstagingpublic.blob.core.windows.net"] | 
| cloudstorage_metadata_list | \["appIcon","posterImage","artifactUrl","downloadUrl","variants","previewUrl","pdfUrl"] | 
| cloudstorage_base_path | "https://sunbirdstagingpublic.blob.core.windows.net" | 
| cloud_service_provider |  | 
| cloud_public_storage_accountname |  | 
| cloud_public_storage_secret |  | 
| cloud_public_storage_endpoint |  | 
| cloud_storage_content_bucketname |  | 



*****

[[category.storage-team]] 
[[category.confluence]] 
