
## Channel

* Channel is an entity in content-service(KP) against which framework, BGMS and contents are mapped.


* It has name, id/code, description.


* Channel id/code can be the Organisation id, or any dummy digits.


* It is independent of Organisation, but for portal or app to use it, the channel id needs to be mapped to organisation id.


* Channel abbreviation like 'tn','ka' are not used in content-service(KP)



Channel is a neo4j object, there is no tabular structure.

Channel specific schema:

[https://github.com/project-sunbird/knowledge-platform/blob/release-4.3.0/schemas/channel/1.0/schema.json](https://github.com/project-sunbird/knowledge-platform/blob/release-4.3.0/schemas/channel/1.0/schema.json)

Refer Channel API collection:

[https://www.getpostman.com/collections/bfbe5f196e39d2bdd41b](https://www.getpostman.com/collections/bfbe5f196e39d2bdd41b)


## Organisation

* It is an entity in learner service (UserOrg) against which all users are mapped.


* It has id, name, organisationtype, orglocation, isTenant, slug, channel, externalid.


* Slug and channel are abbreviation of organisation name, where slug is URL compatible, while channel is not.


* While creating org, channel is mandatory.


* There is a default Organisation which is termed as custodian org, which has slug and channel as 'dikshacustodian'.




## Dependency with organisation and channel 

### Learner service(UserOrg) - Content-service(KP)

* While creating an tenant organisation in learner service, organisationid is passed to channel API to register it as a channel in content-service.


* If channel is already existing in content-service then use the channel id/code as organisation id.


* While creating a non-tenant organisation, mention an existing tenant's channel. This channel's org id is searched before creating new organisation.


    * If tenant org need to be created channel is registered in content-service, also it should be unique.


    * If not tenant org, then channel should be internally mapped to a tenantorg by specifying the tenant org channel.



    


### Learner service(UserOrg) - Content-service(KP) - Portal

* Portal searches the tenant organisation using slug and this organisation id is passed in channel/v1/read to get the channel configurations and details from content-service. So tenant org and channel both are same for portal, only that different areas of channel is handled by content-service(content, framework, BGMS) and learner service(user, location,user details)s.


* Non-tenant organisation - channel relation is not used in portal


*  **Channel used in sso(state) login flow -> fetchUserWithExternalId, orgSearch (schoolsearch)** 




### Learner service(UserOrg) - Content-service(KP) - MobileApp

* App checks the user's rootorgid and slug to fetch the tenant organisation details from implementation team API.


* Non-tenant organisation - channel relation is not used in App.


*  **Channel used in sso(state) login flow -> fetchUserWithExternalId, orgSearch (schoolsearch)** 




### Learner service(UserOrg) - Content-service(KP) - Analytics

* Exhaust reports 



Exhaust reports are using org search API, and slug field from learner service


* Druid reports



Each channel has corresponding slug attached to it. According to that reports are generated from telemetry using druid.

created_by

created_for

dialcode_channel

org id is used

[https://docs.google.com/spreadsheets/d/1eimTaap99pll5e7f6LxqCe9CoGubweaSdRmd7TfeUbM/edit#gid=1715493561](https://docs.google.com/spreadsheets/d/1eimTaap99pll5e7f6LxqCe9CoGubweaSdRmd7TfeUbM/edit#gid=1715493561)

[https://docs.google.com/spreadsheets/d/1PjfkRZi2jmxkZ3Qitx52jAyQQpihOpjfvozWWIkDGmk/edit#gid=1872285301](https://docs.google.com/spreadsheets/d/1PjfkRZi2jmxkZ3Qitx52jAyQQpihOpjfvozWWIkDGmk/edit#gid=1872285301)


## Queries and Assumptions

* Check tenant org - non-tenant org relation can be removed or not?


* Can user-org db retain tenant orgs and content APIs can fetch the org id using org APIs?


* What happens if schools are added to custodian? this was what we did as part of ORG_001 before and now we are trying to clear data. same prob will happen again.


* What does it mean if the school belong to channel?


* Why don't we retain channel for a school? like for CBSE and ICSE school how to identify without channel?


* Why do we need to retain channel for school? can it be not a metadata of school? 

    channel can be a metadata of school and schools can be independent entities where we can identify them using location 

    Also are we not planning to decouple user and root org?


* Identifying school by channel will not be possible, we can remove channel and have only slug

    later we may have to bring in org vs tenant association



 **Suggestions:** 


* Tenant organisation can have only one channel


* Non-tenant organisation can have multiple channel or tenantorg mapped to it.


* For this either create a new column which supports multiple channel or create a new table which will map non-tenant orgs to tenants.


* This will help when there are 2 boards on same school. like one school having both state and cbse board syllabus.


* To decouple orgs and tenants - > we need to have channel for the org to know where it belongs to, so completely decoupling is not a good option. Currently we need to have a tenant to assign a channel in our system. we need to remove that dependency and check channel against content service. So we can have orgs which does not belong to a tenant but still have a channel mapped. Later, if we need to have a tenant for the same channel and orgs, we can create it.





*****

[[category.storage-team]] 
[[category.confluence]] 
