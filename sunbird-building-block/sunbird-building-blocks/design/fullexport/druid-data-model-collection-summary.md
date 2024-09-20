
## Data Model: 


|  |  **Dimension In Druid**  |  **Field In Report**  |  **Description**  |  **Data Type**  | 
|  --- |  --- |  --- |  --- |  --- | 
| 1 | content_org | organisation | Published By or Course Publisher Name or tenant | String | 
| 2 | user_org | orgname | User Organisation name | String | 
| 3 | batch_id | batchid | Unique Batch Identifier | String | 
| 4 | collection_id | courseid | Unique Collection Identifier | String | 
| 5 | batch_start_date | startdate | Start Date of the Batch | String | 
| 6 | batch_end_date | enddate | End Date of the Batch | String | 
| 7 | collection_name | collectionname | Name of Course | String | 
| 8 | batch_name | batchname | Name of the batch | String | 
| 9 | total_enrolment | enrolleduserscount | The number of users are enrolled for the course. | Long | 
| 10 | total_completion | completionuserscount | The number of users have completed the course | Long | 
| 11 | total_certificates_issued | certificateissuedcount | The number of users received the certificate in course | Long | 
| 12 | content_status | contentstatus | State of Course. Ex: Live, Draft, etc. | String | 
| 13 | user_state | state | Name of The State | String | 
| 14 | user_district | district | Name of the District | String | 
| 15 | content_channel | channel | Name of the Channel | String | 
| 16 | keywords | keywords | Keywords/Tags which are assigned to course | List\[String] | 
| 17 | timestamp | timestamp | TimeStamp of when the report is generated. | Long | 
| 18 | content_channel | channel | Channel of the collection/course | String | 
| 19 | has_certificate | hascertified | Whether batch is certified or not | Boolean | 







*****

[[category.storage-team]] 
[[category.confluence]] 
