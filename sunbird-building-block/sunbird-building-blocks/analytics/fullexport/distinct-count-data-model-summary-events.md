 **Dimensions:** 

| # | Dimension in Druid | Field in Telemetry | Description | Datatype | 
|  --- |  --- |  --- |  --- |  --- | 
| 1 | ets | context_date_range_to | Event timestamp | Long | 
| 2 | dimensions_channel | dimensions.channel | Channel Id as dimension from raw telemetry | String | 
| 3 | dimensions_pdata_id | [dimensions.pdata.id](http://dimensions.pdata.id) | Producer Id as dimension from raw telemetry | String | 
| 4 | dimensions_pdata_ver | dimensions.pdata.ver | Producer version number | String | 
| 5 | dimensions_type | dimensions.type | Type of summary | String | 
| 6 | dimensions_mode | dimensions.mode | Mode of the summary | String | 
| 7 | content_board | contentdata.board | Mode of action in the session | String | 
| 8 | content_name | [contentdata.name](http://contentdata.name) | Name of the content | String | 
| 9 | content_type | contentdata.contenttype | Type of the resource | String | 
| 10 | content_gradelevel | contendata.gradelevel | Type of gradelevel | String | 
| 11 | object_id | [object.id](http://object.id) | Content Id | String | 
| 12 | object_rollup_l1 | object.rollup.l1 | Object level1 rollup | String | 
| 13 | derived_loc_state | derivedlocationdata.state | Derived location state of the user | String | 
| 14 | derived_loc_district | derivedlocationdata.district | Derived location district of the user | String | 

 **Metrics:** 

| # | Dimension in Druid | Field in Telemetry | Description | Datatype | 
|  --- |  --- |  --- |  --- |  --- | 
| 1 | unique_devices | dimenstion_did | HLLSketchBuild | No of unique devices | 
| 2 | unique_users | actor_id | HLLSketchBuild | No of unique users | 





*****

[[category.storage-team]] 
[[category.confluence]] 
