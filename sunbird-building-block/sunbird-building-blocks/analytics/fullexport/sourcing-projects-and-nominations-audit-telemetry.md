 **Common AUDIT Event Structure:** 
```json
{
  "eid": , "AUDIT",
  "ets": , 1592803822,
  "ver": "3.0", 
  "mid": , "PRG.AUDIT.1592803822"
  "actor": { 
    "id": "<userid>", 
    "type":  "User"
  },
  // Context of the event
  "context": { 
    "channel": "<default_value>", 
    "pdata": { 
      "id": "org.sunbird.sourcing", 
      "pid": "program-service",
      "ver": 1.0
    },
    "env": "program",
    "cdata": []
  },
  "object": {}, // Required.
  "edata": {} // Required.
}
```

### Scenarios:


1. Sourcing Project - Create:
```json
{
  "eid": "AUDIT",
  "object": {
    "id": "<sourcing_project_id>",
    "type": "Program",
    "rollup": {}
  },
  "edata": {
    "type": "create",
    "state": "Draft",
    "prevstate": "",
    "props":["name","description","nomination_enddate","shortlisting_enddate","content_submission_enddate","content_types","template_id","rootorg_id","createdby","createdon","startdate","slug","status","type","enddate","config","program_id"]
  }
}

```
2. Sourcing Project - Update:
```json
{
  "eid": "AUDIT",
  "object": {
    "id": "<sourcing_project_id>",
    "type": "Program",
    "rollup": {}
  },
  "edata": {
    "type": "update",
    "state": "Draft",
    "prevstate": "Draft",
    "props": [ "name", "rolemapping.REVIEWER", "rolemapping.CONTRIBUTOR","updatedon"]
  }
}

```
3. Sourcing Project - Publish:
```json
{
  "eid": "AUDIT",
  "object": {
    "id": "<sourcing_project_id>",
    "type": "Program",
    "rollup": {}
  },
  "edata": {
    "type": "publish",
    "state": "Live",
    "prevstate": "Draft",
    "props": [ "collection_ids", "updatedon"]
  }
}
```
4. Nomination - Create:
```json
{
  "eid": "AUDIT",
  "object": {
    "id": "<sourcing_project_id>",
    "type": "nomination",
    "rollup": {}
  },
  "edata": {
    "type": "create",
    "state": "Initiated",
    "prevstate": "",
    "props": [ "program_id", "user_id", "organisation_id", "status", "content_types", "collection_ids", "createdby", "createdOn"]
  }
}
```
5. Nomination - Update:
```json
{
  "eid": "AUDIT",
  "object": {
    "id": "<sourcing_project_id>",
    "type": "nomination",
    "rollup": {}
  },
  "edata": {
    "type": "update",
    "state": "Pending",
    "prevstate": "Initiated",
    "props": [ "rolemapping.REVIEWER", "updatedon"]
  }
}
```




*****

[[category.storage-team]] 
[[category.confluence]] 
