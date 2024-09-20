
#  **Objective** 
Making the installation process of course service easier by decoupling the external dependencies.Current course service is using user org service for some user validation and we make few druid service calls along with some other external dependencies.From this feature, other building block dependencies will be decoupled.

 **Dependencies and Approach to Decouple:** 

|  **Method name / File name / Service name**  |  **Dependency / URLs/Variables**  |  **Approach**  | 
|  --- |  --- |  --- | 
|  **externalresource.properties**  |  **URL’s:** 
```
content_url=/content/v3/hierarchy/
ekstep_course_publish_url=/content/v3/publish
ekstep_metrics_api_url=/metrics/consumption/content-usage
ekstep_es_metrics_api_url=/metrics/creation/content-snapshot
ekstep_concept_base_url=/domain/v3/{domain}/concepts/list
ekstep_domain_url=/domain/v3/list
sunbird_app_url=
ekstep.channel.reg.api.url=/channel/v3/create
ekstep.channel.update.api.url=/channel/v3/update
sunbird_learner_service_url=http://localhost:9000
sunbird_lms_base_url=http://localhost:9000
sunbird_telemetry_base_url=http://localhost:9000
sunbird_linked_content_base_url=https://dev.sunbirded.org/play/content/
sunbird_cert_download_uri=/v1/user/certs/download
```
 **Variables:** 
```none
quartz_course_batch_timer=0 0 0/4 1/1 * ? *
quartz_upload_timer=0 0 23 1/1 * ? *
quartz_course_publish_timer=0 0 0/1 1/1 * ? *
quartz_matrix_report_timer=0 0 0/4 1/1 * ? *
quartz_shadow_user_migration_timer=0 0 2 1/1 * ? *
sunbird_encryption_mode=local
quartz_metrics_timer =0 0 0/4 * * ? *
default_date_range=7
quartz_update_user_count_timer=0 0 2 1/1 * ? *
sunbird_url_shortner_access_token=
quartz_channel_reg_timer=0 0 1 1/1 * ? *
sunbird_otp_allowed_attempt=2
sunbird_lms_authorization=
sunbird_installation_email=dummy@dummy.org
sunbird_otp_hour_rate_limit=5
sunbird_otp_day_rate_limit=20
sunbird_user_create_sync_type=ES
sunbird_user_create_sync_topic=local.user.events
sigterm_stop_delay=40
sunbird_msg_sender=
sunbird_msg_91_auth=
sunbird_valid_location_types=state,district,block;cluster
sunbird_default_user_type=teacher
sunbird_app_name="Sunbird"
sunbird_email_max_recipients_limit=100
sunbird_user_max_encryption_limit=100
sunbird_rate_limit_enabled=true
sunbird_course_metrics_container=reports
sunbird_course_metrics_report_folder=course-progress-reports
sunbird_assessment_report_folder=assessment-reports
sunbird_cache_enable=false
sunbird_audit_event_batch_allowed=false
sunbird_fuzzy_search_threshold=0.5
sunbird_reset_pass_msg=Your have requested to reset password. Click on the link to set a password: {0}
sunbird_reset_pass_mail_subject=Reset Password
sunbird_subdomain_keycloak_base_url=https://merge.dev.sunbirded.org/auth/
sunbird_account_merge_body=All your {0} usage details are merged into your account {1} . The account {2} has been deleted
sunbird_user_upload_error_visualization_threshold=20001
sunbird_course_completion_certificate_name=100PercentCompletionCertificate
sunbird_migrate_user_body=You can now access your {0} state teacher account using {1}. Please log out and login once again to see updated details.
sunbird_account_merge_subject=Account merged successfully
user_relations=address,education,jobProfileorgUser
org_relations=orgUser,address
```
 **API Calls:** 
```
sunbird_channel_read_api=/v1/channel/read
sunbird_framework_read_api=/v1/framework/read
sunbird_telemetry_api_path=/v1/telemetry
```
 | Remove the unused URL's,variables and API calls from the externalresource.properties other than course/batch service building block. | 
|  **User org service - Search org**  **getOrganisationById**  |  **getOrganisationById:** <ul><li> **PageManagementActor:** 

</li></ul>
1.  **_validateOrg_** .getOrganisationById



<ul><li> **CourseBatchManagementActor:** 

</li></ul>
1.  **_isOrgValid_** .getOrganisationById



We are passing the  **organisation id**  as the parameter in the request to the  **org search API**  of user org service and in the response if we have the  **CONTENT**  part and a value of for the  **id(highlighted in red).**  we are proceeding with creating the page or else we throw exception as organisation id is invalid. **API:** sunbird_search_organisation_api=/v1/org/search **Request:** 
```
{    "request": {        "filters": {            "rootOrgId": "0136556642643394560"        },        "limit": 100    }}
```
 **Response :** 
```
{  "id": "api.org.search",  "ver": "v1",  "ts": "2020-11-23 09:16:58:628+0000",  "params": {    "resmsgid": null,    "msgid": "ad7135b8-ef64-44bd-adaa-0b131a657689",    "err": null,    "status": "success",    "errmsg": null  },  "responseCode": "OK",  "result": {    "response": {      "count": 1,      "content": [        {          "dateTime": null,          "preferredLanguage": null,          "keys": {},          "channel"": "ChannelNew",          "approvedBy": null,          "description": "Updated Description",          "updatedDate": "2020-12-01 10:29:49:496+0000",          "addressId": "0131630420489011201",          "provider": "channelnew",          "orgCode": null,          "locationId": null,          "theme": null,          "id": "0131630445447741440",          "isApproved": null,          "communityId": null,          "slug": "channelnew",          "email": "info@org.org",          "isSSOEnabled": false,          "identifier": "0131630445447741440",          "thumbnail": null,          "updatedBy"": null,          "orgName": "Org Name",          "address": {},          "externalId": "extid",          "rootOrgId": "0131630445447741440",          "imgUrl": null,          "approvedDate": null,          "homeUrl": null,          "isDefault": null,          "createdDate": "2020-12-01 09:52:46:962+0000",          "createdBy": null,          "hashTagId": "0131630445447741440",          "noOfMembers": null,          "status": 0,          "orgLocation": [            {              "id": "9541f516-4c01-4322-aa06-4062687a0ce5",              "type": "block"            },            {              "id": "6dd69f1c-ba40-4b3b-8981-4fb6813c5e71",              "type": "district"            },            {              "id": "e9207c22-41cf-4a0d-81fb-1fbe3e34ae24",              "type": "cluster"            },            {              "id": "ccc7be29-8e40-4d0a-915b-26ec9228ac4a",              "type": "state"            }          ],          "organisationType": 2,          "isSchool": true,          "isTenant": true        }      ]    }  }}
```
 |  | 
|  **User org service - read user**   **getUsersByIds**  and  **getUserById**  |  **getUsersByIds:** <ul><li> **SearchHandlerActor:** 

</li></ul>
1.  **_populateCreatorDetails_** .getUsersByIds



<ul><li> **CourseBatchManagementActor** 

</li></ul>
1.  **_validateMentors_** .getUsersByIds



<ul><li> **BulkUploadBackGroundJobActor:** 

</li></ul>
1.  **_validateBatchUserListAndAdd._** getUsersByIds



 **getUserById:** <ul><li> **CourseBatchManagementActor** 

</li></ul> **_getRootOrg_** .getUsersById : We pass the id and auth token to   **getUsersById** to get this user info in response,and from this response map we get the  **rootOrgId** .         **API:** /private/user/v1/read/02bb0640-ae41-41f3-853c-0c0b2f481ffa **Response:** 
```
{    "id": ".private.user.v1.read.02bb0640-ae41-41f3-853c-0c0b2f481ffa",    "ver": "private",    "ts": "2022-12-02 11:23:30:811+0530",    "params": {        "resmsgid": "50ffd259-4aa3-4fe1-806a-79f53b61e8ed",        "msgid": "50ffd259-4aa3-4fe1-806a-79f53b61e8ed",        "err": null,        "status": "SUCCESS",        "errmsg": null    },    "responseCode": "OK",    "result": {        "response": {            "webPages": null,            "maskedPhone": null,            "tcStatus": null,            "loginId": null,            "subject": null,            "channel": "channel1003",            "profileUserTypes": [],            "language": null,            "updatedDate": null,            "password": null,            "managedBy": null,            "flagsValue": 0,            "id": "02bb0640-ae41-41f3-853c-0c0b2f481ffa",            "recoveryEmail": "",            "identifier": "02bb0640-ae41-41f3-853c-0c0b2f481ffa",            "thumbnail": null,            "profileVisibility": null,            "updatedBy": null,            "accesscode": null,            "locationIds": [],            "registryId": null,            "rootOrgId": "0136549971190415360",            "prevUsedEmail": "",            "firstName": "aiman",            "profileLocation": [],            "tncAcceptedOn": null,            "allTncAccepted": {},            "profileDetails": null,            "phone": "",            "dob": null,            "grade": null,            "currentLoginTime": null,            "userType": null,            "status": 1,            "lastName": "sharief",            "gender": null,            "prevUsedPhone": "",            "stateValidated": false,            "encEmail": "AoonPTnXx8T3Ucm6ao43sXhB1mMb5i9dnfudxp9Hw9fv1RPqp/kWL5G3nE9RtFrmtI2mAX3cCv8h\nxrqrXEQNwVDO27LxvyimzUrhOaudAZ+G3CTlL91leS+gNyM2uF+aTQtMGOn7lhkDdxs1iV8l8A==",            "isDeleted": false,            "organisations": [                {                    "isSelfDeclaration": false,                    "organisationId": "0136549971190415360",                    "updatedBy": null,                    "addedByName": null,                    "addedBy": null,                    "associationType": 1,                    "approvedBy": null,                    "updatedDate": null,                    "userId": "02bb0640-ae41-41f3-853c-0c0b2f481ffa",                    "approvaldate": null,                    "isSystemUpload": false,                    "isDeleted": false,                    "hashTagId": "0136549971190415360",                    "isSSO": true,                    "isRejected": null,                    "id": "0136555060112424960",                    "position": null,                    "isApproved": null,                    "orgjoindate": "2022-10-28 10:02:03:290+0530",                    "orgLeftDate": null                }            ],            "provider": null,            "countryCode": null,            "maskedEmail": "ai**********@yopmail.com",            "tempPassword": null,            "email": "ai**********@yopmail.com",            "rootOrg": {                "dateTime": null,                "preferredLanguage": null,                "keys": {},                "organisationSubType": null,                "approvedBy": null,                "channel": "Channel",                "description": "Description",                "updatedDate": null,                "addressId": null,                "organisationType": 2,                "orgType": null,                "isTenant": true,                "provider": "channel",                "locationId": null,                "orgCode": null,                "theme": null,                "id": "0136549971190415360",                "isApproved": null,                "communityId": null,                "email": "info@org.org",                "slug": "channel",                "isSSOEnabled": true,                "thumbnail": null,                "orgName": "Sunbird_aiman",                "updatedBy": null,                "locationIds": [],                "externalId": "extid",                "orgLocation": [],                "isRootOrg": null,                "rootOrgId": "0136549971190415360",                "approvedDate": null,                "imgUrl": null,                "isSchool": true,                "homeUrl": null,                "orgTypeId": null,                "isDefault": null,                "createdDate": "2022-10-27 16:39:30:243+0530",                "createdBy": "12345",                "parentOrgId": null,                "hashTagId": "0136549971190415360",                "noOfMembers": null,                "status": 1            },            "phoneVerified": true,            "profileSummary": null,            "tcUpdatedDate": null,            "recoveryPhone": "",            "avatar": null,            "userName": "aimansharief",            "userId": "02bb0640-ae41-41f3-853c-0c0b2f481ffa",            "userSubType": null,            "emailVerified": true,            "lastLoginTime": null,            "createdDate": "2022-10-28 10:02:03:141+0530",            "framework": {},            "createdBy": "12345",            "profileUserType": {},            "encPhone": null,            "location": null,            "tncAcceptedVersion": null        }    }}
```
 |  | 
|  **Notification Service**  |  **sendEmailNotification:** <ul><li> **CourseBatchNotificationActor:** 

</li></ul>
1.  **sendMail.sendEmailNotification** 



 **API Used:** sunbird_send_email_notifictaion_api=/v1/notification/email **Template,authtoken**  **Request:** 
```
{    "request": {        "subject": "subject",        "emailTemplateType": "template",        "body": "Notification mail Body",        "orgName": "orgName",        "courseLogoUrl": "appIcon",        "startDate": "startDate",        "endDate": "endDate",        "courseid": "courseid",        "batchName": "batchName",        "courseName": "name",        "courseBatchUrl": "https://dev.sunbirded.org/learn/course/courseId/batch/batchId",        "signature": "sunbird_course_batch_notification_signature",        "recipientUserIds": "userId"    }}
```
 **Response:** 
```
Response:{     "id": "api.notification.email",     "ver": "v1",     "ts": "2020-12-06 21:05:11:142+0530",     "params": {         "resmsgid": null,         "msgid": "3c8bd215-4b02-4b9a-a419-7462fc525a73",         "err": null,         "status": "success",         "errmsg": null     },     "responseCode": "OK",     "result": {         "response": "SUCCESS"     } }
```
 |  | 
|  **Unused methods/URLs:**  | getOrganisationsByIds getUsers sunbird_search_user_api=/v1/user/search LearnerServiceUrls.java |  | 
|  **Druid Service Calls**  |  **CollectionSummaryAggregate.Scala:** <ul><li> **getResponseFromDruid** 

</li></ul> **Variables:** druid_proxy_api_host=localhostdruid_proxy_api_port=8082druid_proxy_api_endpoint=/druid/v2/ |  | 





*****

[[category.storage-team]] 
[[category.confluence]] 
