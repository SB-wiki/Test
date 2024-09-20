
## release-3.3.0
This page contains portal changes happened from 3.2.0


* Blob Creation for dynamic UI Labels

    Story: [https://project-sunbird.atlassian.net/browse/SH-771](https://project-sunbird.atlassian.net/browse/SH-771)

    Steps:

    - Create a  **private** azure storage container under the storage account under noted in below variable in your ansible private variable file(common.yaml).


```
{{sunbird_private_storage_account_name}}
```

    * container name:  **label** 


    * upload the attached file  **all_labels_en.json** in  **label** container



    

[https://github.com/DIKSHA-NCTE/ntp-devops/tree/release-3.3.0/utils/portal/labels](https://github.com/DIKSHA-NCTE/ntp-devops/tree/release-3.3.0/utils/portal/labels)

all the files to be uploaded in the blob is available in the repo mentioned above.



*****

[[category.storage-team]] 
[[category.confluence]] 
