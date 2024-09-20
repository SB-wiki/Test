 **Dimensions:** 

| # | Dimensions in Druid | Field in Telemetry | Description | Datatype | 
|  --- |  --- |  --- |  --- |  --- | 
| 1 | eid | eid | Event Id | String | 
| 2 | context_channel | context.channel | Channel Id | String | 
| 3 | context_pdata_id | [context.pdata.id](http://context.pdata.id) | Producer Id | String | 
| 4 | context_pdata_pid | context.pdata.pid | Producer Process Id | String | 
| 5 | object_id | [object.id](http://object.id) | Content Id | String | 
| 6 | object_type | object.type | Content Type | String | 
| 7 | object_rollup_l1 | object.rollup.l1 | Content level 1 rollup | String | 
| 8 | content_board | contentdata.board | Board of affiliation | String | 
| 9 | content_name | [contentdata.name](http://contentdata.name) | Name of the content | String | 
| 10 | derived_loc_state | derivedlocationdata.state | Derived location state of the user | String | 
| 11 | derived_loc_district | derivedlocationdata.district | Derived location district of the user | String | 
| 12 | derived_loc_from | derivedlocationdata.from | Derived location | String | 
| 13 | collection_name | [collectiondata.name](http://collectiondata.name) | Name of the collection (Denormalised for object.rollup.l1 field) | String | 
| 14 | collection_type | collectiondata.contenttype | Type of the resource | String | 
| 15 | collection_board | collectiondata.board | Board of affiliation | String | 
| 16 | dialcode_channel | dialcodedata.channel | Channel for which dialcode is generated | String | 
| 17 | user_type | userdata.type | Type of user | String | 
| 18 | user_signin_type | userdata.usersignintype | User sign-in type info | String | 
| 19 | edata_item_id | [edata.item.id](http://edata.item.id) | ASSESS event Assessment item id | String | 
| 20 | edata_item_title | edata.item.title | ASSESS event Assessment item title | String | 
| 21 | edata_state | edata.state | AUDIT event current state | String | 

 **Metrics:** 

| # | Dimensions in Druid | Field in Telemetry | Description | Datatype | 
|  --- |  --- |  --- |  --- |  --- | 
| 1 | total_count | NA | count(\*) | Long | 
| 2 | total_edata_duration | edata.duration | Rolled up metric - sum(edata.duration) | Double | 
| 3 | total_edata_rating | edata.rating | Rolled up metric - sum(edata.rating) | Double | 
| 4 | total_edata_score | edata.score | Rolled up metric - sum(edata.score) | Double | 
| 5 | total_max_score | edata.item.maxscore | Rolled up metric - sum(edata.item.maxscore) | Double | 





*****

[[category.storage-team]] 
[[category.confluence]] 
