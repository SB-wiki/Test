# SH-398-Self-declaration-fields

### Background

Until 3.0, the _sunbird.usr\_external\_identity_ table held only a tenant users' external identity. The relevant table columns are as presented below:

|   | **userId**      | **idType** | **provider** | **value** |
| - | --------------- | ---------- | ------------ | --------- |
| 1 | uuidB-stateUser | tn         |  tn          | 567       |

In 3.0, the same table was allowed to be used by custodian users as well to self declare their fields. The same is represented in the following way:

|   | **userId**        | **idType**                  | **provider** | **value**                 |
| - | ----------------- | --------------------------- | ------------ | ------------------------- |
| 1 | uuidA-custOrgUser |  declared-school-udise-code |  tn          | 898080900 (11 digit code) |
| 2 | uuidA-custOrgUser |  declared-school-name       |  tn          | ABC international school  |
| 3 | uuidA-custOrgUser |  declared-ext-id            |  tn          | 789                       |

We remodel’d the table to use PRIMARY KEY(provider, idType, externalId). ===> PRIMARY KEY(userId, idType, provider) .

The provider is the channel name to which the custodian user wishes to submit this declaration. The custodian user can submit declaration against multiple channels.

### Future

#### release-3.1.0

1. Ability for the user to declare district, state, email and phone numbers
2. email and phone number fields to be encrypted and stored
3. Ability for the state admin to migrate the users into the tenant (valid users will be moved to state tenant) → _this is being taken by Implementation team in 3.1_

#### Possibilities in front of us

1. Ability for the state admin to mark the declaration as ‘declared’ or ‘rejected’ or any other.
2. Ability for the user to see the status of his declaration.
3. Ability for the user to choose the ‘persona’ and declare set of information according to it.
   1. Consciously using the word ‘persona’ instead of role to avoid privileges.
   2. Persona’s can be “state-teacher”, “teacher”, “volunteer” and so on.
   3. Each persona has a set of mandatory and optional attributes.
   4. Each attribute can be marked ‘verified’, ‘declared’ etc. Expect these will also be persona specific.

### Table changes in 3.1.0

#### Proposal

The one in green are new attributes and new columns that have been added. For status null, it is deemed to be submitted if the idType has prefix ‘declared’ or ‘verified’ otherwise. We don’t want to run a migration of this table. Post review update - We will not add ‘persona’ column.

|   | **userId**        | **idType**                 | **provider** | **value**                                | **status (oneOf “submitted”, “verified”)** | **persona**   |
| - | ----------------- | -------------------------- | ------------ | ---------------------------------------- | ------------------------------------------ | ------------- |
| 1 | uuidA-custOrgUser | declared-school-udise-code | tn           | 898080900 (11 digit code)                |                                            | state-teacher |
| 2 | uuidA-custOrgUser | declared-school-name       | tn           | ABC international school                 |                                            | state-teacher |
| 3 | uuidA-custOrgUser | declared-ext-id            | tn           | 789                                      |                                            | state-teacher |
| 4 | uuidA-custOrgUser | declared-email             | tn           | encryptedEmailAddress                    | submitted                                  | state-teacher |
| 5 | uuidA-custOrgUser | declared-phone             | tn           | encryptedPhoneNumber                     | submitted                                  | state-teacher |
| 6 | uuidA-custOrgUser | declared-state             | tn           | state UUID (for easy list box choice)    | submitted                                  | state-teacher |
| 7 | uuidA-custOrgUser | declared-district          | tn           | district UUID (for easy list box choice) | submitted                                  | state-teacher |

This is another way to represent the table - making it Cassandra like, but we are not clear today about these things - a) if the persona is associated with person and provider b) Or if the person is associated only with the person. In this model, the provider if multiple will result in a similar structure as above. We’d like to park this design below for 3.2.0.

| **userId**        | **declared-school-udise-code** {status, persona, provider, value} |
| ----------------- | ----------------------------------------------------------------- |
| uuidA-custOrgUser |                                                                   |
|                   |                                                                   |

#### Existing schema

```
CREATE TABLE sunbird.usr_external_identity(
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
PRIMARY KEY(userId, idType, provider));
```

### APIs

v1/user/update

* operation is one of ‘add’, ‘remove’, ‘edit’

```
{
  "request": {
    "userId": "5660be9e-f9ce-4896-8d72-57a105007b1f",
    "externalIds": [
      {
        "id": "test",
        "operation": "add",
        "idType": "declared-school-name",
        "provider": "ROOT_ORG"
      },
      {
        "id": "22222222222",
        "operation": "add",
        "idType": "declared-school-udise-code",
        "provider": "ROOT_ORG"
      },
      {
        "id": "789",
        "operation": "add",
        "idType": "declared-ext-id",
        "provider": "ROOT_ORG"
      },
      {
        "id": "sample@yopmail.com",
        "operation": "add",
        "idType": "declared-email",
        "provider": "ROOT_ORG"
      },
      {
        "id": "8888888888",
        "operation": "add",
        "idType": "declared-phone",
        "provider": "ROOT_ORG"
      }
    ]
  }
}
```

### Known challenges

1. Consumption teams have to fetch the ‘channel’ name from the org id. It will have been better to take in ‘org id’ instead.
2. Making it ease impacts the older apps and need to support multiple APIs/pathways present itself to backend team.

### Design comments

25 June 2020

1. 3.1 - Lets not add persona column.
2. Assess changing ‘provider’ as channel name to some other key for existing state users.
3. Add an orgId column for simpler joins in the reporting products; since we are not changing table structure in 3.1, we can do this later.
4. We can remodel APIs and table when a workflow is built.

***

\[\[category.storage-team]] \[\[category.confluence]]
