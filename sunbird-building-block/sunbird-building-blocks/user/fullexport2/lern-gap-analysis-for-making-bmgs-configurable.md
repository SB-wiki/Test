
# Introduction :
This document describes the design approach of BMGS removal in the portal.


## Existing workflow:
In LERN, there are multiple services and flink jobs are involved in user creation to course consumption. In this flow, BMGS act as metadata to the entities in the platform.


## Problem statement:
Current design is tied up with the BMGS framework which lead to tied coupling of framework, The aim is to support the generic framework which should result in supporting the wide variety of use cases. Eg. Agriculture, Health etc.


## Analysis and Solution
LERN workflow and solutions are presented below.


### Workflow Analysis


|  **Workflow**  |  **Service**  |  **API involved**  |  **Can work without code change**  |  **Small change or configuration**  |  **Design Required/Big Change in code**  |  **Testing Status**  | 
| User signup | Userorg service | learner/user/v2/signup | Yes |  |  | Done | 
| User update | Userorg service | learner/user/v3/updateFlink job: user-cache-updater-v2 | Yes | Small code change is required in flink job |  | Done | 
| User read | Userorg service | user/v5/read/ | Yes | Small code change is required |  | Done | 
| batch creation | LMS service | course/v1/batch/create discussion/forum/v3/create certreg/v1/template/add course/v1/batch/read/ | Yes | Elasticsearch is index the data. The index mapping files are available in devops repo[https://github.com/project-sunbird/sunbird-devops/tree/release-5.3.0-lern/ansible/roles/es-mapping/](https://github.com/project-sunbird/sunbird-devops/tree/release-5.3.0-lern/ansible/roles/es-mapping/)This can be updated to take different fields or can be removed if not required |  | Inprogress | 
| Course consumption | LMS service | JOIN COURSE - course/v1/enrolCONSENT UPDATE - learner/user/v1/consent/updateContent state update - content/course/v1/content/state/updateContent consumption state - course/v1/content/state/read | Yes | Elasticsearch is index the data. The index mapping files are available in devops repo[https://github.com/project-sunbird/sunbird-devops/tree/release-5.3.0-lern/ansible/roles/es-mapping/](https://github.com/project-sunbird/sunbird-devops/tree/release-5.3.0-lern/ansible/roles/es-mapping/)This can be updated to take different fields or can be removed if not required |  | Inprogress | 
| Certficate Generation | LMS service | Flink jobs Certificate-preprocessor certificate generator assessment-aggregator activity-aggregate-updater | Yes |  |  |  | 
| Certificate reissue | LMS service | certreg/v1/cert/reissue | Yes |  |  |  | 
| Learner passbook | LMS service | course/v1/user/enrollment/list | Yes |  |  |  | 
| Exhaust reports(Data-products) | LMS service |  |  |  | Data-products is tightly binded with BMGS columsn |  | 
| State admin reports(Data-products) | Userorg service |  |  |  | Data-products is tightly binded with BMGS columsn |  | 
| Migration jobs(Data-products) | LMS service |  |  |  | Data-products is tightly binded with BMGS columsn |  | 
| User cache updater job(Data-products) | Userorg service |  |  |  | Data-products is tightly binded with BMGS columsn |  | 


###  Code locations of BMGS mentions in LERN


|  **Functionality**  |  **Repo**  |  **entity**  |  **analysis**  |  **Impact**  |  **Comment**  | 
| User creation & update | userorg-service | BMGS | service/src/main/java/org/sunbird/util/Util.java |  | There is only one place where grade and subject name is hardcoded to create the user object with default value | 
|  | BMGS | controller/doc/api/collections/userapi.yaml | The API document has the BMGS fields for the API request payload | BMGS is loaded to user data by schema validation from request payload | 
|  | BMGS | check levels of BMGS present | There is no place any of the entity of BMGS is associated any other value of it’s |  | 
| Batch creation/ enrolment | lms-service | BMGS | course-mw/sunbird-util/sunbird-es-utils/src/main/resources/indices/ | Elasticsearch index mapping has BMGS index config | [https://github.com/project-sunbird/sunbird-devops/blob/release-5.3.0-lern/ansible/roles/es-mapping/](https://github.com/project-sunbird/sunbird-devops/blob/release-5.3.0-lern/ansible/roles/es-mapping/) | 
|  | boaard | course-mw/course-actors-common/src/main/java/org/sunbird/learner/actors/PageManagementActor.java | Creates userprofileprop list |  | 
|  | BMGS | check levels of BMGS present | There is no place any of the entity of BMGS is associated any other value of it’s |  | 
| Certificate workflow | Certificate workflow | BMGS | BMGS is not involved in the certificate generation workflow |  |  | 
| data-pipeline | BMGS | user-org-jobs/user-cache-updater-2.0/src/main/scala/org/sunbird/dp/usercache/util/UserMetadataUpdater.scala | To update the user cache in redis the BMGS values are taken and updated to user object. |  | 
| Group+ Activity / Search fields | Group service | BMGS | group-actors/src/main/resources/activityConfig.json | Activity config is used to get the search service class and get the fields list for the search content | need to check if that activityConfig can be configurable. because it is directly mentioned as file in the project folder | 
| Report Generation | data-products | BMGS |  |  |  | 
| Notification | Notification service | BMGS | No place is having any of BMGS value |  |  | 



*****

[[category.storage-team]] 
[[category.confluence]] 
