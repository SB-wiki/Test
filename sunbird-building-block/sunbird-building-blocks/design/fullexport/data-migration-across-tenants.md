 **Overview** As part of the ticket - [SB-9803](https://project-sunbird.atlassian.net/browse/SB-9803?oldIssueView=true), we are required to merge user/content of 2 tenants into 1. Earlier the state had created 2 tenants, both have users as well as content. There may be user-org associations in both tenants as well. As part of this story we need to migrate the data from one tenant to other, and then retire/close/delete the empty tenant.



 **Data** 

| Field | Shift From | Shift To | 
|  --- |  --- |  --- | 
| Root Org Id | 01241408242723225614 | 01246375399411712074 | 
| Name | ETB Pilot Rajasthan | Rajasthan | 
| Total Content | 6144 | 4271 | 
| Sub-organisations | 0 | 0 | 
| Course Batches | 7 | 0 | 
| Users | 179 | 237 | 
| Badge Extension Class | 0 | 0 | 
| channel | pilotrajasthan | rj | 

 **Approaches**  **Approach 1** We can provide a set of APIs using which one can migrate user, sub-org or content across the tenants (Root organization).



 **Pros** 


* User will not require the server access, can trigger API
* User can use different API's to build custom script, which is more flexible
* We can apply user-access control if it is considered as an API end-point.
* Does not require to bring the server down.

 **Cons** 


* It is a one-time administrative task, so providing API is little risky for such cases
* This API may not be useful for all users, and will bulk up the user-code unnecessarily.
* difficult to implement and more over-head considering it is one-time job.



 **Solution** 

 **API to migrate organisation** 

 **POST /v1/tenant/migrate**  - will migrate the sub-organizations, to point to new root-organization.


```
{
 "sourceRootOrgId" : "0101201012",
 "targeRootOrgId" : "0101201013",

  "entities" : \["user", "org", "content"]

  "userIds" : \["id1", "id2" ]
}
```


UserIds → if mentioned will be applicable to only those users, else to all users will be migrated.

entities → if mentioned only those will be migrated, else all entities will gt migrated.

 **Responses** 

 **200 OK -** both valid root-org are provided and data can be migrated

 **400 Bad Request -**  Invalid sourceRootOrgId or targetRootOrgId


* any of the org does not exist
* any of the org is not active
* any of the org is not a root-organization



Above API's will individually migrate the individual data



 **Approach 2** Provide a stand-alone script/migration job, which once invoked will migrate the data internally, with minimal user choices.

 **Pros** 


* Simple approach, easy to implement
* We do not have to expose such changes as API, as this is admin type of activity

 **Cons** 


* Very specific solution - not much configurable from user perspective
* User requires access to environment, as process will be run from background using environment variables.
* This requires that server. instance must be down, while we are doing this migrations.

 **Data to be migrated (Identified as per database storage)** 
* Child organization - Root org - may have other child organizations, we need to migrate those child organizations
* User's root-org need to be updated to new root-org
* Content data - channel name - need to be migrated according to new channel name.
* User-org association, for old root-org need to be deleted, and new user-org association need to be added
* geo_location data - which refers the root-org id also need to be migrated
* badge_class_extension - also refers to the root-org
* There are several storage structures which point to organisationid which need to be migrated if they are pointing to root-org which is being migrated.
    * course_management (organisationid, organisationname)
    * user_org(organisationid)
    * page_management (organisationid)
    * bulk_upload_process(organisationid)

    

 **Solution (Based on data analysis)** 
* Get all user ids for Rajasthan Pilot Organisation
* Update the rootOrgId, channel & slug for user ids fetched in above step.
* Get all user-org entries where associated org id is Rajasthan Pilot.
* Update the rootOrgId to point to Rajasthan root org.
* Sync the users updated to ElasticSearch index
* Get all course batches where  **createdFor**  is pointing to Rajasthan Pilot
* Update the course batches and set  **createdFor**  to Rajasthan
* Sync the course batch details to ElasticSearch index.
* Mark the Rajasthan Pilot Org → inactive status.

 **Assumptions** 
* Telemetry data will be pointing to according to old values for all the updates made so far, and will not be migrated.



*****

[[category.storage-team]] 
[[category.confluence]] 
