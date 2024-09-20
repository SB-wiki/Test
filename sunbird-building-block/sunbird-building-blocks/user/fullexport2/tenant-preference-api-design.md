  * [Intent](#intent)
  * [API endpoints (proposed and enhancements)](#api-endpoints-(proposed-and-enhancements))
    * [POST v2/org/preferences/create](#post-v2/org/preferences/create)
  * [Legacy - Existing table structure:](#legacy---existing-table-structure:)

## Intent
We have an existing tenant preferences API’s read, add, and update. This can be enhanced for storing tenant specific settings. One such could be the certificate templates, such as SVG/HTML and issuer details. These are completely going to be managed by consumption and implementation teams - pretty much like form-config APIs. 

Note form-config gives the illusion of ‘form’ and UI specific artifacts. This is one of the reason we wanted to shift away from and create these.

Table (proposed in 3.2.)
```sql
CREATE TABLE IF NOT EXISTS sunbird.tenant_preference_v2 (
data text,
key text, 
orgid text, 
createdon timestamp,
createdby text,
updatedon timestamp,
updatedby text,
PRIMARY KEY (orgid, key)
);
```

## API endpoints (proposed and enhancements)

### POST v2/org/preferences/create
Request :
```json
{
    "request": {
        "orgId": "", //string origanization id mandatory 
        "key": "teacher_declarations",//string mandatory, this is a sample
        "data": {} //object mandatory 
    }
}
```
Response:
* Success Response 




```json
{
    "id": "api.org.preferences.create",
    "ver": "v2",
    "ts": "2020-08-04 18:40:47:142+0530",
    "params": {
        "resmsgid": null,
        "msgid": "52b2e453-09bb-4cf3-b5a5-fa3dda1335b5",
        "err": null,
        "status": "success",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "response": "SUCCESS",
        "orgId": "0130137992154152961",
        "key": "teacher_declarations"
    }
}
```

* Missing Mandatory param




```json
{
    "id": "api.org.preferences.create",
    "ver": "v2",
    "ts": "2020-08-04 18:40:06:376+0530",
    "params": {
        "resmsgid": null,
        "msgid": "d09558a0-2a4b-4023-8421-5a305b79ca06",
        "err": "MANDATORY_PARAMETER_MISSING",
        "status": "MANDATORY_PARAMETER_MISSING",
        "errmsg": "Mandatory parameter request.data is missing."
    },
    "responseCode": "CLIENT_ERROR",
    "result": {}
}
```

* Data type error




```json
{
    "id": "api.org.preferences.create",
    "ver": "v2",
    "ts": "2020-08-04 18:39:26:727+0530",
    "params": {
        "resmsgid": null,
        "msgid": "0867d734-3644-40d8-923b-34c695974a91",
        "err": "DATA_TYPE_ERROR",
        "status": "DATA_TYPE_ERROR",
        "errmsg": "Data type of request.key should be java.lang.String."
    },
    "responseCode": "CLIENT_ERROR",
    "result": {}
}
```

* Preference already exists




```json
{
    "id": "api.org.preferences.create",
    "ver": "v2",
    "ts": "2020-08-04 16:31:59:417+0530",
    "params": {
        "resmsgid": null,
        "msgid": "73fd02a8-5cee-4008-9fdb-1a54ce2eeb98",
        "err": "PREFERENCE_ALREADY_EXIST",
        "status": "PREFERENCE_ALREADY_EXIST",
        "errmsg": "preference teacher_declarations already exits in the org 0130137992154152961"
    },
    "responseCode": "CLIENT_ERROR",
    "result": {}
}
```
POST v2/org/preferences/readRequest
* Success Response 




```json
{
   "request": {
       "orgId": "",//mandatory
       "key":   "" ,//mandatory
   }
}
```
Response 
```json
{
   "id": "api.org.preferences.read",
   "ver": "v2",
   "ts": "2020-08-03 13:27:57:630+0530",
   "params": {
       "resmsgid": null,
       "msgid": "1d8ba02a-c22d-49cc-8666-f54d6f8d6381",
       "err": null,
       "status": "success",
       "errmsg": null
   },
   "responseCode": "OK",
   "result": {
   “response”
   {
      "data": ""
      "orgId": "",
      "key": "",
      "createdBy":"",
      "createdOn":"",
      "updatedOn":"",
      "updatedBy":""
   }
  }
}

```

* Failure Response




```json
{
   "id": "api.org.preferences.read",
   "ver": "v2",
   "ts": "2020-07-27 13:20:04:203+0530",
   "params": {
       "resmsgid": null,
       "msgid": "56db0a8e-1f39-476e-9675-3154dd7d8cdb",
       "err": "PREFERENCE_NOT_FOUND",
       "status": "PREFERENCE_NOT_FOUND",
       "errmsg": "prefernce teacher_declarations not found in org 3243435435."
   },
   "responseCode": "RESOURCE_NOT_FOUND",
   "result": {}
}

```
PATCH: v2/org/preferences/updateRequest
```json
{
    "request":{
        "orgId":"",//mandatory
        "key": "",//mandatory
        "data": {, //mandatory, data need to be updated
        }
    }
}
```
Response
* Success Response




```json
{
    "id": "api.org.preferences.update",
    "ver": "v1",
    "ts": "2020-08-06 23:24:56:485+0530",
    "params": {
        "resmsgid": null,
        "msgid": "a670b165-d8eb-4b02-b98a-ee47d7e34f5f",
        "err": null,
        "status": "success",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "response": "SUCCESS"
    }
}
```

* Failure Response:




```json
{
    "id": "api.org.preferences.update",
    "ver": "v1",
    "ts": "2020-08-06 20:30:08:385+0530",
    "params": {
        "resmsgid": null,
        "msgid": "b0e0b3b2-0586-469f-991c-bef503659a9f",
        "err": "PREFERENCE_NOT_FOUND",
        "status": "PREFERENCE_NOT_FOUND",
        "errmsg": "preference teacher not found in the org 23232"
    },
    "responseCode": "RESOURCE_NOT_FOUND",
    "result": {}
}
```

## Legacy - Existing table structure:

```sql
CREATE TABLE sunbird.tenant_preference (
    id text PRIMARY KEY,
    data text,
    key text,
    orgid text,
    role text,
    tenantname text
)
CREATE INDEX inx_tp_key ON sunbird.tenant_preference (key);
CREATE INDEX inx_tp_userid ON sunbird.tenant_preference (orgid);
```


*****

[[category.storage-team]] 
[[category.confluence]] 
