API Manager Kong is an API Management tool used to manage the API’s with Authentication to them and enforce rate limiting per API.

We have 2 main parts in API Manger kong.


1. [Onboarding API’s.](https://project-sunbird.atlassian.net/wiki/spaces/DevOps/pages/1205207131/Onboarding+API%27s)


1. [Onboarding Consumers.](https://project-sunbird.atlassian.net/wiki/spaces/DevOps/pages/1202847861/Onboarding+Consumers)




# GUIDELINES TO MERGE PR FOR API OR CONSUMER CREATIONS/UPDATIONS.

## Review For API Onboarding
Anyone who is authorized to merge the PR for  **any API related changes** has to make sure that the below mentioned standards are met.


* The API has the correct name as the functionality of the API is concerned.


* request PATH and UPSTREAM url is variablized and using the correct prefix for that service as mentioned in this [document](https://project-sunbird.atlassian.net/wiki/spaces/DevOps/pages/1205207131/Best+Practces+For+Onboarding+API%27s+In+Sunbird).


* It is having correct authorization, rate limits, request-size as mentioned in this [document](https://project-sunbird.atlassian.net/wiki/spaces/DevOps/pages/1205207131/Best+Practces+For+Onboarding+API%27s+In+Sunbird).


*  **It has the correct ACL and is not violating the roles and entities as mentioned in table of this** [ **document** ](https://project-sunbird.atlassian.net/wiki/spaces/DevOps/pages/1202847861/Best+Practces+For+Onboarding+Consumers+In+Sunbird) **.** 


*  **Check if there is any impact on the ACL which is applied to the existing consumers which are onboarded specifically for external consumers. Make sure the ACL for the API will not provide elevated permission to the existing consumers** .




## Review For Consumer Onboarding
Anyone who is authorized to merge the PR for  **any CONSUMER related changes** has to make sure that the below mentioned standards are met.


*  **Make sure you have a list of all the consumers onboarded in the system and are tracked.** 


* Any New consumer which will be onboarded will  have to go through a design review.


* Make sure you analyze the risk of providing access to consumers and soley trust them with ACL’s you are attaching to them.


*  **Never Give access to an app consumer for the SuperAdmin ACL.** 


*  Have your consumers are categorized as mentioned in this [ **document** ](https://project-sunbird.atlassian.net/wiki/spaces/DevOps/pages/1202847861/Best+Practces+For+Onboarding+Consumers+In+Sunbird) **.** 


*  **You Must not provide access to SuperAdmin role to Any Consumer whether be it internal/Application. Only rare case we will be providing Access to Consumers with SuperAdmin roles, Access can be only provided after approval from a design review and after discussions with the environment owner.** 


* Make sure you perform an audit of all the consumers every release and remove unused consumers.







*****

[[category.storage-team]] 
[[category.confluence]] 
