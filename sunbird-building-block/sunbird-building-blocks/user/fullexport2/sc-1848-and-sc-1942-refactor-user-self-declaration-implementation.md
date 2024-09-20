# SC-1848-and-SC--1942-Refactor-user-self-declaration-implementation

```
* [Flows](#flows)
* [High level design](#high-level-design)
* [Future - create a lookup table (in 3.3.0)](#future---create-a-lookup-table-(in-3.3.0))
* [Challenges:](#challenges:)
* [Solution :](#solution-:)
* [Clarifications](#clarifications)
* [SC-1942 :- create a user lookup table](#sc-1942-:--create-a-user-lookup-table)
```

#### Background

Until release 3.1.0, the _sunbird.usr\_external\_identity_ table held information of tenant and custodian users external identity in a multi-row fashion.The relevant columns and information presented below.

| **userid**        | **idType**                 | **provider** | **value**     |
| ----------------- | -------------------------- | ------------ | ------------- |
| uuidB-stateUser   | tn                         | tn           | 567           |
| uuidA-custOrgUser | declared-school-udise-code | tn           | 452           |
| uuidA-custOrgUser | declared-school-name       | tn           | ABC school    |
| uuidA-custOrgUser |  declared-ext-id           | tn           | 123           |
| uuidA-custOrgUser | declared-email             | tn           | abc@gmail.com |
| uuidA-custOrgUser | declared-phone             | tn           | 0900909090    |

Some key points from the ticket to aid in the design are as below:

* user should be able to self declare information with or without a role. \[ _Upon a DC review, we decided that this table will be used only with a role always. A general survey like thing will be handled outside_ ]
* self declarations are bound to happen on field requirements and can be best assumed to be not known prior.
* Multiple roles can be assigned to the user in an organisation or multiple organisation.
* the errors are qualified to individual declared fields, but the status is overall for the set of declaration. It is up to the approver/admin to selectively pick and choose the fields for overall status. _For example, in the above list, one admin might choose to match only based on phone, whereas the other might want to match based on external id and phone._

#### Flows

1. During onboarding of a SSO user, the external identity and org combination is checked for uniqueness.
2. For user read by id (v1, v2), the external identity is fetched from this table. This is only for state users. Custodian org users do not have external identity.
3. For self-declaration, ‘any’ user could declare some fields driven by a form. This is presently open only to custodian org users and may be open to state users in future.

#### High level design

1. For state users, the usr\_external\_identity table will continue to hold the external identity. The flows 1 and 2 listed above continue to feed from here.
   1. The provider value now is orgId itself - not channel. Data products feeding this must make this change.
2. Create a migration job to move all the declarations to the new table proposed below.
3. Serve CRUD operations in a simpler way to these declarations.
   1. GET v3/user/read/{uuid}?fields=externalIds,organisations,declarations
   2. PATCH v1/user/declarations

Table Redesign:

```sql
CREATE TABLE IF NOT EXISTS sunbird.user_declarations(
userId text, 
orgId text,           
persona text,            
userInfo map<text,text>  //Map {"declaredEmail":"abc@gmail.com", .....} 
status text,           
errortype text,
createdon timestamp,
createdby text,
updatedon timestamp,
updatedby text,
primary key(userId,orgId,persona)
);
```

**Fields**

* **userId** : Contains user UUID information which can be mapped to multiple role and multiple organizations.
* **orgId** : Organization identifier .
* **persona** : Role of a user in an organization such as (Teacher, Volunteer etc).
* **userInfo** : User Info contains self declared user details such as ( declared\_email, declared\_phone, declared\_state, declared\_district ….etc).
* **status** : status column indicated status of the user request such as PENDING, VALIDATED,REJECTED.
* **errorType** : It will indicates the reason for rejection.
* **createdon** : timestamp when user self declared.
* **createdby** : UUID of a user who created the information.
* **updatedon** : timestamp when it is latest updated.
* **updatedby** : UUID of a user updated the record.

#### Future - create a lookup table (in 3.3.0)

```sql
CREATE TABLE IF NOT EXISTS sunbird.user_lookup(
 type text,     // one of email, phone, username, externalid
 value text,
 userId text,
 primary key(type,value)
)
```

Examples:

Queries expected:

1.  Check uniqueness of external id&#x20;

    select \* from user\_lookup where type = "externalid" and value = "123" ;
2.  Check uniqueness of email&#x20;

    select \* from user\_lookup where type = "email" and value = "[123@abc.com](mailto:123@abc.com)";
3.  NOT supported intentionally - Fetch external id for a given user id -- Allow filtering is needed and this is a READ operation, not a lookup operation.

    select \* from user\_lookup where type = "externalid" and userId = "U1";

#### Challenges:

* To find primary key combination as user can be mapped to multiple persona and multiple organisations.
* ExternalIds cannot be used as primary key as it is changeable fields which can be updated and it will force the system to create a new record.

**Scenario 1** : _primary key( userId, orgId, role)_ : Having userId, role, orgId as partition key defeats the purpose of update operation.

| **userId** | **orgId** | **persona** |
| ---------- | --------- | ----------- |
| id1        | 123       | Teacher     |

if a role(persona) gets updated within the same org then we will again use the earlier way of deleting complete records and then inserting again and will require UI to send complete records.

Similary with the org updated.

**Scenario 2** : _primary key (userId, role) or (userId, orgId) :_ Having combination of either userId and orgId or userId and role will not work it will not allow user to have same role in multiple organization and multiple role in same organization.

#### Solution :

we will create _primary key (userId,orgId,role)_ as primary(partitioning key) for cassandra and create a new table usr\_external for reverse lookup on externalId for non custodian users.

#### Clarifications

| **Queries**                                                                                                          | **Status** | **Reasoning** |
| -------------------------------------------------------------------------------------------------------------------- | ---------- | ------------- |
| should validation can happen at declared fields level such as declared email , declared phone or only at role level? | closed     | role level    |

#### SC-1942 :- create a user lookup table

Proposed Solution:

```
CREATE TABLE IF NOT EXISTS sunbird.user_lookup(
 type text,     // one of email, phone, username, externalid
 value text,    // value@orgid
 userId text,
 primary key((type,value))
)

```

Queries expected:

1.  Check uniqueness of external id&#x20;

    select \* from user\_lookup where type = ‘externalid’ and value = 123";
2.  Check uniqueness of email&#x20;

    select \* from user\_lookup where type = ‘email' and value = 'Asty4i@4k43j928329823982@custOrgId’;
3.  Check uniqueness of phone&#x20;

    select \* from user\_lookup where type ='phone' and value = 'X69T8ZQNasQBM3iE8i2IyiR5fT+DcRpzliYgcJi5k2/7iPJ+g1ZB1MMtKvMvKLm3o05ah7t02XsX\nGh+wMOG6AvgInZkluz84y/od36Od2hp9EX7i4Y1BOvnp476EretpN45zeWjK9ksPENXhVz2qkg==@custOrgId';
4. Check uniqueness of username : select \* from user\_lookup where type='userName' and value='john\_xvt';

Sample dataLets suppose there are two users, custodian and state as follows. The email, phone and username are considered identity and are therefore encrypted. The external id is plain text. Its value has a suffix @ organisation id to make it unique to the organisation.

John → Phone1234, [john@google.com](mailto:john@google.com), john\_xy123, Uuid1 (custodian user)

Adam -> Phone789, [adam@tn.com](mailto:adam@tn.com), adam7835, TN156, Uuid2 (tenant org user)The new lookup table will be populated as given below:

| **type**   | **value**                          | **userId** |
| ---------- | ---------------------------------- | ---------- |
| phone      | Phone1234\_encrypted\_form         | uuid1      |
| email      | john@google.com\_\_encrypted\_form | uuid1      |
| username   | john\_xy123\_encrypted\_form       | uuid1      |
| phone      | Phone789\_encrypted\_form          | uuid2      |
| email      | adam@tn\_encrypted\_form           | uuid2      |
| username   | adam7835\_encrypted\_form          | uuid2      |
| externalId | TN156 **@tnOrgId**                 | uuid2      |

**Average** :

State user - 3 rows (phone/email, username, externalId)

Cust user - 2 rows (phone/email, username)

**Concern** :For 1.5 million state user there will be approx: 4.5 million

For 1 million cust user there will be approx: 2 milllion

These number could go up depending upon fields need to do uniqueness check.

Clarification Needed : it is fine to have these many records in the cassandra table as it is a part of composite primary key ((type,value))

**Migration Spark Job** Scala script created for the migration job:\[\[SC-1942 User Lookup Migration Script|SC-1942-User-Lookup-Migration-Script]]

The user count in production is _sunbird.user_ = **4520984.**

***

\[\[category.storage-team]] \[\[category.confluence]]
