# SC-2184---Data-model-changes-to-user-schema-to-store-location,-persona,-subpersona-in-generic-way

As part of user-org refactoring to suit manage learn use cases, 3.6 release onwards profile/user locations and userType & userSubType are configurable for each state.

This means the locationIds in user table will have different set of values for each state. And userSubType can also be different as per the state configuration.

### Problem statement&#x20;

Currently user locations are stored as a location id list in user table, and this requires a lookup to location table to understand the type of location for each location id. Also userType and userSubType are stored as different columns.

### Solution

In release 3.8 to make the data storage more generic, two different approaches are proposed:

Approach 1: Update the locations in **a list of map structure** to a new field, profileLocation. Similarly userType is also stored along with userSubType, using a **map structure** to a new field, profileUserType.

```
profileLocation list<frozen<map<text, text>>>,
profileUserType frozen<map<text, text>>
```

Approach 2: Update the locations in a **json structure** to a new **text** field, profileLocation. Similarly userType is also stored along with userSubType, using **a json structure** to a new **text** field, profileUserType.

```
profileLocation text,
profileUserType text
```

After considering both solutions, approach 2 was selected.

### Example

Sample data for profileLocation and profileUserType in table and ES doc:

```
"profileLocation" : 
[
  {
    "type": "state"
    "id": "<locationid>"
  },
  {
    "type": "district"
    "id": "<locationid>"
  },
  {
    "type": "block"
    "id": "<locationid>"
  },
  {
    "type": "cluster"
    "id": "<locationid>"
  }
],
"profileUserType":
  {
    "type": "administrator"
    "subType": "deo"
  }
```

Store the above profileLocation structure either as a list of map or as a json string and profileUserTypestructure either as a map or as a json string

Table structure with approach 2:

```
CREATE TABLE sunbird.user (
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
```

Impacted Areas:

APIs

1. /v1/user/update - location, usertype, usersubtype update logic to be need to be updated.
2. /v3/user/read/ - location, usertype, usersubtype read logic to be need to be updated.
3. /v4/user/create - location
4. private/v1/user/read/ - encemail and encphone need to be returned.
5. /v3/user/create - location, usertype, usersubtype read logic to be need to be updated.
6. /v1/user/singup - location, usertype, usersubtype read logic to be need to be updated.
7. /v1/user/search - location, usertype, usersubtype read logic to be need to be updated and also querying on these fields should be supported

Analytics Reports - logic to pull location, usertype, usersubtype in reports need to be updated.

1. Self Declaration Report
2. Progress Exhaust
3. User Info Exhaust
4. User Cache Updater

Also user cache updater job is currently using cassandra to fetch user data during each audit event. Instead of this use private User Read API. So add encemail and encphone in private/v1/user/read api.

Queries:

1. Should profileusertype also need to be stored as list\<frozen\<map\<text, text>>>, in case multiple usertype selection is allowed in future? No
2. Should we change the response format of usertype and usersubtype in read API? No
3. Should we change the request format for usertype and usersubtype in update API? No

***

\[\[category.storage-team]] \[\[category.confluence]]
