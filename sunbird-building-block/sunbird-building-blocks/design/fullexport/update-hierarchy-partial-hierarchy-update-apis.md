# Update-Hierarchy---Partial-Hierarchy-Update-APIs

### Background

For any collection contents, to add or remove a leaf node from the hierarchy, the entire hierarchy needs to sent as part of update hierarchy request. This requires a huge amount data transfer over the network as the request is proportionate to the entire hierarchy of a collection.

### Solution

In order to provide facility to add or remove children to a unit level in the hierarchy, we have the below APIs.

#### Add leafNodes to hierarchy :&#x20;

This API facilitates user to add list of children to a unit in the hierarchy under a collection content

**PATCH: /content/v3/hierarchy/add**

```
Request:

{
    "request": {
        "rootId" : "{collection root ID}",
		"unitId" : "{first Level parent of the children}",
		"children": [{List of children to be added}]
    }
}
```

```
Response:
{
     "id": "api.content.hierarchy.add",
     "ver": "3.0",
     "ts": "YYYY-MM-DDThh:mm:ssZ+/-nn.nn",
     "params": {
          "resmsgid": "",
          "msgid": "",
          "err": "",
          "status": "successful",
          "errmsg": ""
     },
     "responseCode": "OK",
     "result": {
          "identifier": "{root ID}"
		  "unitId" : [{List of children added}]
     }
}
```

#### Remove leafNodes from hierarchy

This API removes the list of children from a unit in the hierarchy of a collection content.

**DELETE: /content/v3/hierarchy/remove**

```
Request: 
{
    "request": {
        "rootId" : "{collection root ID}",
		"unitId" : "{first Level parent of the children}",
		"children": [{List of children to be removed}]
    }
}


```

```
Response:
{
     "id": "api.content.hierarchy.remove",
     "ver": "3.0",
     "ts": "YYYY-MM-DDThh:mm:ssZ+/-nn.nn",
     "params": {
          "resmsgid": "",
          "msgid": "",
          "err": "",
          "status": "successful",
          "errmsg": ""
     },
     "responseCode": "OK",
     "result": {
          "identifier": "{root ID}"
     }
}
```

***

\[\[category.storage-team]] \[\[category.confluence]]
