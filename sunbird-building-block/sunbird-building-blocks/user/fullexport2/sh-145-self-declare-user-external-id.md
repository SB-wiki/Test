    * [About](#about)
    * [System requirements](#system-requirements)
    * [Design](#design)
    * [Changes needed](#changes-needed)

### About
The external identifier is a org supplied value that is given to a user (teacher, for example). The external identifier is a  _non-editable_  field and is set at the time of org-user creation. This identifier was so far used only by non-custodian org users. This ticket calls for opening it up for custodian org users as well.


### System requirements

* External id continues to be non-editable for non-custodian users (state users).


* External id will be marked ‘declared’ and editable by all custodian-org users.




### Design
The UI form asks the following 4 fields:


1. State


1. District


1. School udise code


1. External identifier


1. Terms and Conditions or Consent \[yet to be finalised on the approach]



The state and district are same as user’s location. Any updates made here or in the profile will be reflecting in the other place. The school udise code and external identifier needs to be preserved now additionally. 

The external id is preserved in the table  _usr_external_identity_  with a triplet - idType, provider, id. The idType and provider field values have always been the channel names. The id field has been populated with the user’s external id. This design continues to be same even after this ticket implementation for non-custodian (state) users. Whenever, a custodian user self-declares, we shall use prefix ‘declared’ and quality the attribute for ease.

In case of custodian users, the following shall be populated by consumption teams.

1.School udise code


* idType =  _declared-school-udise-code [Fixed string, not a variable]_ 


* provider = channel name  \[variable, Pick this from the state drop-down by intersection with the org table]


* id = 11 digit code



2.School name


* idType =  _declared-school-name [Fixed string, not a variable]_ 


* provider = channel \[variable, Pick this from the state drop-down by intersection with the org table]


* id = school name 



3.External id


* idType =  _declared-ext-id [Fixed string, not a variable]_ 


* provider = channel \[variable, Pick this from the state drop-down by intersection with the org table]


* id = user_ext_id.



Provider could have been as well be a ‘user’ string or some other literal. It is chosen to be ‘channel’ to indicate that in this particular ‘channel’, the idType is id. 


### Changes needed
Note that these are implementation changes and not requirements. Please refer to requirements in the ticket.

Consumption team
* Store these strings,  _declared-school-udise-code, declared-school-name_  and  _declared-ext-id_  as configuration per tenant. In education space, these are not likely going to be changing.


* Validate  _declared-school-udise-code_  to be 11 digit.


* Set operation = “edit” in the user update API, if you want to modify the value.

    


```
{
    "request": {
        "userId": "ad0555a0-1bdd-417a-9afb-baeb85475abc",
        "externalIds": [
            {
                "operation": "add",
                "id": "extid", 
                "idType": "extType",
                "provider": "extProvider"
            }
        ]
    }
}

// with operation as edit only id can be updated. To update idType or provider use operation as remove to delete the existing idType and provide and add the new external id 
{
    "request": {
        "userId": "ad0555a0-1bdd-417a-9afb-baeb85475abc",
        
        "externalIds":[
        	{
        		"operation":"remove",
        		"id":"extid1",
        		"idType":"edty",
        		"provider":"asd"
        	},
        	{
        		"operation":"edit",
        		"id":"extid",
        		"idType":"extType",
        		"provider":"extProvider"
        	}]
    }
}
```




Platform-User team
* Update the user location based, if the current location is different from what is provided in this form.



 **API references** The user read is called at the time of login that returns the externalIds. The same API will additionally carry these declared values as well.


```
https://preprod.ntp.net.in/learner/user/v2/read/373981ca-5805-48f0-ace9-ada452027d01?fields=organisations,roles,locations
```
 _Response snippet_ 

externalIds":\[{"idType":"DB_org","provider":"DB_org","id":"U1234"}]

Since the API and table design is open, we don’t want to add any validations on channel/idType etc.

 **Table re-design** The existing table design is presented below. Notice that the userid has a secondary index applied. Whenever a user read happens, this can prove detrimental to the efficiency of the Cassandra cluster - as all the nodes of the cluster has to be queried. As part of this opportunity, we like to redesign this table. The provider, usually a channel name value, is a good partition key. But this is limiting that it can have only one value per channel (note:  _Partition keys must also be unique)_ .


```
CREATE TABLE IF NOT EXISTS sunbird.usr_external_identity(
externalId text, 
provider text, 
idType text, 
userId text, 
createdOn timestamp, 
lastUpdatedOn timestamp, 
createdBy text, 
lastUpdatedBy text, 
originalExternalId text,
originalIdType text,
originalProvider text,
PRIMARY KEY(provider, idType, externalId));
CREATE INDEX inx_usrextid_user_id ON sunbird.usr_external_identity(userId);
```


Proposed


1. Making userid as the partition key → Impact: Whenever a query needs to be run, we must know userid - which we do and is fine.




```
CREATE TABLE IF NOT EXISTS sunbird.usr_external_identity(
externalId text, 
provider text, 
idType text, 
userId text, 
createdOn timestamp, 
lastUpdatedOn timestamp, 
createdBy text, 
lastUpdatedBy text, 
originalExternalId text,
originalIdType text,
originalProvider text,
PRIMARY KEY(userId, provider, idType));
```
Advantages:


1. Querying happens based on userId and that is known.


1. The provider is indexed and also allows multiple idTypes to be given against a userId (with the same provider).



 **Actions required** 

The table name is referred in the learner-service code and in other reporting jobs (data-products). We must not change the table name hence. Recommend the following actions with steps mentioned below:

a) Create a CSV dump of the table

b) Create a utility program to populate this table after redesign

c) Provide a Jenkins job to run this utility program in different environments

 **Steps to do in the one-time utility program**  (Refer to an example [here](https://github.com/project-sunbird/sunbird-utils/blob/release-3.0.0/decryption-util))


1. Take a CSV dump of the usr_external_identity table - this is both externally as well as part of the one-time utility program.


1. Delete the table


1. Create the table according to the new redesign


1. Re-populate the table using csv dump



We have been doing such value alterations via java programs. Can we make it in a simple cqlsh script that can be copy/pasted or run as a shell script? 

 **Adhoc notes** 


```
cqlsh:rtest> create table extId2(provider text, idType text, id text, userid text, primary key(userid, provider, idType));
cqlsh:rtest> insert into extId2(provider, idType, id, userid) values ('ap', 'ap', '123', 'u1');
cqlsh:rtest> insert into extId2(provider, idType, id, userid) values ('ap', 'declared', '345', 'u1');
cqlsh:rtest> insert into extId2(provider, idType, id, userid) values ('tn', 'tn', '678', 'u2');
cqlsh:rtest> select * from extId2 where userid='u1';

 userid | provider | idtype   | id
--------+----------+----------+-----
     u1 |       ap |       ap | 123
     u1 |       ap | declared | 345

(2 rows)
cqlsh:rtest> select * from extId2 where userid='u2';

 userid | provider | idtype | id
--------+----------+--------+-----
     u2 |       tn |     tn | 678

(1 rows)
# UPDATE happens because the provider is 'tn' and idtype is 'tn'.
cqlsh:rtest> insert into extId2(provider, idType, id, userid) values ('tn', 'tn', '901', 'u2');
cqlsh:rtest> select * from extId2 where userid='u2';

 userid | provider | idtype | id
--------+----------+--------+-----
     u2 |       tn |     tn | 901

```




*****

[[category.storage-team]] 
[[category.confluence]] 
