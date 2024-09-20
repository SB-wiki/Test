# SC-2190---Data-model-changes-to-organisation-schema-to-store-schools-as-organisations

As part of user-org refactoring to suit manage learn use cases, from 3.8 release :

* Schools as stored as organisations instead of suborgs.
* Changes are made to the schema to identify whether an organisation is a tenant or organisation type is a board/school/contentorg.
* Locations are currently stored as List and this is going to change to reflect the type of location id, whether the given location id is of a state or district or block.
*   Classification of orgs - board/school/contentorg, based on org\_type and isTenant flag.

    eg. cbse is a board + tenant=true, rj is board + tenant=true, khan - content org, tenant = false
* Association to custodian should be descoped in future (Eventual future)

### Problem statement&#x20;

* Schools are stored as sub-organisations and this restricts the school to be under a particular board.
* There are parent/root orgs and sub orgs, but no way to identify the type of org or is the org is a tenant.
* Org locations are stored as a location id list in user table, and this requires a lookup to location table to understand the type of location for each location id.

### Solution

In release 3.8, to make the data storage more generic and usable below changes are proposed:

Add istenant column to organisation table, and store the isrootorg column value in istenant column, in subsequent release remove the isrootorg column.

```
istenant boolean
```

Update the org locations in a **json structure** to a new **text** field, orglocation, instead of storing it in locationIds. In subsequent release, remove the locationIds column.

```
orglocation text
```

Remove the orgtype column and add organisationType column , which will save int values corresponding to the organisation types like board/school/contentorg. The types will be represented with bit posotions:

bit 0 isBoard

bit 1 isSchool

bit 2 canCreateContent

bit 3 isBoard

So value in digit for board - 5, school - 2

```
organisationType int
```

Update the rootorgid column with values from id column.

### Example

Sample data for orgLocation in table and ES doc

```
"orgLocation" : 
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
]] ]></ac:plain-text-body></ac:structured-macro><p>Store the above <code>orgLocation</code> structure either as a json string.</p><p>Table structure with new approach:</p><ac:structured-macro ac:name="code" ac:schema-version="1" ac:macro-id="8f8f346a-bab5-4523-ab15-94fd735d3745"><ac:plain-text-body><![CDATA[CREATE TABLE sunbird.organisation (
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
    locationids list<text>, //remove this field in 3.9
    noofmembers int,
    orgcode text,
    orgname text,
    orgtype text, // remove this field
    orgtypeid text, //remove this field
    parentorgid text, 
    preferredlanguage text,
    provider text,
    rootorgid text,// rootorgid need to be updated with id column value
    slug text,
    status int,
    theme text,
    thumbnail text,
    updatedby text,
    updateddate text,
    istenant boolean, //new field, update value as true, for orgs which has organisationtype =5 or only for tenant orgs
    orglocation text //new field,
    organisationtype int //new field
)
```

**Data Migration:**

* To update istenant flag for organisation which has organisationtype as ‘5’
* To update organisationtype as board/school/contentorg with respective int values
* To update rootorgid column with ‘id’ column data
* To restructure location ids in organisation table and update to orglocation column

**Impacted Areas:**

**APIs**

1. /v1/org/create - organisationtype, orglocation, istenant, isrootorg, rootorgid update logic to be need to be changed.
2. /v1/org/update - organisationtype, orglocation, istenant, isrootorg, rootorgid update logic to be need to be changed.
3. /v1/org/read - organisationtype, orglocation, istenant, isrootorg, rootorgid read logic to be need to be changed.
4. /v1/org/search - organisationtype, orglocation, istenant, isrootorg, rootorgid read logic to be need to be changed.
5. /data/sync api changes to index the orglocation in ES
6. /v3/user/read - api changes to return rootorg.rootorgid as organisation id for backward compatibility.
7. /v1/org/upload - organisationtype, orglocation, istenant, isrootorg, rootorgid update logic to be need to be changed.
8. Add member/remove member APIs to be removed.
9. Last login update API should return 200 always
10. Re-indexing the org index for better performance and new changes
11. Removing below set of APIs

\| /v1/org/type/create | | /v1/org/type/update | | /v1/org/type/list |

**Analytics Reports** - logic to pull organisationtype, organisation.locationids, istenant, isrootorg, rootorgid in reports need to be updated.

1. Self Declaration Report
2. Progress Exhaust
3. User Info Exhaust
4. User Cache Updater

***

\[\[category.storage-team]] \[\[category.confluence]]
