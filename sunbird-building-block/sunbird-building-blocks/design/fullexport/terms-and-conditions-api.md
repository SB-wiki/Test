# Terms-&-Conditions--API

**Overview** Every user need to Accept the terms and conditions in order to access the portal:

* **Case 1** : Existing user, will be flagged with terms & conditions flag will be set to false.
* **Case 2** : Whenever a new user registers his terms & conditions flag will be set to false.
* **Case 3** : When the terms & conditions are changed - In this scenario we will get the accepted version of TnC from user and the latest version of TnC from systemSetting, if there is any difference in the version we will ask user to accept the TnC again.

After login, we will detect - if user needs to accept the terms of condition - in either of above cases, we will present him with screen to accept the same.

Applicability/configuration of terms and conditions will be based on chosen approach.

**Assumption:** We do not propose to create API for creating/updating terms & conditions.

We need to provide only accept TnC api. Terms and condition page will be hosted on portal and app will also use same html page. when ever terms and condition page change, user need to update the new terms and condition version under system settings table.

**Approach 1:** We can create terms & conditions - globally - i.e. per installation basis.

**Approach 2:** We can support terms & conditions - per channel basis - i.e. Each channel can have a different terms and conditions.

We recommend **Approach 2** - so that within same installation - different organizations, have the flexibility to update terms & conditions of their own.

**Solution based on Approach 2( Approach 1 is just a sub-set)** **Approach**

* Terms & Conditions will be stored as public html page on portal itself.
* Admin has to update the system settings table, whenever the TnC page and version is modified.
* After successful login - portal will call read user api.
* This api response will contain - a flag - based on which portal can redirect the user to Accept Term & Conditions page.
* The above flag will be calculated based on following two conditions
  * if tncversion is null in user table, for the logged in user, showTnC flag will be marked to true
  * if tncversion is not null and does not match with version stored in System Settings table, flag will be marked true
* API will also contain tncaccpteddate & tncversion - for information purpose only - it might get used in future, if we want to show it to the user.
* Each time user accepts a new version of TnC - > Telemetry Audit event will be generated.

\*\*DB changes \*\* Changes to user table

| Column        | Changes                                        |
| ------------- | ---------------------------------------------- |
| tncacceptedon | Added  - will store latest tnc accepted date   |
| tncversion    | added - will store latest tnc accepted version |

**Note** : columns tcstatus & tcupdateddate - will be removed as part of table clean-up - which are actually not being used

Storage in System SettingsWe will add one system setting → tncConfiguration, which will store the applicable tncVersions per channel basis in following format.

Admin has to update the system settings table for applicable channel , for new tncVersion to be impacted.

```
tncConfig{
  latestVersion=v2,
  v2{
    url=htmllink
  },
  v1{
    url=htmllink
  }
}
```

#### Changes to existing API

**GET** /user/v1/read/:uid

→ Will add following keys to the response:

tncAcceptedOn: informational purpose

tncAcceptedVersion: informational purpose

tncLatestVersion: Latest version to be accepted by user.

tncLatestVersionUrl: link to HTML page.

promptTnC: true or false

→ promptTnC is true → user will be prompted for terms & conditions acceptance page.

→ promptTnC is false → user will not be propmted for terms & conditions acceptance page

#### APIs Added

1.  Accept TnC&#x20;

    \*\*POST \*\* /user/v1/tnc/accept

```
{
  "request": {

        "version" : "v2"
  }
}
```

```
 **Note** : Version will be identified from System settings. system settings will have identifier as "tncConfiguration" that will hold terms and condition version and other details. User Id will be taken from "x-authenticated-user-token".
```

**Response**

**200 OK** - Terms & conditions accepted successfully

**401 Unauthorized  -** In case user API is called without proper user-access token.

***

\[\[category.storage-team]] \[\[category.confluence]]
