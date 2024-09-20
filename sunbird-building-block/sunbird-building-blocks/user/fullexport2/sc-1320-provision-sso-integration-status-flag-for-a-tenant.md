# SC-1320-Provision-SSO-integration-status-flag-for-a-tenant

* [Problem statement:](sc-1320-provision-sso-integration-status-flag-for-a-tenant.md#problem-statement:-)
* [Solution 1: ](sc-1320-provision-sso-integration-status-flag-for-a-tenant.md#solution-1: )
* [Workflow:](sc-1320-provision-sso-integration-status-flag-for-a-tenant.md#workflow:)
* [Solution 2: ](sc-1320-provision-sso-integration-status-flag-for-a-tenant.md#solution-2: )
* [Solution 3:](sc-1320-provision-sso-integration-status-flag-for-a-tenant.md#solution-3:)
* [Points:](sc-1320-provision-sso-integration-status-flag-for-a-tenant.md#points:)
* [Conclusion:](sc-1320-provision-sso-integration-status-flag-for-a-tenant.md#conclusion:)

### Problem statement: [SC-1320](https://project-sunbird.atlassian.net/browse/SC-1320)

In current system , we can't get to know how many states(ref: rootOrg) are using SSO. Once number of states will grow , it's difficult for portal to show/hide SSO page.

### Solution 1:&#x20;

System will add a new attribute "isSSOEnabled" with value "true/false" inside cassandra and ES both.This attribute will be supported in following endpoints.

* Create org (org/v1/create) →  This attribute will be applicable for roorOrg only. The suborg value will be derived and can't be over-ridden. ie. if rootOrg has ssoEnabled, then all its subOrgs will also have ssoEnabled.
* update org (org/v1/update) →  During org update as well user can add/update this attribute value. This is applied for rootOrg only , for suborg this attribute will be silently ignored.

### Workflow:

When ever any request came for root org create/update with attribute isSsoEnabled then data will be updated into cassandra (as primary) storage and a background job will run to syn same data inside elasticsearch as well.

**System is not going to do data migration for old rootOrg, So consumer need to make sure if "isSSOEnabled" is present with value true then only assume true condition , others all are fail condition. (absent of "isSSOEnabled" key or present with value false).**

### Solution 2:&#x20;

&#x20;System will create a new attribute "flagsValue"  that will store an int. In that case one attribute inside cassandra can hold multiple values. Inside elasticsearch each attribute will be store separately. During syn system will read flagsvalue attribute and decide what are attribute need to be set.&#x20;

* Flag value can be set in create/update/bulk org operation.
* There is no migration script needed for existing org . if attribute is false or not present in response then consumer need to handle it.

### Solution 3:

&#x20;     This attribute can be added inside system setting. As number of rootOrg is not expected too much.&#x20;

&#x20;     it will have following pros:

* No need to do any data migration for exisitng org
* As this attribute is applicable for rootOrg only and it's not core attribute of organisation&#x20;
* putting this outside will reduce testing impact , becuase no existing code change required.&#x20;
* Get system setting api is already consume by portal and app  &#x20;
* Update can be happen either using cql or update system settings api&#x20;

&#x20;    &#x20;

```sql
insert into system_settings (id,field,value) values ('ssoConfig','ssoConfig','[{"id":"rootorg1","isSsoEnabled":true}]');
// To update next time
update system_settings set value='[{"id":"rootorg1","isSsoEnabled":false},{"id":"anotherRootOrg","isSsoEnabled":true}]' where id='ssoConfig';

// Update api:
URI: /data/v1/system/settings/set
Request body :
{
    "request": {
        "id": "ssoConfig",
        "field": "ssoConfig",
        "value": [
            {
                "id": "rootorg1",
                "isSsoEnabled": false
            }
        ]
    }
}
```

&#x20;    &#x20;

```js
 1. Create org: org/v1/create
  {
    "request": {
        "orgName": "name of the organisation",
        "description": "Organisation description",
        "channel": "channelName",
        "isSSOEnabled": true,
        "isRootOrg": true
    }
}


2. update org : org/v1/update

{
    "request": {
        "organisationId": "012635560833949696142",
        "isSSOEnabled": true
    }
}
```

### Points:

&#x20;\* As this is one time activity and bulk support doesn't required, so thinking to enhance create and update org api only. No change in bulk org upload.

### Conclusion:

&#x20;   As per discussion with DC we agree to implement solution 1.&#x20;

&#x20;&#x20;

***

\[\[category.storage-team]] \[\[category.confluence]]
