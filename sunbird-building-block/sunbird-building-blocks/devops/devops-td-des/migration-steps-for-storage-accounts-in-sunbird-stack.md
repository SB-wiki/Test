


# Storage account Migrations and refactoring


Its Great to know that  **we don’t have 1500+ variables but only 14 variables now in sunbird, related to storage accounts**  like name, keys, sas in the ansible code and no cross reference apart from container details. 


## Create 2 storage Accounts for private application contents and one management account to store backups and other devops related code, Don't touch the storage account with public contents and druid contents.
\* Follow the below naming convention to create storage account, NOTE: organisation and env are variables

{{organisation}}{{env}}management

{{organisation}}{{env}}private

\* Create a generic storage account for all the environments to store build artifacts for jenkins, this is a one time activity for all the environments in a particular organisation.

{{organisation}}artifact

\* Keep the druid storage account and key as and make sure the container is private

\* Remove all the reference variables related to storage account from CORE/KnowledgePlaform/DataPipeline[Common.yml/Secrets.yml] from the private github repo.


*  Migrate the storage containers across storage accounts \[container with private ACL to be in private storage account, public should left as is]as per the design document\[[https://docs.google.com/spreadsheets/d/1S5ivpL4DerR4i0YIPkms17K6wv0Y9uf5rguSVB_2_d8/edit#gid=1341452876%5D](https://docs.google.com/spreadsheets/d/1S5ivpL4DerR4i0YIPkms17K6wv0Y9uf5rguSVB_2_d8/edit#gid=1341452876%5D)


* Generate SAS token for management, public, artifacts and private storage account with CRUD operations



Core Secrets Variables:

sunbird_public_storage_account_key:

sunbird_public_storage_account_sas:

sunbird_private_storage_account_key:

sunbird_management_storage_account_key:

sunbird_artifact_storage_account_key:

sunbird_artifact_storage_account_sas:

Core common.yml variables

sunbird_public_storage_account_name:

sunbird_private_storage_account_name:

sunbird_management_storage_account_name:

sunbird_artifact_storage_account_name:

Knowledge Platform common.yml variables

sunbird_public_storage_account_name:

sunbird_management_storage_account_name:

sunbird_artifact_storage_account_name:

Knowledge Platform secret variables

sunbird_public_storage_account_key:

sunbird_public_storage_account_sas:

sunbird_management_storage_account_key:

sunbird_artifact_storage_account_key:

sunbird_artifact_storage_account_sas:

Datapipeline common.yml variables

sunbird_private_storage_account_name:

sunbird_management_storage_account_name:

sunbird_artifact_storage_account_name:

sunbird_druid_storage_account_name:

Datapipeline secrets.yml variables

sunbird_management_storage_account_key:

sunbird_private_storage_account_key:

sunbird_artifact_storage_account_key:

sunbird_artifact_storage_account_sas:

sunbird_druid_storage_account_key:


# CORE 

# Deploy below kubernetes services
badger

cert

knowledge-mw-service

learner

lms

player-service

print


# Build,Artifact upload and deploy for cassandra to check artifact upload.

# KP

# Kill the samza jobs and delete folders and Deploy below Samza jobs for LP
collection-migration

qrcode-image-generator

post-publish-processor

publish-pipeline.properties

asset-enrichment

Deploy Learning-service




# DP

# Keep the media service storage account as is don't touch it
provision Spark - bashrc and /etc/environment changes for spark server changes

Spark data product deployment - scripts/start-jobmanager.sh - change the reports container and other stuff

- data products deploy

Secor deployment - /mount/secorjobs/

- deploy secor jobs

druid - leave as is!!

Analytics API provision - .bashrc, /etc/environment and /home/analytics/sbin/servicify-process.sh file

Adhoc python scripts - taking env from spark server environment variables.




## Update all these jobs to use the latest backup tag for below jobs in opsAdministration Folder, if requred migrate the jobs from dev and provide vaild schedule to run backups.

* ) Core ES


* ) LOG ES


* ) Composite ES


* ) Cassandra CORE


* ) Cassandra KP


* ) Cassandra DP


* ) Neo4j


* ) Redis LP


* ) Redis DP


* ) InfluxDB



Changes Made to achieve this in DevOps automation code are as follows:-


*  **KnowledgePlatform:** [https://github.com/project-sunbird/sunbird-learning-platform/pull/956](https://slack-redir.net/link?url=https%3A%2F%2Fgithub.com%2Fproject-sunbird%2Fsunbird-learning-platform%2Fpull%2F956&v=3)


*  **CORE:** [https://github.com/project-sunbird/sunbird-devops/pull/1246](https://slack-redir.net/link?url=https%3A%2F%2Fgithub.com%2Fproject-sunbird%2Fsunbird-devops%2Fpull%2F1246&v=3)


*  **Data Pipeline:** [https://github.com/project-sunbird/sunbird-data-pipeline/pull/660](https://slack-redir.net/link?url=https%3A%2F%2Fgithub.com%2Fproject-sunbird%2Fsunbird-data-pipeline%2Fpull%2F660&v=3)


*  **Data Pipeline:** [https://github.com/project-sunbird/sunbird-data-pipeline/pull/1058](https://github.com/project-sunbird/sunbird-data-pipeline/pull/1058)







*****

[[category.storage-team]] 
[[category.confluence]] 
