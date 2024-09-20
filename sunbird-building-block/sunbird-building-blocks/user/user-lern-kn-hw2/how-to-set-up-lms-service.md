# How-to--Set-up-lms-service

This Document provides steps for setting-up lms service in local.

### Instructions

Create a step-by-step guide:

1. &#x20;clone sunbird-lms-mw, sunbird-lms-service, sunbird-utils, sunbird-auth
2. Install and start cassandra
3. Install key clock service, creat admin and user(optinal), for admin change password and customise key expiry timings in the token tab(Access Token Lifespan, Access Token Lifespan For Implicit, else the password will expiry for one minute)
4.  &#x20;start elastic search (v 5.4.0, for remaining versions application have some issues)&#x20;

    1. execute curl commands of searchindex , and mapping command in the following page:

    [https://project-sunbird.atlassian.net/wiki/spaces/SBDES/pages/952566009/Elasticsearch+Type+Mapping](https://project-sunbird.atlassian.net/wiki/spaces/SBDES/pages/952566009/Elasticsearch+Type+Mapping)

then execute follwoing curl commands

curl -XPUT '{ip}:9200/sunbirdplugin?pretty' -H 'Content-Type: application/json' -d'

```
{

"settings" : {"analysis": {"analyzer": {"cs_index_analyzer": {"type": "custom","tokenizer": "standard","filter": \["lowercase","mynGram"]},"cs_search_analyzer": {"type": "custom","tokenizer": "standard","filter": \["lowercase","standard"]},"keylower": {"type": "custom","tokenizer": "keyword","filter": "lowercase"}},"filter": {"mynGram": {"type": "ngram","min_gram": 1,"max_gram": 20,"token_chars": \["letter", "digit","whitespace","punctuation","symbol"]} }}}

}'



curl -XPUT '{ip}:9200/sunbirdplugin/announcementtype/_mapping?pretty' -H 'Content-Type: application/json' -d'{"dynamic_templates":\[{"longs":{"match_mapping_type":"long","mapping":{"fields":{"raw":{"type":"long"}},"type":"long"}}},{"booleans":{"match_mapping_type":"boolean","mapping":{"fields":{"raw":{"type":"boolean"}},"type":"boolean"}}},{"doubles":{"match_mapping_type":"double","mapping":{"fields":{"raw":{"type":"double"}},"type":"double"}}},{"dates":{"match_mapping_type":"date","mapping":{"fields":{"raw":{"type":"date"}},"type":"date"}}},{"strings":{"match_mapping_type":"string","mapping":{"analyzer":"cs_index_analyzer","copy_to":"all_fields","fielddata":true,"fields":{"raw":{"type":"text","fielddata":true,"analyzer":"keylower"}},"search_analyzer":"cs_search_analyzer","type":"text"}}}],"properties":{"all_fields":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower"}},"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer"},"createddate":{"type":"date","fields":{"raw":{"type":"date"}}},"id":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":\["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"identifier":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":\["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"name":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":\["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"rootorgid":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":\["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"status":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":\["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true}}}'
```

execute above curl command with changing mapping types for given below too:

cbatch

```
content

badgeassociations

user

org

usercourses

usernotes

history

userprofilevisibility

telemetry

location

announcementtype

announcement

metrics



```

1.  copy to environment variables and source them

    export sunbird\_cassandra\_host="127.0.0.1"

    export sunbird\_cassandra\_port="9042"

    export sunbird\_es\_host="127.0.0.1"

    export sunbird\_es\_port="9300"

    export sunbird\_sso\_url="[http://localhost:8080/auth/](http://localhost:8080/auth/)"

    export sunbird\_sso\_realm="master"

    export sunbird\_sso\_username="adminuser"

    export sunbird\_sso\_password="adminuser"

    export sunbird\_sso\_client\_id="admin-cli"

    export sunbird\_encryption\_key="encKeyValue"

    export sunbird\_encryption\_mode="local"

    export sunbird\_sso\_publickey= (for this value is copied from keyclock service)
2.  &#x20;run follwoing commands in bashcqlsh -f cassandra.cql

    cqlsh -e "COPY sunbird.page\_management(id, appmap,createdby ,createddate ,name ,organisationid ,portalmap ,updatedby ,updateddate ) FROM '/tmp/cql/pageMgmt.csv'"

    cqlsh -e "COPY sunbird.page\_section(id, alt,createdby ,createddate ,description ,display ,imgurl ,name,searchquery , sectiondatatype ,status , updatedby ,updateddate) FROM '/tmp/cql/pageSection.csv'"

the above three files are in the lms-service

1. &#x20;go to cassandra-migration which is in sunbird-utils project, exec "mvn clean install" then run "mvn exec:java"
2. go to lms-service pom path and execute mvn play2:run -Dplay2.serverJvmArgs="-Xdebug -Xrunjdwp:transport=dt\_socket,server=y,suspend=n,address=9999"
3. &#x20;run create organisation api from postman collection, in response we will get organisation id,
4. &#x20;run below query in cassandra's cqlsh, enter organisation id in the 3rd value

cqlsh> insert into sunbird.system\_settings (id,field,value) values ('custodianOrgId','custodianOrgId','0127292552989900801');

insert into sunbird.system\_settings (id,field,value) values ('userProfileConfig','userProfileConfig','{"fields":\["firstName","lastName","profileSummary","avatar","countryCode","dob","email","gender","grade","language","location","phone","subject","userName","webPages","jobProfile","address","education","skills","badgeAssertions"],"publicFields":\["firstName","lastName","profileSummary"],"privateFields":\["email","phone"],"csv":{"supportedColumns":{"NAME":"firstName","MOBILE PHONE":"phone","EMAIL":"email","SCHOOL ID":"orgId","USER\_TYPE":"userType","ROLES":"roles","USER ID":"userId","SCHOOL EXTERNAL ID":"orgExternalId"},"outputColumns":{"userId":"USER ID","firstName":"NAME","phone":"MOBILE PHONE","email":"EMAIL","orgId":"SCHOOL ID","orgName":"SCHOOL NAME","userType":"USER\_TYPE","orgExternalId":"SCHOOL EXTERNAL ID"},"outputColumnsOrder":\["userId","firstName","phone","email","organisationId","orgName","userType","orgExternalId"],"mandatoryColumns":\["firstName","userType","roles"]},"read":{"excludedFields":\["avatar","jobProfile","address","education","webPages","skills"]},"framework":{"fields":\["board","gradeLevel","medium","subject","id"],"mandatoryFields":\["board","gradeLevel","medium","id"]\}}');

insert into sunbird.system\_settings (id,field,value) values ('orgProfileConfig','orgProfileConfig','{"csv":{"supportedColumns":{"SCHOOL NAME":"orgName","BLOCK CODE":"locationCode","STATUS":"status","SCHOOL ID":"organisationId","EXTERNAL ID":"externalId","DESCRIPTION":"description"}, "outputColumns": {"organisationId":"SCHOOL ID","orgName":"SCHOOL NAME","locationCode":"BLOCK CODE","locationName":"BLOCK NAME","externalId":"EXTERNAL ID"}, "outputColumnsOrder":\["organisationId","orgName","locationCode", "locationName","externalId"],"mandatoryColumns":\["orgName","locationCode","status"]\}}');

1. run create user api.

Highlight important information in a panel like this one. To edit this panel's color or style, select one of the options in the menu below.

### Related articles

The content by label feature displays related articles automatically, based on labels you choose. To edit options for this feature, select the placeholder below and tap the pencil icon.

false5com.atlassian.confluence.content.render.xhtml.model.resource.identifiers.SpaceResourceIdentifier@a98falsemodifiedtruepagelabel = "kb-how-to-article" and type = "page" and space = "UM"kb-how-to-article

true

|   |
| - |
|   |

***

\[\[category.storage-team]] \[\[category.confluence]]
