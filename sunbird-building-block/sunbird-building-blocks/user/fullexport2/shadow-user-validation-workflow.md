# Shadow-User-Validation-Workflow

### **Release Version** : 2.7.0

### **Ticket Reference:** [SB-16235](https://project-sunbird.atlassian.net/browse/SB-16235)

\*\*Overview: \*\* Proposed Validation's changes

1. Mandatory/Optional field while uploading files should be configurable w.r.t Tenants.
2. Runtime determination of Primary identifier's(email or phone) which should be used to match(or while searching) the custodian user, according to Tenant provided config.
3. The config should be set to ask/ignore \{{Teacher Id\}} i.e ext user id while migration or not,  this config also provided by the Tenant.

### Changes impact:

&#x20;Changes impact will be on platform-user, portal and mobile app.

&#x20;      1 Making teacher external id as configurable (mandatory for some tenants and optional for some)

* &#x20;Based on this changes caller need to know for whcih channel they need to ask for teacher external id validation and for which it should not? &#x20;
* Migration api need to be modified to relax teacher external id validation based on config channel
* shadow user upload api need to be modified
* currently if an entry present inside shadow db by matching on (teacher-external-id and channel), it will override some attribute with new data. in case teacher external id is optional then on re-upload it will always add new entry this will increase duplicate data inside shadow db.
* Shadow db(table) need to be restructure and need to provide migration script to migrate old data into new table structure (in current table user external id and channel are part of primary key)

&#x20;     2  Making phone/email as configurable for identity match

* changes required in shadow user upload api, based on channel settings for identity match , data need to be validated
* changes required in scheduler job to do shadow user identity match based on channel config value  &#x20;

&#x20;    3\. Instead of making teacher external id as configurable, we can make it optional , if state had then provide during upload and if not then don't provide it.     4. In current system either email or phone is mandatory , If some state want to migrate user base on phone match only, then they should upload file with phone number , no need to pass email  and vice versa . if some state want to match user based on both identifier then they can upload user by providing phone and email both. If we can educate admin then no need to do any changes for identity match. &#x20;

### Workflow Changes

**Configurable Mandatory/optional field's:** \*\*  Solution 1:\*\*

* \*\* Require code changes\*\*  Optional/Mandatory field's can to be set in _system\_settings_ table(Tenant wise) so changing the value in the _system\_setting_  will achieve the proposed workflow.

&#x20;          &#x20;

```java
 id    | shadowConfig_{{channel}}
 field | shadowConfig_{{channel}}
 value | {"csv":{"mandatoryFields":["email","Name","Input Status"],"supportdFields":["email","phone","Name","Ext User ID","Input Status"],"identifier":"email/phone"}}

```

* **Implementation Effort** : For Each Tenant, This value needs to be set manually or either using  API post /system/settings/set to set the value in Cassandra.
* one default value need to be set for those channel , which don't have any settings . for default id can be "shadowConfigDefault"

&#x20;&#x20;

| Pros                                                                                               | Cons                                                                                     |
| -------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------- |
| No changes in existing api.                                                                        | ideally System settings need to be used for System level configuration , not per channel |
| Since couple of configuration already set inside system settings , so this can also achieved by it | once number of rootOrg will grow , entry inside system settings will also grow           |
|                                                                                                    |                                                                                          |

**Solution 2:** \*\*   \*\* Since these all settings directly related to Organisations. So we can enhance org entity to support  different kind of configuration.

&#x20; &#x20;

```js
Organisation:
id
...
Configurations:[{"type":"shadowConfig","value":"{"csv":{"mandatoryFields":["email","Name","Input Status"],"supportdFields":["email","phone","Name","Ext User ID","Input Status"],"identifier":"email/phone"}}
"},{}]
// organisation will have configurations list, each configuration object will have type and value. 


```

| Pros                                                                                                                            | Cons                                                                                           |
| ------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| Configuration attribute is store inside organisation , which seems a correct place of it.                                       | Still default configuration need to be set inside system-settings                              |
| it's good to have configuration capabilities per org or channel .For other configuration value can be appended under same list. | since current configuration is applicable for rootorg only , so suborg will have value as null |
|                                                                                                                                 |                                                                                                |

To support this org update api need to be modified to accept configuration values.

**Configurable Value for Primary Identifier's**

* **Current Behaviour** : if an entry has either of the phone or email then the user will be searched on the basis of $or filter in Elasticsearch so if multiple user found then the entry will be not valid for migration.if the tenant only wants to match custodian user with email then the only email can be given in CSV file, current shadow user behavior will be able to handle this, so NO further code changes required.
* **Proposed Changes** :  &#x20;
  * **Effort** : Needs to set another config value for primary identifier under Tenant entry  in _system\_settings_ table and on the basis of that will decide the identifier, custodian user to be searched in ES. Code Changes Required.
  *

```java
 id    | shadowConfig_{{channel}}
 field | shadowConfig_{{channel}}
 value | {"csv":{"identifier":"email/phone","mandatoryFields":["email","phone","Name","Ext User ID","Input Status"]}}
```

**Ask/Ignore ext user-id at the time of Migration**

* Respective Tenant entries  have mandatoryFields in _system\_settings_  table which will help in determining whether to ask/ignore the ext user id(i.e teacher id) when the user is performing the migration. Required Code changes.

***

\[\[category.storage-team]] \[\[category.confluence]]
