 **Introduction:** 

The three exhaust reports depends on the user-metadata information which are generated from user-cache-updater flink job by fetching informations from different core cassandra tables and  are stored into the redis cache. There is one time spark ETL script which populates the user data to redis cache after having the . From Release-3.7.0 new fields have been introduced and few field’s formulae have been modified. Following are the modules needs to be touched upon for this ticket:


1. User-cache-updater flink job


1. ETLUserCacheUpdater Job (one time script to populate users)


1. Exhaust Jobs (To introduce new fields)


    1. Progress Exhaust


    1. Userinfo Exhaust

    



    

JIRA Link: [https://project-sunbird.atlassian.net/browse/SB-21691](https://project-sunbird.atlassian.net/browse/SB-21691)

Reference Wiki Links:

1. User Table Changes: [[SC-2184 : Data model changes to user schema to store location, persona, subpersona in generic way|SC-2184---Data-model-changes-to-user-schema-to-store-location,-persona,-subpersona-in-generic-way]]

2. Org Table Changes: [[SC-2190 : Data model changes to organisation schema to store schools as organisations|SC-2190---Data-model-changes-to-organisation-schema-to-store-schools-as-organisations]]

 **Table Schema Changes:** 

User Table Schema ChangesCREATE TABLE sunbird.user (

id text PRIMARY KEY,

accesscode text,

alltncaccepted map<text, text>,

avatar text,

channel text,

countrycode text,

createdby text,

createddate text,

currentlogintime text,

dob text,

email text,

emailverified boolean,

firstname text,

flagsvalue int,

framework map<text, frozen<list<text>>>,

gender text,

grade list<text>,

isdeleted boolean,

language list<text>,

lastlogintime text,

lastname text,

location text,

locationids list<text>,

loginid text,

managedby text,

maskedemail text,

maskedphone text,

password text,

phone text,

phoneverified boolean,

prevusedemail text,

prevusedphone text,

profilesummary text,

profilevisibility map<text, text>,

recoveryemail text,

recoveryphone text,

registryid text,

roles list<text>,

rootorgid text,

status int,

subject list<text>,

temppassword text,

thumbnail text,

tncacceptedon timestamp,

tncacceptedversion text,

updatedby text,

updateddate text,

userid text,

username text,

usersubtype text,

usertype text,

webpages list<frozen<map<text, text>>>,

profilelocation text, //new field

profileusertype text //new field

)

Organisation Table Schema ChangesCREATE TABLE sunbird.organisation (

id text PRIMARY KEY,

addressid text,

approvedby text,

approveddate text,

channel text,

communityid text,

contactdetail text,

createdby text,

createddate text,

datetime timestamp,

description text,

email text,

externalid text,

hashtagid text,

homeurl text,

imgurl text,

isapproved boolean,

isdefault boolean,

isrootorg boolean,

isssoenabled boolean,

keys map<text, frozen<list<text>>>,

locationid text,

locationids list<text>,

noofmembers int,

orgcode text,

orgname text,

orgtype text, // Update orgtype value as board/school/contentorg

orgtypeid text,

parentorgid text, // parent id need to be nullified, to remove suborg association

preferredlanguage text,

provider text,

rootorgid text,

slug text,

status int,

theme text,

thumbnail text,

updatedby text,

updateddate text,

istenant boolean, //new field, update isrootorg column value in this field

orglocation text //new field

)





|  |  **Field Name**  |  **Type**  |  **Table Name**  |  **Description**  | 
|  --- |  --- |  --- |  --- |  --- | 
| 1 |  **Mobile Number**  | String | USER.phone | User phone number in an encrypted format | 
| 2 |  **Email ID**  | String | USER.email | User mail id in an encrypted format | 
| 3 | First Name | String | USER.firstname | User first name | 
| 4 | Last Name | String | USER.lastname | User Last Name | 
| 5 | Rootorgid | String | USER.rootorgid | User root org id (can be used to differentiate between custodian and state user) | 
| 6 | Board | String | USER.framework.{ board } | User’s board Assumption: It is single valued | 
| 7 | Medium | List\[String] | USER.framework.{ medium } | User medium | 
| 8 | Subject | List\[String] | USER.framework.{ subject } | User subjects | 
| 9 | Language | List\[String] | USER.language | User Language | 
| 10 | Grade | List\[String] | USER.framework.{ gradeLevel } | User grades | 
| 11 | framework | String | USER.[framework.id](http://framework.id) | User’s framework id Assumption: It is single valued | 
| 12 | usersignintype | String | if custodianRootorgId = rootorgid then ‘Self-Signed-In’else 'Validated' | User’s sign-in type | 
| 13 |  **UserType**  | String | USER.profileUserType.type | User Type | 
| 14 |  **UserSubType**  | String | USER.profileUserType.subType | User’s Sub Type | 
| 15 |  **Orgname**  | String | ORGANISATION.orgname | User’s Org Name 1. Select { orgname } from ORGANISATION where UserOrg.organisationid = ORG.id | 
| 16 |  **School Name**  | String | ORGANISATION | User’s School Name. Select externalid from ORGANISATION where ORG.id=USER_ORG.organisationid and orgtype=school  | 
| 17 |  **School UDISE Code**  | String | ORGANISATION | User’s School UDISE Code. Select orgname from ORGANISATION where ORG.id=USER_ORG.organisation and orgtype=school  | 
| 18 |  **State Name**  | String | USER - get locationids from USER.profilelocation[\*].idLOCATION - LOCATION.name | User’s State Name. USER.profilelocation.{id}=LOCATION.id and LOCATION.type='state' and fetch the { name } as state_name | 
| 19 |  **District Name**  | String | USER - get locationids from USER.profilelocation[\*].idLOCATION - LOCATION.name | User’s District Name. USER.profilelocation.{id}=LOCATION.id and LOCATION.type='district' and fetch the { name } as district_name | 
| 20 |  **Block Name**  | String | USER - get locationids from USER.profilelocation[\*].idLOCATION - LOCATION.name | User’s Block Name. USER.profilelocation.{id}=LOCATION.id and LOCATION.type='block' and fetch the { name } as block_name | 
| 21 |  **Cluster Name**  | String | USER - get locationids from USER.profilelocation[\*].idLOCATION - LOCATION.name | User’s Cluster Name. USER.profilelocation.{id}=LOCATION.id and LOCATION.type='cluster' and fetch the { name } as cluster_name | 

 **Properties to be Deleted:** 



|  **Field Name**  |  **Type**  |  **Table Name**  |  **Description**  | 
|  --- |  --- |  --- |  --- | 
| Externalid | String | user_declaration | The  **externalid** will be removed from userinfo-exhaust report | 







*****

[[category.storage-team]] 
[[category.confluence]] 
