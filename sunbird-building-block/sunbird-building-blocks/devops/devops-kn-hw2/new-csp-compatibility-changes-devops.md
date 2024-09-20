
### Repository - [https://github.com/project-sunbird/sunbird-devops](https://github.com/project-sunbird/sunbird-devops)
Cloud specific ansible role

|  **Cloud Provider**  |  **Ansible Role**  | 
|  --- |  --- | 
| AWS | [https://github.com/project-sunbird/sunbird-devops/tree/release-5.1.0/ansible/roles/aws-cloud-storage](https://github.com/project-sunbird/sunbird-devops/tree/release-5.1.0/ansible/roles/aws-cloud-storage) | 
| Azure | [https://github.com/project-sunbird/sunbird-devops/tree/release-5.1.0/ansible/roles/azure-cloud-storage](https://github.com/project-sunbird/sunbird-devops/tree/release-5.1.0/ansible/roles/azure-cloud-storage) | 
| GCP | [https://github.com/project-sunbird/sunbird-devops/tree/release-5.1.0/ansible/roles/gcp-cloud-storage](https://github.com/project-sunbird/sunbird-devops/tree/release-5.1.0/ansible/roles/gcp-cloud-storage) | 


* We will need to create a CSP specific ansible role which can perform tasks such as upload / download / delete of files and folders from CSP storage buckets etc.


* Take a look at one of the existing cloud provider role such as AWS / GCP to understand what all operations are required as part of the role.



Cloud specific Elasticsearch plugin

|  **Cloud Provider**  |  **Ansible Role**  | 
|  --- |  --- | 
| AWS | [https://github.com/project-sunbird/sunbird-devops/tree/release-5.1.0/ansible/roles/es-s3-snapshot](https://github.com/project-sunbird/sunbird-devops/tree/release-5.1.0/ansible/roles/es-s3-snapshot) | 
| Azure | [https://github.com/project-sunbird/sunbird-devops/tree/release-5.1.0/ansible/roles/es-azure-snapshot](https://github.com/project-sunbird/sunbird-devops/tree/release-5.1.0/ansible/roles/es-azure-snapshot) | 
| GCP | [https://github.com/project-sunbird/sunbird-devops/tree/release-5.1.0/ansible/roles/es-gcs-snapshot](https://github.com/project-sunbird/sunbird-devops/tree/release-5.1.0/ansible/roles/es-gcs-snapshot) | 


* We will need to create a CSP specific ansible role which can perform elasticsearch snapshot


* Take a look at one of the existing cloud provider role such as AWS / GCP to understand the snapshot approach


* Under the hood, we are using the cloud provider plugin for elasticsearch snapshot - [https://www.elastic.co/guide/en/elasticsearch/plugins/6.8/repository.html](https://www.elastic.co/guide/en/elasticsearch/plugins/6.8/repository.html)


* The plugin gets installed and configured using the ansible role



Ansible tasks related to storage bucketsBelow is a sample block which uploads to AWS S3 bucket ([https://github.com/project-sunbird/sunbird-devops/blob/release-5.1.0/ansible/artifacts-upload.yml#L30-L41](https://github.com/project-sunbird/sunbird-devops/blob/release-5.1.0/ansible/artifacts-upload.yml#L30-L41) )


```
    - name: upload artifact to aws s3
      include_role:
        name: aws-cloud-storage
        tasks_from: upload.yml
      vars:
        local_file_or_folder_path: "{{ artifact_path }}"
        s3_bucket_name: "{{ cloud_storage_artifacts_bucketname }}"
        s3_path: "{{ artifact }}"
        aws_default_region: "{{ cloud_public_storage_region }}"
        aws_access_key_id: "{{ cloud_artifact_storage_accountname }}"
        aws_secret_access_key: "{{ cloud_artifact_storage_secret }}"
      when: cloud_service_provider == "aws"
```

* In order to support a new CSP, we will need to add a similar block which can invoke the CSP specific roles and upload to CSP storage buckets


* Below is the list of files that need to be modified to include the CSP storage ansible role




```
ansible/bootstrap.yml
ansible/dial_upload-schema.yml
ansible/uploadFAQs.yml
ansible/deploy-plugins.yml
ansible/desktop-faq-upload.yml
ansible/artifacts-upload.yml
ansible/es.yml
ansible/kp_upload-schema.yml
ansible/roles/prometheus-backup-v2/tasks/main.yml
ansible/roles/postgresql-backup/tasks/main.yml
ansible/roles/prometheus-restore/tasks/main.yml
ansible/roles/cert-templates/tasks/main.yml
ansible/roles/prometheus-backup/tasks/main.yml
ansible/roles/cassandra-backup/tasks/main.yml
ansible/roles/postgres-managed-service-restore/tasks/main.yml
ansible/roles/desktop-deploy/tasks/main.yml
ansible/roles/cassandra-restore/tasks/main.yml
ansible/roles/jenkins-backup-upload/tasks/main.yml
ansible/roles/mongodb-backup/tasks/main.yml
ansible/roles/redis-backup/tasks/main.yml
ansible/roles/postgresql-restore/tasks/main.yml
ansible/roles/es6/tasks/main.yml
ansible/roles/log-es6/tasks/main.yml
ansible/roles/postgres-managed-service-backup/tasks/main.yml
ansible/roles/grafana-backup/tasks/main.yml
ansible/assets-upload.yml
ansible/artifacts-download.yml
ansible/plugins.yml
```
Ansible Variables  Private Repo Templates
* All the cloud specific variables (for example, bucket name, access key, secret key etc.) are provided to adopters using ansible variable template files


* The ansible variable template files need to be updated to include CSP specific variables so that a user is aware on what variables need to be filled based on the cloud provider


* The templates are located here - [https://github.com/project-sunbird/sunbird-devops/tree/release-5.1.0/private_repo/ansible/inventory/dev](https://github.com/project-sunbird/sunbird-devops/tree/release-5.1.0/private_repo/ansible/inventory/dev)


* An adopter updates all the files mentioned in the above url which also includes the cloud specific variables




### Repository - [https://github.com/project-sunbird/sunbird-learning-platform/](https://github.com/project-sunbird/sunbird-learning-platform/)

* The implementation is same as the previous section (no private repo template in this repo, its part of the previous section)


* Below is the list of files that require the changes




```
ansible/artifacts-upload.yml
ansible/roles/cassandra-backup/tasks/main.yml
ansible/roles/cassandra-restore/tasks/main.yml
ansible/roles/redis-backup/tasks/main.yml
ansible/roles/neo4j-backup/tasks/main.yml
ansible/roles/neo4j-restore/tasks/main.yml
ansible/roles/redis-restore/tasks/main.yml
ansible/artifacts-download.yml
ansible/es_backup.yml
```

### Repository - [https://github.com/Sunbird-Obsrv/sunbird-data-pipeline](https://github.com/Sunbird-Obsrv/sunbird-data-pipeline)

* The implementation is same as the previous section (no private repo template in this repo, its part of the previous section)


* Below is the list of files that require the changes




```
ansible/artifacts-upload.yml
ansible/roles/postgresql-backup/tasks/main.yml
ansible/roles/provision-azure-spark-cluster/tasks/main.yml
ansible/roles/cassandra-backup/tasks/main.yml
ansible/roles/redis-multiprocess-backup/tasks/main.yml
ansible/roles/postgres-managed-service-restore/tasks/main.yml
ansible/roles/cassandra-restore/tasks/main.yml
ansible/roles/influxdb_backup/tasks/main.yml
ansible/roles/redis-backup/tasks/main.yml
ansible/roles/postgresql-restore/tasks/main.yml
ansible/roles/postgres-managed-service/tasks/main.yml
ansible/roles/redis-restore/tasks/main.yml
ansible/roles/redis-multiprocess-restore/tasks/main.yml
ansible/roles/influxdb_restore/tasks/main.yml
ansible/artifacts-download.yml
ansible/es_backup.yml
```


*****

[[category.storage-team]] 
[[category.confluence]] 
