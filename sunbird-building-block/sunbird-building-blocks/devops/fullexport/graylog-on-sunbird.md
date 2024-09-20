
### Introduction

* Graylog is used to process and view the logs on Sunbird.


* In the log stack, we have filebeats agents running on Kubernetes and VM’s These agents send the logs to Graylog.


* Graylog process the logs and stores it in Elasticsearch


* Graylog is used to view the logs also, so it also acts as a visualization tool


* Graylog uses mongodb to store the configurations. Mongodb runs in the same node as graylog and requires minimum resources.


* Graylog and mongodb both run as a cluster if more than one node is provisioned.




### Jenkins Jobs

* The following are the jenkins jobs related to log stack


    * Provision/Core/LogEs


    * Provision elasticsearch for storing the logs



    
    * Provision/Core/Graylog


    * Installs graylog, mongodb and openjdk



    
    * Opsadministration/Core/GraylogMongoImport


    * Imports the dashboards, alerts and other configurations for graylog into mongodb



    
    * Opsadministration/Core/GraylogGeoIP


    * Imports the GeoIP db into graylog



    
    * The below jobs install filebeats on the VMs


    * Deploy/Core/LoggingVMFlilebeats


    * Deploy/KnowledgePlatform/LoggingVMFlilebeats


    * Deploy/DataPipeline/LoggingVMFlilebeats



    
    * Deploy/Kubernetes/Logging


    * oauth-proxy chart - This install oauth proxy and allows graylog to be behind google authentication


    * filebeats chart - This installs filebeats in Kubernetes



    

    


### Ansible Roles

* Graylog configurations are stored as mongodb json dumps. The ansible role that imports the data is located here - [https://github.com/project-sunbird/sunbird-devops/tree/release-5.1.0/ansible/roles/graylog-mongodb-import](https://github.com/project-sunbird/sunbird-devops/tree/release-5.1.0/ansible/roles/graylog-mongodb-import)


* Graylog geoip setup role is located here - [https://github.com/project-sunbird/sunbird-devops/tree/release-5.1.0/ansible/roles/graylog-geoip](https://github.com/project-sunbird/sunbird-devops/tree/release-5.1.0/ansible/roles/graylog-geoip)


* Graylog provision role is located here - [https://github.com/project-sunbird/sunbird-devops/tree/release-5.1.0/ansible/roles/graylog](https://github.com/project-sunbird/sunbird-devops/tree/release-5.1.0/ansible/roles/graylog)


* Mongodb provision role is located here - [https://github.com/project-sunbird/sunbird-devops/tree/release-5.1.0/ansible/roles/mongodb-cluster](https://github.com/project-sunbird/sunbird-devops/tree/release-5.1.0/ansible/roles/mongodb-cluster)


* Filebeats provision on VM can be done used this role - [https://github.com/project-sunbird/sunbird-devops/tree/release-5.1.0/ansible/roles/vm-agents-filebeat](https://github.com/project-sunbird/sunbird-devops/tree/release-5.1.0/ansible/roles/vm-agents-filebeat)


* The helm charts for oauth proxy and filebeats are here - [https://github.com/project-sunbird/sunbird-devops/tree/release-5.1.0/kubernetes/helm_charts/logging](https://github.com/project-sunbird/sunbird-devops/tree/release-5.1.0/kubernetes/helm_charts/logging)


* Log ES ansible role is located here - [https://github.com/project-sunbird/sunbird-devops/tree/release-5.1.0/ansible/roles/log-es6](https://github.com/project-sunbird/sunbird-devops/tree/release-5.1.0/ansible/roles/log-es6)




### Steps to export data from Graylog

* In case you want to create / modify any data on graylog, you can do so by following the below steps


* Login to graylog admin page by using the IP:9000 port


* Make your changes on the Graylog UI


* SSH into the graylog VM


* Export the required table / db data using the below command




```
mongoexport --db=graylog --collection=inputs --out=inputs.json
```

* Inspect the json file and make sure you remove any environment specific value such as IP address etc and change it to ansible template. Check this line for an example - [https://github.com/project-sunbird/sunbird-devops/blob/release-5.1.0/ansible/roles/graylog-mongodb-import/templates/inputs.json#L2](https://github.com/project-sunbird/sunbird-devops/blob/release-5.1.0/ansible/roles/graylog-mongodb-import/templates/inputs.json#L2)


* In order to export more than one table you can use a while loop as show below




```
while read -r line; do mongoexport --db=graylog --collection=$line --out=$line.json; done < collection.txt
```

* Contents of collection.txt




```
cat collection.txt 
access_tokens
alarmcallbackconfigurations
alarmcallbackhistory
alerts
cluster_config
cluster_events
collectors
content_packs
content_packs_installations
event_definitions
event_notification_status
event_notifications
event_processor_state
grants
grok_patterns
index_failures
index_field_types
index_ranges
index_sets
inputs
lut_caches
lut_data_adapters
lut_tables
nodes
notifications
pipeline_processor_pipelines
pipeline_processor_pipelines_streams
pipeline_processor_rules
processing_status
roles
scheduler_job_definitions
scheduler_triggers
searches
sessions
sidecar_collectors
sidecar_configuration_variables
sidecars
streamrules
streams
system_messages
traffic
users
views
```

* Commit the json file to github and test the changes by running the job in another environment and verify the changes are present




### Accessing graylog and Variables

* Graylog can be access using https://domain_name/graylog


* It will open oauth proxy page and ask for google authentication


* You can add domains / emails to whitelist the access


* Refer to these variables for whitelisting


    * [https://github.com/project-sunbird/sunbird-devops/blob/release-5.1.0/private_repo/ansible/inventory/dev/Core/common.yml#L157-L161](https://github.com/project-sunbird/sunbird-devops/blob/release-5.1.0/private_repo/ansible/inventory/dev/Core/common.yml#L157-L161)



    
* Oauth proxy will require a google client id and client secret. Refer to these variables for adding them


    * [https://github.com/project-sunbird/sunbird-devops/blob/release-5.1.0/private_repo/ansible/inventory/dev/Core/secrets.yml#L148-L150](https://github.com/project-sunbird/sunbird-devops/blob/release-5.1.0/private_repo/ansible/inventory/dev/Core/secrets.yml#L148-L150)



    
* Refer to these lines for graylog variables 


    * [https://github.com/project-sunbird/sunbird-devops/blob/release-5.1.0/private_repo/ansible/inventory/dev/Core/common.yml#L433-L444](https://github.com/project-sunbird/sunbird-devops/blob/release-5.1.0/private_repo/ansible/inventory/dev/Core/common.yml#L433-L444)


    * [https://github.com/project-sunbird/sunbird-devops/blob/release-5.1.0/private_repo/ansible/inventory/dev/Core/secrets.yml#L129-L131](https://github.com/project-sunbird/sunbird-devops/blob/release-5.1.0/private_repo/ansible/inventory/dev/Core/secrets.yml#L129-L131)



    


### Using graylog

* For info on how to use graylog, refer to this video - [https://youtu.be/zfpziMeadtA](https://youtu.be/zfpziMeadtA)


* For additional details and features on graylog, refer to graylog docs - [https://go2docs.graylog.org/4-x/what_is_graylog/what_is_graylog.htm](https://go2docs.graylog.org/4-x/what_is_graylog/what_is_graylog.htm)




### Scaling up / down Graylog, Mongo and Log ES

* Scaling up operation is straightforward.


* Adding the new set of IPs in the inventory and run the Provision/Core/Graylog and Provision/Core/LogES jobs


* We will need to modify the graylog, log-es and mongo_master and mongo_replicas groups


    * [https://github.com/project-sunbird/sunbird-devops/blob/release-5.1.0/private_repo/ansible/inventory/dev/Core/hosts#L12-L31](https://github.com/project-sunbird/sunbird-devops/blob/release-5.1.0/private_repo/ansible/inventory/dev/Core/hosts#L12-L31)



    
* After this you should be able to see the new nodes in ES cluster and Graylog cluster


* Scaling down graylog is also straightforward. Just remove the IPs of graylog and mongo from the inventory and rerun the Provision/Core/Graylog job


* Scaling down ES is straightforward if you have replicas for your indices. If you do not have replicas, there will be data loss on removing a ES node.


* If you are ok with data loss, you can just remove the log-es IP from inventory and rerun the Provision/Core/LogES job.


* If you are not ok with data loss, you need to enable the replica for the indices and then remove the node after replication is complete. This will increase the disk size on each node due to replication. For more details on this process, refer to the ES docs - [https://www.elastic.co/guide/en/elasticsearch/reference/current/add-elasticsearch-nodes.html](https://www.elastic.co/guide/en/elasticsearch/reference/current/add-elasticsearch-nodes.html)




### Graylog Monitoring Dashboard and Alerts

* We have created a dashboard to monitor graylog input and output message rate, backlog and journal usage etc. The dashboard is located here - [https://github.com/project-sunbird/sunbird-devops/blob/release-5.1.0/kubernetes/helm_charts/monitoring/dashboards/dashboards/graylog-dashboard.json](https://github.com/project-sunbird/sunbird-devops/blob/release-5.1.0/kubernetes/helm_charts/monitoring/dashboards/dashboards/graylog-dashboard.json)


* We have also configured alerts for backlog and disk utilizations. These can be found here - [https://github.com/project-sunbird/sunbird-devops/blob/release-5.1.0/kubernetes/helm_charts/monitoring/alertrules/templates/graylog_journal_rules.yaml](https://github.com/project-sunbird/sunbird-devops/blob/release-5.1.0/kubernetes/helm_charts/monitoring/alertrules/templates/graylog_journal_rules.yaml)




### Upgrading Graylog

* Upgrading graylog is straight forward. Just update the version in the ansible playbook - [https://github.com/project-sunbird/sunbird-devops/blob/release-5.1.0/ansible/graylog.yml#L6-L9](https://github.com/project-sunbird/sunbird-devops/blob/release-5.1.0/ansible/graylog.yml#L6-L9)


* We will need to ensure the mongodb and ES versions are supported. If support is not available, we will need to upgrade those components also


* We also need to ensure that post upgrade all the dashboards, inputs and other exported json data are compatible and are supported. If not supported, then we will need to update those exported json data as per compatbility.


* We also need to ensure the metrics, dashboard and alerts work as expected post upgrade. If not, we will need to update them and ensure they work as expected.





*****

[[category.storage-team]] 
[[category.confluence]] 
