
* In this page, we have laid out the steps to upgrade postgres using pg_dump and pg_restore


* This is a generic document, which you can use to upgrade from any version of postgres to any other version


* We also talk a bit about Azure postgres and some ways to ensure your services dont update the database during upgrade


* This upgrade procedures requires a downtime





|  **Sl No**  |  **Task**  |  **Command**  |  **Comments**  | 
| 0 | Create a new postgres instance | Choose postgres version 10 (preferably 11 ) and above and same configuration as per existing instance on AzureYou are free to have independent instances or a single instance for all services as per your needWhitelist all the IP's as per existing postgresTest the connection by connecting to the instance from jenkinsIf on VM, create a new VM (preferably Ubuntu 18 and above) and run the Postgres provision role. **Note: This document does not cover details on how to upgrade postgres on the same / exisiting VM. Feel free to contribute the steps to this document.**  | New instance of same configuration should be created. We have used Postgres version 11 | 
| 1 | Update the inventory | Search and update all the variables in common.yml, secrets.yml Core and DataPipeline directory in private repositoryReplace the postgres instance address, postgres user and postgres password with the new detailsAlso look at variable druid_postgres_user in case you are using Azure postgres. If you are using a common username and password per instance, then this variable needs to be added and the value should be your instance username. This variable will default to druid@instanceIf you are on a VM, use the new VM IP along with username and password | It will be simpler if you use same username and password for all dbs on the postgres instance. If you want to use different user name and password for each database on an instance, then you need to ensure you create those users and roles before hand by running provision jobs against your postgres instance or do them manually. This document does not cover how to restore user accounts. For that you can refer to Azure docs or postgres documentation. Below is one such link -[ **https://docs.microsoft.com/en-us/azure/postgresql/how-to-upgrade-using-dump-and-restore** ](https://docs.microsoft.com/en-us/azure/postgresql/how-to-upgrade-using-dump-and-restore) | 
| 2 | Start of down timeStop traffic / services | Stop trafficPut Jenkins into maintenance mode so nobody can deploy any jobs Cut off connection to postgres from all services except Jenkins (In azure remove all connecting subnets except Jenkins, disable Azure services connections also)In VM you have multiple ways - Disable outside connections by editing pg_hba.conf so only localhost connections are accepted. Or stop the below services so that they dont update postgres databaseList of services that are going to be affected on Sunbird -
```yaml
- Deploy/DataPipeline/AnalyticsCore
- Deploy/DataPipeline/CoreDataProducts
- Deploy/DataPipeline/EdDataProducts
- Deploy/DataPipeline/FlinkPipelineJobs
- Deploy/Datapipeline/InternalKong
- Deploy/Kubernetes/Analytics
- Deploy/Kubernetes/APIManager
- Deploy/Kubernetes/Enc
- Deploy/Kubernetes/HawkeyeSuperset
- Deploy/Kubernetes/Keycloak
- Deploy/Kubernetes/Learner
- Deploy/Kubernetes/LMS
- Deploy/Kubernetes/Report
- Deploy/UCI/fusionauth
- Deploy/UCI/gql
- Deploy/UCI/Inbound
- Deploy/UCI/odk
- Deploy/UCI/Orchestrator
- Deploy/UCI/Outbound
- Deploy/UCI/Transformer
- Deploy/UCI/UCI
- DataPipeline/Druid
- Superset
```
List of services that are going to be affected on Vidyadaan -
```
- Deploy/Kubernetes/APIManager
- Deploy/Kubernetes/Enc
- Deploy/Kubernetes/Opensaber
- Deploy/Kubernetes/Program
- Deploy/Kubernetes/HawkeyeSuperset
- Deploy/Kubernetes/PostgresqlMigration
- Deploy/DataPipeline/EdDataProducts
```
 | Respective services should be stopped / Postgres reachability should be removedTraffic can be stopped based on situation by removing nginx daemonset or changing nginx service port mapping to something else from 80 / 443 | 
| 3 | Manually list all the DB's first | 
```bash
export PG_HOST="" # Enter the postgres host inside the quotes
export PG_USER="" # Enter the postgres user inside the quotes
export PGPASSWORD="" # Enter the postgres password inside the quotes

psql -h $PG_HOST -U $PG_USER -d postgres -c "\l"
```
 | All DB should be listed | 
| 4 | Run command to get all the DB's on terminal and store in a file | 
```bash
mkdir $PG_HOST-$(date +'%s') && cd $PG_HOST-$(date +'%s')

psql -h $PG_HOST -U $PG_USER -d postgres -c "\l" | awk 'NR>3{print $1}'| grep -v "|\|(\|^$\|template0\|template1\|azure_maintenance\|postgres\|azure_sys" | tee -a dbs.txt
```
 | Verify all db are present in the file and matches our db's Ignore db's like postgres, template0, template1, azure_maintanance and also remove not required DB's from the file | 
| 5 | Take backup of the DB's from current instance | 
```
while read -r line; do echo "Dumping DB $line" && pg_dump -Fd -j PG_CPU_CORES -h $PG_HOST -U $PG_USER -d $line -f $line; done < dbs.txt
```
 | Replace PG_CPU_CORES with the number of cores of the postgres insatnce.  Example: For 4 core, value will be 4 | 
| 6 | Get count of all tables from all DB's from current instance | 
```
while read -r line; do psql -h $PG_HOST -U $PG_USER -d $line -c "\dt" | awk -F "|" 'NF {print $2}' | tr -d ' ' | awk 'NF' | tail -n +2 | tee -a $line-tables.txt; done < dbs.txt

while read -r line; do while read -r inline; do echo $inline | tee -a $line-table-count.txt  && psql -h $PG_HOST -U $PG_USER -d $line -c "SELECT COUNT(*) FROM \"$inline\"" | tee -a $line-table-count.txt; done < $line-tables.txt; done < dbs.txt
```
 | All tables and counts will be displayed and also written into the filesRepeat Steps 3 - 6 for every postgres instance (in case you are running the workload on separate instances) | 
| 7 | Rearrange the DBs across two instances or based on your requirement | In this case, we will be creating the following databases across two instancesInstance 1 - Keycloak, Public Kong, Private Kong, Quartz, Enc Keys Instance 2 - Analytics, Druid, GraphiteFeel free to add any other dbs you have / want to. This is not an exhaustive listCreate two directories as below
```bash
mkdir pg11
mkdir pg11-dp
cd pg11
touch dbs.txt
```
Add the required db names in the file dbs.txt. See next column for sample referenceMove all the required backup folders and files to this directory. Below is a sample command
```
mv old_pg_backup_folder/api_manager_kong14* pg11
```
Similarly do for the other dbs and pg11-db folder also (second instance)
```
cd pg11-dp
touch dbs.txt
```
Add the required db names in the file dbs.txt. See next column for sample referenceIf you are going to use only once instance, then you can move all the backup data and other files under a single directory | Instance 1:
```bash
cat pg11/dbs.txt 
api_manager_kong14
keycloak7
quartz
api_manager_internal
dev-keys

ls -lrth pg11
api_manager_internal
api_manager_internal-table-count.txt
api_manager_internal-tables.txt
api_manager_kong14
api_manager_kong14-table-count.txt
api_manager_kong14-tables.txt
keycloak7
keycloak7-table-count.txt
keycloak7-tables.txt
dev-keys
dev-keys-table-count.txt
dev-keys-tables.txt
quartz
quartz-table-count.txt
quartz-tables.txt
dbs.txt
```
Instance 2:
```
cat pg11-dp/dbs.txt 
analytics
druid-raw
graphite
superset

ls -lrth pg11-dp
analytics
analytics-table-count.txt
analytics-tables.txt
druid-raw
druid-raw-table-count.txt
druid-raw-tables.txt
graphite
graphite-table-count.txt
graphite-tables.txt
superset
superset-tables.txt
dbs.txt
```
 | 
| 8 | Install postgres 11 tools | 
```
sudo apt install postgresql-client-11
```
 | If you to use pg_dump and pg_restore on older postgres version, install those packagessudo apt install postgresql-client-9.6 | 
| 9 | Create empty databases in new instance | 
```bash
export PG_HOST="" # Enter the new postgres host inside the quotes
export PG_USER="" # Enter the new postgres user inside the quotes
export PGPASSWORD="" # Enter the new postgres password inside the quotes
psql -h $PG_HOST -U $PG_USER -d postgres -c "\l"

while read -r line; do echo "Creating DB $line" && psql -h $PG_HOST -U $PG_USER -d postgres -c "CREATE DATABASE $line"; done < dbs.txt
 
psql -h $PG_HOST -U $PG_USER -d postgres -c "\l"
```
 | Empty databases should be created on new postgres instance **Note: Add double quotes in** dbs.txt **if you have hyphen in DB name** "DB-NAME" **or else you will receive below error** 
```
Creating DB loadtest-keys
ERROR: syntax error at or near "-"
LINE 1: CREATE DATABASE loadtest-keys
```
 | 
| 10 | Restore the DB's to the new instance | 
```
while read -r line; do echo "Restoring DB $line" && pg_restore -O -j PG_CPU_CORES -h $PG_HOST -U $PG_USER -d $line $line; done < dbs.txt
```
 | Replace PG_CPU_CORES with the number of cores of the postgres insatnce.   **Example** : For 4 core, value will be 4 **Note: Remove double quotes in** dbs.txt **if you have hyphen in DB name** "DB-NAME" **or else you will receive below error** 
```
Restoring DB "uci-botdb"
pg_restore: [archiver] could not open input file ""uci-botdb"": No such file or directory
```
Ignore errors like
```
ERROR: role "postgres" does not exist 

pg_restore: [archiver (db)] Error while PROCESSING TOC:
pg_restore: [archiver (db)] Error from TOC entry 5; 2615 2200 SCHEMA public azure_superuser
pg_restore: [archiver (db)] could not execute query: ERROR:  schema "public" already exists
    Command was: CREATE SCHEMA public;
    
pg_restore: [archiver (db)] Error while PROCESSING TOC:
pg_restore: [archiver (db)] Error from TOC entry 3728; 0 0 ACL SCHEMA public azure_superuser
pg_restore: [archiver (db)] could not execute query: ERROR:  role "postgres" does not exist
    Command was: GRANT ALL ON SCHEMA public TO postgres;
```
 | 
| 11 | Analyze the db's on new instance | 
```
while read -r line; do psql -h $PG_HOST -U $PG_USER -d $line -c "ANALYZE VERBOSE"; done < dbs.txt
```
 | Verbose logs will be displayed | 
| 12 | Get count of all tables from all DB's from new instance | 
```
while read -r line; do while read -r inline; do echo $inline | tee -a $line-table-count-new.txt  && psql -h $PG_HOST -U $PG_USER -d $line -c "SELECT COUNT(*) FROM \"$inline\"" | tee -a $line-table-count-new.txt; done < $line-tables.txt; done < dbs.txt
```
 | All tables and counts will be displayed and also written into the files | 
| 13 | Compare the row counts of both the instances | 
```
while read -r line; do echo "Diff of $line-table-count.txt and $line-table-count-new.txt" && diff $line-table-count.txt $line-table-count-new.txt; done < dbs.txt
```
 | This will not display any output. Which means files are identicalIf there are differences use the below to compare and then take fresh backup and restore those dbs again diff -y file1 file2 | 
| 14 | Remove all connections to old Postgres | Remove all subnets and enable deny public network acces on Azure portalIf on VM, stop the VM / postgres serviceIn case of Azure, make sure you update the Backup and Log retention days to a large number | To ensure no service can connect to old DBs | 
| 15 | Clear offline session from Keycloak DB on Sunbird | 
```
truncate offline_client_session;
truncate offline_user_session;
```
 | If we have too many rows in these tables, keycloak will not start | 
| 16 | End of down time Redeploy services / Enable Traffic | Redeploy the following services in case of Sunbird:
```yaml
- Deploy/DataPipeline/AnalyticsCore
- Deploy/DataPipeline/CoreDataProducts
- Deploy/DataPipeline/EdDataProducts
- Deploy/DataPipeline/FlinkPipelineJobs (Choose all in job_names_to_deploy)
- Deploy/Datapipeline/InternalKong
- Deploy/Kubernetes/Analytics
- Deploy/Kubernetes/APIManager
- Deploy/Kubernetes/Enc
- Deploy/Kubernetes/HawkeyeSuperset
- Deploy/Kubernetes/Keycloak
- Deploy/Kubernetes/Learner
- Deploy/Kubernetes/LMS
- Deploy/Kubernetes/Report
- Deploy/UCI/fusionauth
- Deploy/UCI/gql
- Deploy/UCI/Inbound
- Deploy/UCI/odk
- Deploy/UCI/Orchestrator
- Deploy/UCI/Outbound
- Deploy/UCI/Transformer
- Deploy/UCI/UCI
- Provision/DataPipeline/Druid (Choose all in service except java)
- Superset - No Jenkins Job
```
Redeploy the following services in case of Vidyadaan:
```
- Deploy/Kubernetes/APIManager
- Deploy/Kubernetes/Enc
- Deploy/Kubernetes/Opensaber
- Deploy/Kubernetes/Program
- Deploy/Kubernetes/HawkeyeSuperset
- Deploy/Kubernetes/PostgresqlMigration
- Deploy/DataPipeline/EdDataProducts
```
 | The configmaps and configuration files will be updated with new data. Do verify it by checking them manually for all these services. **Note: If during deployment, any ansible errors occur due to missing variables or incorrect variables, you will have to fix them and move forward**  | 





*****

[[category.storage-team]] 
[[category.confluence]] 
