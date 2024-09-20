# User-Account-Recovery

### Problem statement:

Provide an ability to add either recovery email or recovery phone options to the user.&#x20;

Refers to : [SC-1215 System JIRA](https://browse/SC-1215)

### Design points:

* primary email and recovery email must NOT match.
* primary phone and recovery phone must NOT match.
* recovery email or recovery phone is NOT searchable.

### API changes:

#### **Update profile (/user/v1/update)** :

* RecoveryEmail or recoveryPhone or both could be provided.
* If recoveryEmail/recoveryPhone is provided, basic syntax validations will be performed. Email should have @ . The phone length should be 10.&#x20;
* Primary email/phone must not match recoveryEmail/phone
* if the user wants to remove previous recoveryEmail/phone values then its mandatory to pass them as a blank string("").

```js
{
    "id": "81b4ad78-f52c-4ee6-a205-2f28515c21b5",
    "ts": "2017-09-19 12:22:09:874+0530",
    "params": {},
    "request": {
        "profileSummary": "Test to check for update",
        "userId": "4c4530df-0d4f-42a5-bd91-0366716c8c24",
        "recoveryEmail": "hari5612@gmail.com"                  
        "recoveryPhone":"" /will replace  the previous recovery phone value
    }
}
```

**User search (/api/user/v1/search)**

* No changes to search-request api.
* From now onwards search-response will contains recoveryEmail or recoveryPhone attributes.
* If the recoveryEmail or recoveryPhone values are present, these can be displayed as options for sending OTP for account-recovery (forgot password flow)
* No new code changes is required

**Read User (/api/user/v1/read/:uid)**

* In read api from now on, if the user have recoveryEmail or recoveryPhone these details will be retrieved in the read user details api.
* For existing users until they update these values will be retrieved as null.

### Storage enhancements

In User table, two extra columns will be added as recoveryEmail(String) and recoveryPhone(String).

For existing users, these columns will set to default values as Null.

Alter table query:  ALTER TABLE sunbird.user ADD (recoveryEmail text, recoveryPhone text);

***

\[\[category.storage-team]] \[\[category.confluence]]
