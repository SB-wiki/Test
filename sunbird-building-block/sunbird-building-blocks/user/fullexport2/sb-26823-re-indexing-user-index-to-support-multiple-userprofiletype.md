
## Steps to re-index the data with the new mapping:

1. Create new user index with name as userv{x} // x is version number and update the user mapping using ES Mapping jenkins job { **/Provision/job/dev/job/Core/job/ESMapping/** }. This will create index, mapping and ingest-pipeline for updating profileusertypes.


1. After updating user mapping, run the reindex  using below curl



      => curl for reindexing:


```
curl --location --request POST 'localhost:9200/_reindex?pretty' \
--header 'Content-Type: application/json' \
--data-raw '{
  "source": {
    "index": "userv2"
  },
  "dest": {
    "index": "userv3",
    "pipeline": "userv3-ingest-pipeline"
  }
}'
```
3. Run below curl to verify the alias association


```
curl --location --request GET 'localhost:9200/_alias/user_alias?pretty'
```
Note: Make sure alias is associated with only new index created that is userv3.

4. After reindexing , if alias is not already associated with new index, add alias to the new index with alias name as  **user_alias**  , using below curl


```
curl --location --request PUT 'localhost:9200/userv3/_alias/user_alias?pretty'
```
Note : If alias name changed other than  **user_alias,** update the learner env for  **user_index_alias** 

4. Delete alias from old index using below curl


```
curl --location --request DELETE 'localhost:9200/userv2/_alias/user_alias?pretty'
```




*****

[[category.storage-team]] 
[[category.confluence]] 
