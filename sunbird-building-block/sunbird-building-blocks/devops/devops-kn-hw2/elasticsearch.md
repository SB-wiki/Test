Backup:

#Install plugin:- sudo ES_PATH_CONF=/etc/elasticsearch/<folder name start with es or cs>/usr/share/elasticsearch/bin/elasticsearch-plugin install repository-azure

#change the configuration: sudo vi /etc/elasticsearch/<folder name start with es or cs>/elasticsearch.yml cloud.azure.storage.default.account: xxxxxxxxxxx cloud.azure.storage.default.key: xxxxxx

#Restart ES Service: sudo systemctl restart es-node-2_elasticsearch.service

#create Repo: curl -XPUT '[http://localhost:9200/_snapshot/azurebackup](http://localhost:9200/_snapshot/azurebackup)' -H 'Content-Type: application/json' -d '{ "type": "azure", "settings": { "container": "<blob_name>", "base_path": "<storage_account_name>"} }'

#create Snapshot: curl -XPUT '[http://localhost:9200/_snapshot/azurebackup/snapshot_1](http://localhost:9200/_snapshot/azurebackup/snapshot_1)' -H 'Content-Type: application/json' -d '{ "indices":"\*","include_global_state":false }'

#check status of backup curl -XGET '[http://localhost:9200/_snapshot/azurebackup/_all](http://localhost:9200/_snapshot/azurebackup/_all)'



Restore: #Install plugin:- sudo ES_PATH_CONF=/etc/elasticsearch/es-node-2 /usr/share/elasticsearch/bin/elasticsearch-plugin install repository-azure

#change the configuration: sudo nano /etc/elasticsearch/es-node-2/elasticsearch.yml cloud.azure.storage.default.account: xxxxxxxxxxx cloud.azure.storage.default.key: xxxxxx

#Restart ES Service: sudo systemctl restart es-node-2_elasticsearch.service

#create Repo: curl -XPUT '[http://localhost:9200/_snapshot/azurebackup](http://localhost:9200/_snapshot/azurebackup)' -H 'Content-Type: application/json' -d '{ "type": "azure", "settings": { "container": "<blob_name>", "base_path": "<storage_account_name>"} }'



#Delete unwanted indices curl -XDELETE '[http://localhost:9200/_all](http://localhost:9200/_all)'

#Restore from snapshot curl -XPOST '[http://localhost:9200/_snapshot/azurebackup/snapshot_1/_restore](http://localhost:9200/_snapshot/azurebackup/snapshot_1/_restore)'

#To check the status of snapshot restore curl -s "[http://localhost:9200/_snapshot/azurebackup/snapshot_1/_status?pretty](http://localhost:9200/_snapshot/azurebackup/snapshot_1/_status?pretty)"



*****

[[category.storage-team]] 
[[category.confluence]] 
