
# About
This sync tool , reads a csv file containing objectIds (ids of user, org or location) and make call to learner-service sync API which index cassandra data to ES.


## Steps to use sync tool:

1. Create a separate instance for learner , so other API will not get affected with this long run.


```
create a separate learner replica with 4 or more pods with different labels and expose them as nodeport
```

1. Create a new VM or use any existing VM (like jenkins), from where we can connect to learner-service to run the sync tool.


1. Download the java executible jar ([SyncUserOrgDataToES.jar](https://github.com/project-sunbird/sunbird-utils/blob/release-3.8.0/data_correction_script/SyncUserOrgDataToES.jar)) from the [https://github.com/project-sunbird/sunbird-utils/tree/release-3.8.0/data_correction_script](https://github.com/project-sunbird/sunbird-utils/tree/release-3.8.0/data_correction_script) .


```
wget https://github.com/project-sunbird/sunbird-utils/blob/release-3.8.0/data_correction_script/SyncUserOrgDataToES.jar?raw=true
mv SyncUserOrgDataToES.jar\?raw\=true SyncUserOrgDataToES.jar
```

1. Get the csv file of objectIds (without any header) from cassandra.

    To generate csv file use the below cql query .




```
COPY sunbird.organisation (id) TO '/home/loggedUser/orgids.csv' WITH HEADER = False ;
COPY sunbird.user (id) TO '/home/loggedUser/userids.csv' WITH HEADER = False ;
```
 **Note :** split csv file to 10 separate csv file for parallelism and associate each csv file to one sync tool instance. use below cmd to split csv file based on the number of records.


```
split -l 50000 file.csv fileChanged -d --additional-suffix=.csv

50000 // this is the number of records , each splitted csv will contain
file.csv // path of csv file
fileChanged //new csv filename prefix 
```
  5. Run the below java command to sync the data in each (split) csv file


```
Command to run the jar:

To sync user data
java -jar SyncUserOrgDataToES.jar "csv file path" "learner_port" "learner_ip" "batch_count" "object_type" "dry_run"

Example:

java -jar SyncUserOrgDataToES.jar "/home/user/userids.csv" "9000" "127.0.0.1" "100" "user" "false"

To sync org data
java -jar SyncUserOrgDataToES.jar "csv file path" "learner_port" "learner_ip" "batch_count" "object_type" "dry_run"

Example:

java -jar SyncUserOrgDataToES.jar "/home/org/orgids.csv" "9000" "127.0.0.1" "100" "organisation" "false"

Note:
1. dry_run as true will not make learner API call. dry_run as false will make learner API call.
2. batch_count is the count of ids it will read from csv file to sync user/org in one API call.
```


 **Note :** Run the sync tool as a seperate java process on same machine for more parallelism(We can run 5-10 sync tool parallelly)







*****

[[category.storage-team]] 
[[category.confluence]] 
