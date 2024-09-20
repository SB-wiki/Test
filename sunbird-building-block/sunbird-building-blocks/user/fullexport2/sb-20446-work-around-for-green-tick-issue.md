As of now we didn’t trace out the reason for the state-users why state users are not getting statevalidated flag is enabled even-though user externalid and organisations details are updated.

we found a workaround for this issue:


* update the flagsValue value


* Run the async api



 **update the flagsvalue column in user table with the cassandra update query** 

Example: update sunbird.user set flagsvalue=6 where id='f703de4e-d47a-4adb-856c-de122e6a0b32';

Note:


* If the email is verified for the user set flagsvalue = 6


* If the phone is verified for the user set flagsvalue = 5


* If both email and phone values are verified set flagsvalue = 7


* Reference - [UserFlagEnum.java](https://github.com/project-sunbird/sunbird-lms-service/blob/master/actors/sunbird-lms-mw/actors/common/src/main/java/org/sunbird/learner/util/UserFlagEnum.java)



 **Run Async API** 

After updating the cassandra value, application need to sync the same value for the userid in secondary storage environment (ElasticSearch).


```json
curl --location --request POST 'https://dev.sunbirded.org/api/data/v1/index/sync' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiIyZThlNmU5MjA4YjI0MjJmOWFlM2EzNjdiODVmNWQzNiJ9.gvpNN7zEl28ZVaxXWgFmCL6n65UJfXZikUWOKSE8vJ8' \
--data-raw '{
"request": {
    "operationFor":"ES",
	"objectIds":["f703de4e-d47a-4adb-856c-de122e6a0b32"],
	"objectType":"user"
}
}'
```




*****

[[category.storage-team]] 
[[category.confluence]] 
