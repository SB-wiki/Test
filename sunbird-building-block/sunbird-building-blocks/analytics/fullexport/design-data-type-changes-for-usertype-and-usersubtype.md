
##  **Introduction** :
This wiki states the data type changes for usertype and subtype which are being denormalized, ingested in druid as well as used in exhaust reports.

Jira Link: [https://project-sunbird.atlassian.net/browse/SB-27219](https://project-sunbird.atlassian.net/browse/SB-27219)

User Org Wiki Link: [[SB-26640 Supporting multiple usertypes and sub usertypes|SB-26640-Supporting-multiple-usertypes-and-sub-usertypes]]

 **Problem Statement:** Currently usertype and usersubtype are a single valued fields in column named: profileUserType but with the current release a new field is introduced profileUserTypes which will be a list<json> to support multi-valued field for subtype and usertype.

 **Current Scenario**  for both user table and userReadAPI: profileUserType: {"subType":"hm","type":"administrator"}

 _Redis Data_ : 

1. "usersubtype"

2. "hm"

3. "usertype"

4. "administrator"

 **New Scenario** :


1. User Table: profileUserTypes: "\[{\"subType\":\"hm\",\"type\":\"administrator\"},{\"subType\":\"deo\",\"type\":\"administrator\"},{\"subType\":\"crc\",\"type\":\"teacher\"}]"


1. User Read API: profileUserTypes:\[{"subType":"hm","type":"administrator"},{"subType":"deo","type":"administrator"},{"subType":"crc","type":"teacher"}]



 _New Redis Data_ : 


1. "usersubtype"


1. "\[\"hm\",\"deo\",\"crc\"]"


1. "usertype"


1. "\[\"administrator\",\"teacher\"]"



To support the multiple values of usertype and usersubtype we require changes in following:


1. ETLUserCacheUpdater


1. User Cache Updater V2 Flink Job


1. Progress Exhaust And User Info Exhaust


1. Druid Ingestion Specs



 **Proposed Design:** To handle the usertype for both old users as well as new users in druid we have two proposed designs:

 **Approach 1:**  Rerun of migration script: Rerun the ETLUserCacheUpdater for all the user i.e remove the cache and repopulate the data.

 **Pros:** 


* Simplified druid ingestion spec changes to handle list of string for usertype


* Simplified changes to druid validator userdata schema



 **Cons:** 


* Thorough testing for all the scenarios required



 **Approach 2:**  Introduce transform spec to handle both string (for old users) and array (for new users) field:

 **Pros:** 


* Druid ingestion spec changes to handle list of string for usertype.


* No need to run migration script



 **Cons:** 


* No druid validation will happen for usertype hence invalid events can also be ingested.





 **Conclusion** 



*****

[[category.storage-team]] 
[[category.confluence]] 
