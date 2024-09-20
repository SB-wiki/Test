# Allow-users-to-declare-their-State-&-District-via-their-profile

&#x20; \*\*Problem statement:  \*\*

&#x20;As a sunbird user, one should be able to do declare their District (Choose State -> Choose District).

**Proposed solution 1:** Storing the location of the user in separate table & separate API for updating location

**Pros** :&#x20;

1. Implementation will not impact existing API for create/update

**Cons** :

1. Data to be loaded from multiple calls to database.
2. Read user would require a flag to fetch whether location data is required by end-user or not.

\*\*DB changes \*\* New user\_location table

| Column          | Changes                                                                                   |
| --------------- | ----------------------------------------------------------------------------------------- |
| id(Primary Key) | Auto generated                                                                            |
| userId          | User Id of the user                                                                       |
| locationIds     | Location id of the location selected by User (Eg. state locationId, district location id) |

APIs Added

1.  Update location &#x20;

    \*\*POST  \*\* /user/v1/update/location

```
{
  "request": {

        "locationCode" : "locationCode"

    }

     }

     **Note** : User Id will be taken from "x-authenticated-user-token".  

    

     **Response** 
```

**200 OK**  - Location of user is successfully stored&#x20;

**401 Unauthorised  -**  In case user API is called without proper user-access token.

**400 Bad Request -** Invalid location code or invalid type of location passed (only district is valid as of now)

**Proposed solution 2:** Using the same table for storage and update using same API.

**Pros:**

1. Getting user location data will be available directly with user information.
2. We can create/update the location of user in Create/Update user request.

**Cons:**

1. Changes in current create/update API logic & extending the storage structure of existing tables.

\*\*DB changes \*\*  user table changes

| Column       | Changes                                                                                            |
| ------------ | -------------------------------------------------------------------------------------------------- |
| locationIds  | Added -  Location id of the location selected by User (Eg. state locationId, district location id) |

APIs Added

1.  Update location &#x20;

    \*\*POST  \*\* /user/v1/create or /user/v1/update

```
{
  {
  "request": {

        "locationCode" : "locationCode"

       }

     }

    }

    
```

**Note:** Other parameter can be same as create/update  user request, we will add one more parameter to update the location

```
 **Response** 
```

**200 OK**  - Location of user is successfully stored&#x20;

**401 Unauthorised  -**  In case user API is called without proper user-access token.

**400 Bad Request -** Invalid location type or invalid location id. (only code for location type district will be allowed)

**Note** : User read api will return the location data as follows, for ease of display.

Read is made efficient by storing locationIds in database, which has informaiton for district + state (full hierarchy)

{

&#x20;    "locations": \[{

&#x20;     "type":"locationType"

&#x20;     "value":"locationValue"

&#x20;   }],

&#x20;  "locationIds" : \[\[\["locationId1", "locationId2"|-locationId1-,--locationId2-]]]

}

***

\[\[category.storage-team]] \[\[category.confluence]]
