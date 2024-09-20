# ETL-job-to-add-state,-district-of-non-custodian-user-into-user-DB

**System JIRAkey,summary,type,created,updated,due,assignee,reporter,priority,status,resolution2207a759-5bc8-39c5-9cd2-aa9ccc1f65ddSC-888** **Overview** As part of enhancing the user profile data and having the location data available along with user profile, we need to update the existing user location data. Currently we allow custodian org users to update their state and district after registering. This migration job will enable to update the old available data for non-custodian user's based on their associated organizations.

**Solution** We will be writing the ETL job - which will take care of this data migration.

This will be run as cron job, so data gets updated as new data enters the system.

In future, we can disable the cron job, once alternate way of populating the same data is in place.

**Algorithm**

* First fetch the custodian organization id from system settings table.
* Now fetch all the users, whose root-org is not custodian org.
* Fetch the location Ids - if available from the root-org.
* Fetch sub-org associations for the user, and pick the location information from first sub-org.
* If one or more location IDs are present in sub org then use location IDs from sub org. Else use location IDs from root org.
* Records all the user's updated in the above process into a seperate csv file.
* Now trigger a ElasticSearch sync to  update above user's data to elasticsearch index.
* Clean-up the file created in previous step.

We plan to run above job - from Jenkins - based on configured schedule as a background job running at regular intervals.

For verification purpose, above job can be run in DRY RUN mode as well.

***

\[\[category.storage-team]] \[\[category.confluence]]
