# SB-27887-User-&-Org-Service-API-Error-Codes

### About

This document describes how to construct Error codes for all operations in UserOrg Service from release-4.7.0

### Background

\[\[Exception logs|Exception-logs]]

### Problem Statement:

How do assign specific error codes to API?

### Solution:

Error Code Format:

```
<SERVICE_CODE>-<OPERATION_CODE>-<ERROR_NUMBER>

 Example 1:  
```

UOS\_USRUPD0011 - Error number “0011” for **UPDATE** operation of the user object in user\&org service

```
            UOS:  USER & ORG Service code

            USR:  Actor Object on which operation is getting performed (in this case its USER) 

            UPD:  UPDATE Operation

            0011:  Error Number (ONLY_EMAIL_OR_PHONE_OR_MANAGEDBY_REQUIRED)

 Example 2: 
```

UOS\_USRRED0013 - Error number “0013” for **READ** operation of the user object in user\&org service

```
               UOS: USER & ORG Service code

USR:  Actor Object on which operation is getting performed (in this case its USER) 

              RED: READ Operation

              0013: Error Number (RESOURCE_NOT_FOUND)
```

We will extend the existing exception handling codebase in the user & org service and keep on appending more contextual error code info at the respective layers.

Example:

1. In the Actor layer, If an Exception will be thrown at DAO or Service layer (here error code will just have Error Number), so will append this with more contextual Error code info like Actor object code (like USR in case of User Obj) and actor operation code (like CRT in case of creating) along with user & org service code (i.e UOS) in BaseActor class.
2. In the Controller layer, Most of the Exception will be thrown from Request validators, which again contains only the error numbers and will append more contextual Error code info like above in BaseController class.

Error Code for Actor Object and Actor Operation:

| **Actor Object**                      | **CRUD Operation** | **Operation Code** |
| ------------------------------------- | ------------------ | ------------------ |
| User (MUA/SSO/SSU)                    | CREATE             | USRCRT             |
| User (MUA/SSO/SSU)                    | UPDATE             | USRUPD             |
| User (Read by loginid/email/phone/id) | READ               | USRRED             |
| User (Background Update to ES)        | UPDATE             | UBKGUPD            |
| User                                  | UNBLOCK            | USRUNBLOK          |
| User                                  | BLOCK              | USRBLOK            |
| User Role assign                      | UPDATE             | ROLUPD             |
| Role Read (Master data)               | READ               | ROLERED            |
| Bulk Upload                           | UPLOAD             | BLKUPLD            |
| User-Org (Background Update to ES)    | UPDATE             | UOBKGUPD           |
| User Role (Background Update to ES)   | UPDATE             | URBKGUPD           |
| Sync (For User/Org/Location)          | SYNC               | ESSYNC             |
| Background ES Sync                    | SYNC               | BKGESSYNC          |
| File Storage                          | UPLOAD             | STRGSER            |
| EMAIL/SMS Notification                | NOTIFICATION       | NOTI               |
| Health Check                          | HEALTH CHECK       | HLTHCHK            |
| Note                                  | CREATE             | NOTECRT            |
| Note                                  | UPDATE             | NOTEUPD            |
| Note                                  | READ               | NOTERED            |
| Note                                  | SEARCH             | NOTESER            |
| Note                                  | DELETE             | NOTEDEL            |
| Note (ES Insert)                      | CREATE             | NBKGCRT            |
| Note (ES Update)                      | UPDATE             | NBKGUPD            |
| Tenant Preference                     | CREATE             | TPREFCRT           |
| Tenant Preference                     | UPDATE             | TPREFUPD           |
| Tenant Preference                     | READ               | TPREFRED           |
| System Settings                       | CREATE             | SYSCRT             |
| System Settings                       | UPDATE             | SYSUPD             |
| System Settings                       | READ               | SYSRED             |
| Tnc Accept                            | ACCEPT             | TNCACCPT           |
| OTP                                   | CREATE             | OTPCRT             |
| OTP                                   | VERIFY             | OTPVERFY           |
| OTP                                   | SEND               | OTPNOTI            |
| User Type                             | READ               | UTYPRED            |
| User                                  | MIGRATE            | USRMIG             |
| Identifier Freeup                     | FREEUP             | IDNTFREE           |
| Password Reset                        | RESET              | PASSRST            |
| User                                  | MERGE              | USRMRG             |
| User (Update ES with Merged User)     | UPDATE             | UBKGMRG            |
| User Cert Merge                       | MERGE              | USRCRTMRG          |
| Self Declared Tenant Migrate          | MIGRATE            | USDTMIG            |
| Feed                                  | CRETAE             | FEEDCRT            |
| Feed                                  | READ               | FEEDRED            |
| Feed                                  | UPDATE             | FEEDUPD            |
| Feed                                  | DELETE             | FEEDDEL            |
| Check User Exist / Or Not             | READ               | UEXIST             |
| User Declaration                      | UPDATE             | UDECLUPD           |
| User Consent                          | UPDATE             | UCNSNTUPD          |
| User                                  | SEARCH             | USRSER             |
| ORG                                   | SEARCH             | ORGSER             |
| User Lookup                           | READ               | USRLKP             |
| User Consent                          | READ               | UCNSTRED           |
| User Role                             | READ               | UROLERED           |
| User & Org (ES Insert)                | CREATE             | UOBKGCRT           |
| User & Org (ES Update)                | UPDATE             | UOBKGUPD           |
| User ExtId                            | UPSERT             | UEXTIDUPSRT        |
| User Welcome Email/Sms                | NOTIFICATION       | WLCMNOTI           |
| Reset Password                        | NOTIFICATION       | PASSNOTI           |
| User Attributes                       | UPSERT             | UATTRUPSRT         |
| User (ES upsert)                      | UPSERT             | UBKGUPSRT          |
| User & Org (ES Upsert)                | UPSERT             | UOBKGUPSRT         |
| User Declaration                      | UPSERT             | USDUPSRT           |
| User Declaration Error Type           | UPSERT             | USDETUPD           |
| Location                              | UPLOAD             | LOCUPLD            |
| Location (Background Actor)           | UPLOAD             | LBKGUPLD           |
| Organisation                          | UPLOAD             | ORGUPLD            |
| Organisation (Background Actor)       | UPLOAD             | OBKGUPLD           |
| User                                  | UPLOAD             | USRUPLD            |
| User( Background Actor)               | UPLOAD             | UBKGUPLD           |
| Bulk upload status                    | READ               | BLKSTSRED          |
| Organisation                          | CREATE             | ORGCRT             |
| Organisation                          | UPDATE             | ORGUPD             |
| Org Status                            | UPDATE             | OSTSUPD            |
| Organisation                          | READ               | ORGRED             |
| Org Assign Key                        | UPDATE             | ASSGNK             |
| Org (ES upsert)                       | UPSERT             | OBKGUPSRT          |

| **API Errors**                                                                                                             | **Error Number** | **Old Error Code**                                  | **User Interface Error** |
| -------------------------------------------------------------------------------------------------------------------------- | ---------------- | --------------------------------------------------- | ------------------------ |
| You are not authorized.                                                                                                    | 0073             | UNAUTHORIZED\_USER                                  |                          |
| Requested data for this operation is not valid.                                                                            | 0028             | INVALID\_REQUESTED\_DATA                            |                          |
| Data type of {0} should be {1}.                                                                                            | 0003             | DATA\_TYPE\_ERROR                                   |                          |
| Value {0} for {1} is already in use.                                                                                       | 0004             | ERROR\_DUPLICATE\_ENTRY                             |                          |
| Either pass attribute {0} or {1} but not both.                                                                             | 0005             | ERROR\_ATTRIBUTE\_CONFLICT                          |                          |
| Invalid property {0}.                                                                                                      | 0053             | INVALID\_PROPERTY\_ERROR                            |                          |
| Maximum upload data size should be {0}                                                                                     | 0007             | DATA\_SIZE\_EXCEEDED                                |                          |
| User account has been blocked.                                                                                             | 0006             | USER\_ACCOUNT\_BLOCKE                               |                          |
| User is already {0}.                                                                                                       | 0008             | USER\_STATUS\_MSG                                   |                          |
| Please provide valid csv file.                                                                                             | 0077             | INVALID\_CSV\_FILE                                  |                          |
| CSV file is Empty.                                                                                                         | 0010             | EMPTY\_CSV\_FILE                                    |                          |
| Invalid Object Type.                                                                                                       | 0075             | INVALID\_OBJECT\_TYPE                               |                          |
| Please provide only email or phone or managedBy.                                                                           | 0011             | ONLY\_EMAIL\_OR\_PHONE\_OR\_MANAGEDBY\_REQUIRED     |                          |
| Channel Registration failed.                                                                                               | 0012             | CHANNEL\_REG\_FAILED                                |                          |
| Requested resource not found.                                                                                              | 0013             | RESOURCE\_NOT\_FOUND                                |                          |
| Max allowed size is {0}.                                                                                                   | 0014             | MAX\_ALLOWED\_SIZE\_LIMIT\_EXCEED                   |                          |
| User is Inactive. Please make it active to proceed.                                                                        | 0076             | INACTIVE\_USER                                      |                          |
| Invalid {0}: {1}. Valid values are: {2}.                                                                                   | 0018             | INVALID\_VALUE                                      |                          |
| Please provide valid {0}.                                                                                                  | 0019             | INVALID\_PARAMETER                                  |                          |
| One or more locations have a parent reference to given location and hence cannot be deleted.                               | 0029             | INVALID\_LOCATION\_DELETE\_REQUEST                  |                          |
| For top level location, {0} is not allowed.                                                                                | 0034             | PARENT\_NOT\_ALLOWED                                |                          |
| Mandatory parameter {0} is missing.                                                                                        | 0030             | MANDATORY\_PARAMETER\_MISSING                       |                          |
| Mandatory parameter {0} is empty.                                                                                          | 0031             | ERROR\_MANDATORY\_PARAMETER\_EMPTY                  |                          |
| No framework found.                                                                                                        | 0032             | ERROR\_NO\_FRAMEWORK\_FOUND                         |                          |
| Update of {0} is not allowed.                                                                                              | 0033             | UPDATE\_NOT\_ALLOWED                                |                          |
| Invalid value {0} for parameter {1}. Please provide a valid value.                                                         | 0017             | INVALID\_PARAMETER\_VALUE                           |                          |
| Missing file attachment.                                                                                                   | 0035             | MISSING\_FILE\_ATTACHMENT                           |                          |
| File attachment max size is not configured.                                                                                | 0036             | FILE\_ATTACHMENT\_SIZE\_NOT\_CONFIGURED             |                          |
| Attached file is empty.                                                                                                    | 0037             | EMPTY\_FILE                                         |                          |
| Invalid column: {0}. Valid columns are: {1}.                                                                               | 0020             | INVALID\_COLUMNS                                    |                          |
| Missing header line in CSV file.                                                                                           | 0039             | EMPTY\_HEADER\_LINE                                 |                          |
| An organisation cannot be associated to two conflicting locations ({0}, {1}) at {2} level.                                 | 0038             | CONFLICTING\_ORG\_LOCATIONS                         |                          |
| Invalid parameter {0} in request.                                                                                          | 0021             | INVALID\_REQUEST\_PARAMETER                         |                          |
| No root organisation found which is associated with given {0}.                                                             | 0040             | ROOT\_ORG\_ASSOCIATION\_ERROR                       |                          |
| Missing parameter {0} which is dependent on {1}.                                                                           | 0041             | DEPENDENT\_PARAMETER\_MISSING                       |                          |
| External ID (id: {0}, idType: {1}, provider: {2}) not found for given user.                                                | 0042             | EXTERNALID\_NOT\_FOUND                              |                          |
| externalId (id: {0}, idType: {1}, provider: {2})                                                                           |                  | EXTERNAL\_ID\_FORMAT                                |                          |
| External ID (id: {0}, idType: {1}, provider: {2}) already assigned to another user.                                        | 0043             | EXTERNALID\_ASSIGNED\_TO\_OTHER\_USER               |                          |
| Missing parameter value in {0}.                                                                                            |                  | DEPENDENT\_PARAMS\_MISSING                          |                          |
| External ID (id: {0}, idType: {1}, provider: {2}) not found for given user.                                                | 0042             | EXTERNALID\_NOT\_FOUND                              |                          |
| External ID (id: {0}, idType: {1}, provider: {2}) already assigned to another user.                                        | 0043             | EXTERNALID\_ASSIGNED\_TO\_OTHER\_USER               |                          |
| Duplicate external IDs for given idType ({0}) and provider ({1}).                                                          | 0044             | DUPLICATE\_EXTERNAL\_IDS                            |                          |
| Email notification is not sent as the number of recipients exceeded configured limit ({0}).                                | 0045             | EMAIL\_RECIPIENTS\_EXCEEDS\_MAX\_LIMIT              |                          |
| Mismatch of given parameters: {0}.                                                                                         | 0046             | PARAMETER\_MISMATCH                                 |                          |
| Invalid OTP.                                                                                                               | 0058             | ERROR\_INVALID\_OTP                                 |                          |
| You are forbidden from accessing specified resource.                                                                       | 0074             | FORBIDDEN                                           |                          |
| Loading {0} configuration failed as empty string is passed as parameter.                                                   | 0047             | ERROR\_CONFIG\_LOAD\_EMPTY\_STRING                  |                          |
| Loading {0} configuration failed due to parsing error.                                                                     | 0048             | ERROR\_CONFIG\_LOAD\_PARSE\_STRING                  |                          |
| Loading {0} configuration failed.                                                                                          | 0049             | ERROR\_CONFIG\_LOAD\_EMPTY\_CONFIG                  |                          |
| Not able to associate with root org.                                                                                       | 0050             | ERROR\_NO\_ROOT\_ORG\_ASSOCIATED                    |                          |
| Unsupported cloud storage type {0}.                                                                                        | 0051             | ERROR\_UNSUPPORTED\_CLOUD\_STORAGE                  |                          |
| Unsupported field {0}.                                                                                                     | 0052             | ERROR\_UNSUPPORTED\_FIELD                           |                          |
| Organisation corresponding to given {0} ({1}) is inactive.                                                                 | 0054             | ERROR\_INACTIVE\_ORG                                |                          |
| System contains duplicate entry for {0}.                                                                                   | 0055             | ERROR\_DUPLICATE\_ENTRIES                           |                          |
| Conflicting values for {0} ({1}) and {2} ({3}).                                                                            | 0056             | ERROR\_CONFLICTING\_VALUES                          |                          |
| Root organisation ID of API user is conflicting with that of specified organisation ID.                                    | 0057             | ERROR\_CONFLICTING\_ROOT\_ORG\_ID                   |                          |
| Parameter {0} is of invalid size (expected: {1}, actual: {2}).                                                             | 0059             | ERROR\_INVALID\_PARAMETER\_SIZE                     |                          |
| Your per {0} rate limit has exceeded. You can retry after some time.                                                       | 0060             | ERROR\_RATE\_LIMIT\_EXCEEDED                        |                          |
| Invalid request timeout value {0}.                                                                                         | 0022             | INVALID\_REQUEST\_TIMEOUT                           |                          |
| User migration failed.                                                                                                     | 0061             | ERROR\_USER\_MIGRATION\_FAILED                      |                          |
| Valid identifier is not present in List, Valid supported identifiers are {0}.                                              |                  | IDENTIFIER\_VALIDATION\_FAILED                      |                          |
| Mandatory header parameter {0} is missing.                                                                                 | 0062             | MANDATORY\_HEADER\_PARAMETER\_MISSING               |                          |
| {0} could not be same as {1}.                                                                                              | 0063             | RECOVERY\_PARAM\_MATCH\_EXCEPTION                   |                          |
| Account not found.                                                                                                         | 0078             | ACCOUNT\_NOT\_FOUND                                 |                          |
| Password must contain a minimum of 8 characters including numerals, lower and upper case alphabets and special characters. | 0024             | INVALID\_PASSWORD                                   |                          |
| OTP verification failed. Remaining attempt count is {0}.                                                                   | 0064             | OTP\_VERIFICATION\_FAILED                           |                          |
| Managed user creation limit exceeded.                                                                                      | 0067             | MANAGED\_USER\_LIMIT\_EXCEEDED                      |                          |
| Captcha is invalid.                                                                                                        | 0025             | INVALID\_CAPTCHA                                    |                          |
| preference {0} already exits in the org {1}.                                                                               | 0068             | PREFERENCE\_ALREADY\_EXIST                          |                          |
| Declared user error status is not updated.                                                                                 | 0069             | DECLARED\_USER\_ERROR\_STATUS\_IS\_NOT\_UPDATED     |                          |
| Declared user validated status is not updated.                                                                             | 0071             | DECLARED\_USER\_VALIDATED\_STATUS\_IS\_NOT\_UPDATED |                          |
| preference {0} not found in the org {1}.                                                                                   | 0070             | PREFERENCE\_NOT\_FOUND                              |                          |
| Consent status is invalid.                                                                                                 | 0026             | INVALID\_CONSENT\_STATUS                            |                          |
| userType config is empty for the statecode {0}.                                                                            |                  | USER\_TYPE\_CONFIG\_IS\_EMPTY                       |                          |

### Example API Response:

```
{
    "id": "api.manageduser.create",
    "ver": "v1",
    "ts": "2022-05-04 09:17:53:491+0000",
    "params": {
        "resmsgid": "8794af3c-0892-064d-c545-b380c709b2f1",
        "msgid": "8794af3c-0892-064d-c545-b380c709b2f1",
        "err": "UOS_USRCRT0030",
        "status": "FAILED",
        "errmsg": "Mandatory parameter firstName is missing."
    },
    "responseCode": "CLIENT_ERROR",
    "result": {}
}
```

### Backward Compatibility issues:

1. Currently, we are sending error responses like below

```
{
    "id": "api.user.create",
    "ver": "v3",
    "ts": "2021-11-04 08:17:51:650+0000",
    "params": {
        "resmsgid": null,
        "msgid": "5117b608b566c7699ec6e56670db0a0f",
        "err": "SOME_ERROR_STRING", 
        "status": "SOME_ERROR_STRING",
        "errmsg": "Erro Message."
    },
    "responseCode": "CLIENT_ERROR",
    "result": {}
}
```

And mobile App is currently using :

\*\*params.status \*\* is used in following place&#x20;

params.status === 'MANAGED\_USER\_LIMIT\_EXCEEDED'&#x20;

\*\*params.err \*\* is used in the following place&#x20;

params.err === 'OTP\_VERIFICATION\_FAILED'

params.err === 'ERROR\_RATE\_LIMIT\_EXCEEDED'

***

\[\[category.storage-team]] \[\[category.confluence]]
