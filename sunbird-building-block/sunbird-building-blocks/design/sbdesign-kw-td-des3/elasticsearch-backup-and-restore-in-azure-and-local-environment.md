
## Azure Environment:

### Backup: 

1.  **Create Azure Storage Account and Blob Container:** 


    * Log in to the Azure portal and navigate to the Storage Accounts service. Create a new storage account or use an existing one.


    * Within the storage account, create a blob container named es-backup or a name of your choice.


    * Note down the Azure storage account name and access key to use in configuring the Elasticsearch snapshot repository.



    
1.  **Install The azure-repository Plugin ﻿:** 

    There are various methods to install Elasticsearch plugins. For our setup, we've chosen to add the plugin installation as an initialisation script within the Elasticsearch Helm chart.



initScripts
```
initScripts:
  install_repository_azure_plugin.sh: |
    #!/bin/bash
    cd /opt/bitnami/elasticsearch/bin/
    ./elasticsearch-plugin install repository-azure -b
```

1.  **Configure Azure Client Settings:** 


    * SSH into a pod and navigate to the directory /opt/bitnami/elasticsearch.


    * Run the following commands to add the Azure secrets to the Elasticsearch keystore:


```
bin/elasticsearch-keystore add azure.client.default.account
bin/elasticsearch-keystore add azure.client.default.key
```


    

Upon executing each command, you'll be prompted to enter the corresponding value:


* For azure.client.default.account, enter the Azure storage account value.


* For azure.client.default.key, enter the Azure storage account key value.




1.  **Reload Secure Settings:** 

    Once you reload the settings, the internal azure clients, which are used to transfer the snapshot, will utilize the latest settings from the keystore. Use the below curl to reload settings:



Reload Secure Settings
```
curl --location --request POST 'localhost:9200/_nodes/reload_secure_settings?pretty=null'
```

1.  **Manage Snapshot Repository & Create A Snapshot:** 

    Use these below curl commands to configure a snapshot repository for Azure and create a snapshot.



Configure Snapshot Repository for Azure
```
curl --location --request PUT 'localhost:9200/_snapshot/es-backup' \
--header 'Content-Type: application/json' \
--data '{
    "type": "azure",
    "settings": {
        "container": "es-backup",
        "compress": true
    }
}'
```
Create Snapshot
```
curl --location --request PUT 'localhost:9200/_snapshot/es-backup/es-backup?wait_for_completion=true'
```

### Restore: 

1.  **Upgradation to 7.17.13:** 

    Update the Elasticsearch image to 7.17.13 version. This will initiate a rolling upgrade process and automatically reindex the data.

     **Note:**  If Elasticsearch is deployed as a pod in Kubernetes, rolling upgrade process is recommended.



noteWhen performing the upgrade within the same cluster, the following steps are unnecessary. You can still restore by deleting all indexes. However, if transitioning to a different cluster or migrating from a significantly older version to a new major version, follow these steps.

When performing the upgrade within the same cluster, the following steps are unnecessary. You can still restore by deleting all indexes. However, if transitioning to a different cluster or migrating from a significantly older version to a new major version, follow these steps.


1.  **Prepare Elasticsearch:** 


    * Make sure elasticsearch of version 7.17.13 is ready.


    * Proceed by following Steps 2 and 3 outlined in the backup section.



    
1.  **Verify & Restore Snapshot:** 

    Use these below curl commands to restore backup and verify the snapshot.



Verify All Snapshot
```
curl --location 'localhost:9200/_snapshot/_all?pretty=true'
```
Restore Snapshot
```
curl --location --request POST 'localhost:9200/_snapshot/es-backup/es-backup/_restore'
```

## Local Environment: 

### Backup:

1.  **Set Up Backup Directory:** 

    Choose a directory on your local system to store your Elasticsearch backup.                                Example: /Users/admin/Documents/esbackup


1.  **Configure Elasticsearch:** 

    Open the elasticsearch.yml configuration file located in the config folder. Add the following configuration to specify the backup repository path:


```
path.repo: "/Users/admin/Documents/esbackup"
```


Restart elasticsearch version 6.8.23 to apply the configuration changes.


1.  **Manage Snapshot Repository & Create A Snapshot:** 

    Use these below curl commands to register a snapshot repository, verify repository, create snapshot .



Registering Snapshot Repository
```
curl --location --request PUT 'localhost:9200/_snapshot/my_repository' \--header 'Content-Type: application/json' \--data '{  "type": "fs",  "settings": {    "location": "/Users/admin/Documents/esbackup"  }}'
```
Verify Repository
```
curl --location --request POST 'localhost:9200/_snapshot/es-backup/_verify?pretty=true'
```
Create Snapshot
```
curl --location --request PUT 'localhost:9200/_snapshot/my_repository/my_backup?wait_for_completion=true'
```
Stop Elasticsearch version 6.8.23, repeat Step 2 on Elasticsearch version 7.17.13 then restart.


### Restore:

1.  **Verify & Restore Snapshot:** 

    Use these below curl commands to restore backup and verify the snapshot.



Verify Snapshot
```
curl --location 'localhost:9200/_snapshot/_all?pretty=true'
```
Restore Backup
```
curl --location --request POST 'localhost:9200/_snapshot/my_repository/my_backup/_restore'
```




*****

[[category.storage-team]] 
[[category.confluence]] 
