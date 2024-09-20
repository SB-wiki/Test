
## Introduction
This wiki page details the various exhaust files available as part of the trackable collections and their respective format/structure & file nomenclature. Following are the available exhausts for a trackable collection:


1. Progress Exhaust


1. User Info Exhaust


1. Response Exhaust




## Progress Exhaust
Progress exhaust contains the progress related information for the collection and the nested collections including the assessment related scores of the collection. The nested collections and the assessments within the collection will be transposed as columns and hence the columns for each collection exhaust file would vary


### File Structure


|  **Format**  |  **Nomenclature**  |  **Example**  | 
|  --- |  --- |  --- | 
|  **CSV**  |  **_<batch_id>_progress_<updatedDate>.csv_**  |  **_do_1130264512015646721166__progress__26_08_2020.csv_**  | 


### File Contents


|  **Column Label**  |  **Column Type**  |  **Data Type**  |  **Description**  | 
|  --- |  --- |  --- |  --- | 
| Collection Id | Static | String | Id of the collection. | 
| Collection Name | Static | String | Collection Title | 
| Batch Id | Static | String | Batch Id | 
| Batch Name | Static | String | Batch Title | 
| User UUID | Static | String | The system generated DIKSHA unique user ID | 
| User Name | Static | String | Name of the user | 
| State | Static | String | User declared state for self signed up users. If the user is a state validated user then the state as passed from state SSO or derived from school ID. | 
| District | Static | String | User declared district for self signed up users. If the user is a state validated user then the district as passed from state SSO or derived from school ID. | 
| Enrolment Date | Static | Date | Collection enrolment date (for nested courses/collections it will be the parent collection enrolment date) | 
| Completion Date | Static | Date | Collection completion date (for nested courses/collections it will be the parent collection completion date) | 
| Progress | Static | Number | Collection progress (for nested courses/collections this will be the parent collection progress) | 
| Certificate Status | Static | String | Issued - if the certificate is issued. Blank - if it is not issued and. Failed - if issue has failed | 
| Total Score | Static | Number | Total Score received by the user across all assessments within the collection with category type as “SelfAssess” | 
| <nested_collection_id> - Progress | Dynamic | Number | User’s progress at a nested collection level. This is a dynamic column. For ex: If there are 3 nested trackable collections within the parent collection there will be 3 corresponding columns | 
| <nested_collection_id> - Level | Dynamic | String | The collection level within the parent collection for this specific collection id. Format would be like “1.1“, “2.1”, “3.1.2” etc. | 
| <assessment_id> - Score | Dynamic | Number | User’s best attempt for the given assessment id. This is a dynamic column. For ex: If there are 3 assessments within the parent collection there will be 3 corresponding columns | 


### Sample Data

```text
Collection Id,Collection Name,Batch Id,Batch Name,User UUID,User Name,State,District,Enrolment Date,Completion Date,Progress,Certificate Status,Total Score,do_1130934418641469441813 - Progress,do_1130934418641469441813 - Level,do_1130934445218283521816 - Progress,do_1130934445218283521816 - Level,do_1130934418641469441786-score
do_1130934466492252161819,Test Course,0130934495109529602,Batch1,f703de4e-d47a-4adb-856c-de122e6a0b32,Mathew Pallan,"Kerala","Thrissur",2020-08-25 13:45:54:150+0000,2020-08-27 13:45:54:150+0000,100,"Issued",7,100,"1.1",100,"1.2",7
do_1130934466492252161819,Test Course,0130934495109529602,Batch1,587204af-41db-4313-b3ab-cf022d3055c6,Krishna Jampana,"Andhra Pradesh","Vizag",2020-08-25 02:15:58:691+0000,"",57,"",6,50,"1.1",60,"1.2",6
```

## User Personal Info Exhaust
User personal info exhaust contains the additional information of the users that have joined the collection. The information contains personal details such as Email, Phone number etc and all such personal information is provided only on explicit consent by the user.


### File Structure


|  **Format**  |  **Nomenclature**  |  **Example**  | 
|  --- |  --- |  --- | 
|  **CSV zip (Password protected)**  |  **_<batch_id>_userinfo_<updatedDate>.zip_**  |  **_do_1130264512015646721166_userinfo_26_08_2020.zip_**  | 


### File Contents


|  **Column Label**  |  **Column Type**  |  **Data Type**  |  **Description**  | 
|  --- |  --- |  --- |  --- | 
| Collection Id | Static | String | Id of the collection. | 
| Collection Name | Static | String | Collection Title | 
| Batch Id | Static | String | Batch Id | 
| Batch Name | Static | String | Batch Title | 
| User UUID | Static | String | The system generated DIKSHA unique user ID | 
| User Name | Static | String | Name of the user | 
| State | Static | String | User declared state for self signed up users. If the user is a state validated user then the state as passed from state SSO or derived from school ID. | 
| District | Static | String | User declared district for self signed up users. If the user is a state validated user then the district as passed from state SSO or derived from school ID. | 
| Org Name | Static | String | Name of user org - DIKSHA Custodian for self signed up users and respective tenant names for state validated users | 
| External ID | Static | Number | Self declared users this is their declared ID. For state validated users this is their Teacher ID | 
| School Id | Static | String | If user is state validated teacher then the school ID mapped to this user. If user is self declared user then the user declared school ID. | 
| School Name | Static | String | If user is state validated teacher then the school name mapped to this user. If user is self declared user then the user declared org/school name. | 
| Block Name | Static | String | Block name mapped to the user’s org/school id | 
| Declared Board | Static | String | The board selected by the user during onboarding. | 
| Declared Org | Static | String | If the user is a self signed up user then this is the value filled by the user in the 'With' part of the self signed up declaration.  | 
| Mobile Number | Static | String | User declared unmasked mobile number | 
| Email ID | Static | String | User declared unmasked email ID | 
| Consent Provided | Static | String | Yes/No. Flag to denote whether user has consented to the data sharing. | 
| Consent Provided Date | Static | Date | Date when the user has consented to share the data | 


### Consent Fields
Following are the fields/columns that will be available in the file only when the user consented for the data sharing.



|  **Columns**  | 
|  --- | 
| External ID | 
| School ID | 
| School Name | 
| Block Name | 
| Mobile number | 
| Email ID | 


### Sample Data

```text
Collection Id,Collection Name,Batch Id,Batch Name,DIKSHA UUID,User Name,State,District,Persona,Org Name,External ID,School Id,School Name,Block Name,Declared Board,Mobile number,Email ID,Consent Provided,Consent Provided Date
do_1130934466492252161819,Test Course,0130934495109529602,Batch1,f703de4e-d47a-4adb-856c-de122e6a0b32,Mathew Pallan,"Kerala","Thrissur","Other",CustROOTOrg10,"","","","","Kerala","","","No",""
do_1130934466492252161819,Test Course,0130934495109529602,Batch1,587204af-41db-4313-b3ab-cf022d3055c6,Krishna Jampana,"Andhra Pradesh","Vizag",Apekx,"apekx1234","1234","Kendriya Vidyalaya","Block1","AP","1234567890","test@test.com","Yes",2020-08-25 13:45:54:150+0000
```

## Response Exhaust
Response exhaust contains the user responses to each question for all question sets in a trackable collection.


### File Structure


|  **Format**  |  **Nomenclature**  |  **Example**  | 
|  --- |  --- |  --- | 
|  **CSV**  |  **_<batch_id>_response_<updatedDate>.csv_**  |  **_do_1130264512015646721166_response_26_08_2020.csv_**  | 


### File Contents


|  **Column Label**  |  **Column Type**  |  **Data Type**  |  **Description**  | 
|  --- |  --- |  --- |  --- | 
| Collection Id | Static | String | Id of the collection. | 
| Collection Name | Static | String | Collection Title | 
| Batch Id | Static | String | Batch Id | 
| Batch Name | Static | String | Batch Title | 
| User UUID | Static | String | The system generated DIKSHA unique user ID | 
| User Name | Static | String | Name of the user | 
| QuestionSet Id | Static | String | Id of the question set | 
| QuestionSet Title | Static | String | Title of the question set | 
| Attempt Id | Static | String | Id of the attempt. There can be more than one attempt for the same question set | 
| Attempted On | Static | DateTime | Date on which the last attempt happened for this attempt id | 
| Question Id | Static | String | Question id | 
| Question Type | Static | String | Question type - mcq/mtf/mmcq/ftb | 
| Question Title | Static | String | Title of the question | 
| Question Description | Static | String | Description of the question | 
| Question Duration | Static | Number | Time taken to answer the question | 
| Question Score | Static | Number | Score received for the question | 
| Question Max Score | Static | Number | Max applicable score for the question | 
| Question Options | Static | JSON | Options shown to the user | 
| Question Response | Static | JSON | Responses given by the user | 


### Consent Fields
Following are the fields/columns that will be available in the file only when the user consented for the data sharing if the Question/QuestionSet type is “Registration”



|  **Columns**  | 
|  --- | 
| Question Response | 


### Sample Data

```text
Collection Id,Collection Name,Batch Id,Batch Name,DIKSHA UUID,User Name,QuestionSet Id,QuestionSet Title,Attempt Id,Attempted On,Question Id,Question Type,Question Title,Question Description,Question Duration,Question Score,Question Max Score,Question Options,Question Response
do_1130934466492252161819,Test Course,0130934495109529602,Batch1,f703de4e-d47a-4adb-856c-de122e6a0b32,Mathew Pallan,do_1126980913198940161169,"Test Questionset",85b32814c2680581f9447c0b792dc2a3,2020-01-09 05:47:44,do_2129194942597447681595,mcq,"Which planet has the most Moons?\n","",3.0,0,1,"[{'1': '{""text"":""Venus\n""}'}]","[{'1': '{""text"":""Venus\n""}'}, {'2': '{""text"":""Jupiter\n""}'}, {'3': '{""text"":""Mercury\n""}'}, {'4': '{""text"":""None of the above\n""}'}, {'answer': '{""correct"":[""2""]}'}]"
do_1130934466492252161819,Test Course,0130934495109529602,Batch1,587204af-41db-4313-b3ab-cf022d3055c6,Krishna Jampana,do_1126980913198940161169,"Test Questionset",85b328331c2680581f9447c0b792dc2a4,2020-01-09 05:47:44,do_2129194942597447681595,mcq,"Which planet has the most Moons?\n","",4.0,1,1,"[{'2': '{""text"":""Jupiter\n""}'}]","[{'1': '{""text"":""Venus\n""}'}, {'2': '{""text"":""Jupiter\n""}'}, {'3': '{""text"":""Mercury\n""}'}, {'4': '{""text"":""None of the above\n""}'}, {'answer': '{""correct"":[""2""]}'}]"
```




*****

[[category.storage-team]] 
[[category.confluence]] 
