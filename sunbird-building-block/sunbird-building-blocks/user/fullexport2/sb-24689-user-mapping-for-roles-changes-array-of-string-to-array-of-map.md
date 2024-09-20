Release : 4.0.0



Steps to re-index the data with the new mapping:


1. First check the number of  **number_of_shards**  &  **number_of_replicas**  from old user index by running below curl 


```
curl --location --request GET 'http://localhost:9200/_cat/indices/%2A?v=&s=index:desc'
```

1. Create new user index with name as userv{x} // x is version number and update the user mapping using ES Mapping jenkins job { **OpsAdministration/job/dev/job/Core/job/ESMapping/** }


1. Once mapping update and ingest pipeline completed, run the reindex curl ,  **_old_user_index_name: userv1_** 

     **_new_user_index_name: userv2_** 


```
curl --location --request POST 'localhost:9200/_reindex?pretty' \
--header 'Content-Type: application/json' \
--data-raw '{
  "source": {
    "index": "{old_user_index_name}"
  },
  "dest": {
    "index": "{new_user_index_name}",
    "pipeline": "{user_ingest_name}"
  }
}'
```

1. After updating replica , add alias to the new index with alias name as  **user_alias**  and delete alias from old index, by below curls 


```
curl --location --request PUT 'localhost:9200/{new_index_name}/_alias/user_alias?pretty'

curl --location --request DELETE 'localhost:9200/{old_user_index_name}/_alias/user_alias?pretty'

```
Note : If alias name changed other than  **user_alias,** update the learner env for  **user_index_alias** 

    


1. Run the cassandra user migration for roles(which is also mentioned in the deployment tracker), if the activity is parallelly going on exclude the step, else proceed with cassandra user migration mentioned from the below document.

    [https://project-sunbird.atlassian.net/wiki/spaces/UM/pages/2603974662/SB-23168%2BData%2Bmigration%2Bto%2Buser%2Brole%2Btable%2Bfrom%2Buser%2Borganisation%2Btable](https://project-sunbird.atlassian.net/wiki/spaces/UM/pages/2603974662/SB-23168%2BData%2Bmigration%2Bto%2Buser%2Brole%2Btable%2Bfrom%2Buser%2Borganisation%2Btable)  , This will generate the csv with userid’s which we use in the below Elasticsearch Sync.

    


1. Deploy the learner (release-4.0.0) and check the disk usage , replica number for the new index by running the below curl 


```
curl --location --request GET 'http://localhost:9200/_cat/indices/%2A?v=&s=index:desc'
```


 7. Delete the user ingest pipeline create for roles. 


```
curl -X DELETE "localhost:9200/_ingest/pipeline/{user_ingest_name}?pretty"
```
 8. Run the sync tool for  **USER**  only which is mentioned in below document link:

Steps to use sync tool:


1. Create a separate instance for learner , so other API will not get affected with this long run.


```
create a separate learner replica with 4 or more pods with different labels and expose them as nodeport
```

1. Create a new VM or use any existing VM (like jenkins), from where we can connect to learner-service to run the sync tool.


1. Download the java executible jar ([SyncUserOrgDataToES.jar](https://github.com/project-sunbird/sunbird-utils/blob/release-3.8.0/data_correction_script/SyncUserOrgDataToES.jar)) from the [https://github.com/project-sunbird/sunbird-utils/tree/release-3.8.0/data_correction_script](https://github.com/project-sunbird/sunbird-utils/tree/release-3.8.0/data_correction_script)


```
wget https://github.com/project-sunbird/sunbird-utils/blob/release-3.8.0/data_correction_script/SyncUserOrgDataToES.jar?raw=true
mv SyncUserOrgDataToES.jar\?raw\=true SyncUserOrgDataToES.jar
```



1. Get the csv file of objectIds (without any header) which is generated from cassandra migration in above main step 5.

 **Note :** split csv file to 10 separate csv file for parallelism and associate each csv file to one sync tool instance. use below cmd to split csv file based on the number of records.


```
split -l 50000 file.csv fileChanged -d --additional-suffix=.csv

50000 // this is the number of records , each splitted csv will contain
file.csv // path of csv file
fileChanged //new csv filename prefix 
```



1. Run the below java command to sync the data in each (split) csv file 


```
Command to run the jar:

To sync user data
java -jar SyncUserOrgDataToES.jar "csv file path" "learner_port" "learner_ip" "batch_count" "object_type" "dry_run"

Example:

java -jar SyncUserOrgDataToES.jar "/home/user/userids.csv" "9000" "127.0.0.1" "100" "user" "false"

Note:
1. dry_run as true will not make learner API call. dry_run as false will make learner API call.
2. batch_count is the count of ids it will read from csv file to sync user in one API call.
```
 **Note :** Run the sync tool as a seperate java process on same machine for more parallelism(We can run 5-10 sync tool parallelly)

    





*****

[[category.storage-team]] 
[[category.confluence]] 
