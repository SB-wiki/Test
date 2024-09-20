# Kong-App-ID-Plugin

### Problem

Different application consuming the API’s but the backend has no idea who is consuming it and from where the request coming is from.&#x20;

### Solution

This problem can be solved if an application sends its ID with an API request.

### Implementation

To implement this unique App ID can be issued to each application that they should send with an API request.

**App ID Validation**

The validation will be needed to verify if the application sending the correct App ID which is assigned to them. This validation can be done in Kong API gateway by writing the custom plugin. Before forwarding the request to upstream services plugin will validate App ID by getting the consumer ID from JWT plugin and then APP ID mapped to the consumer ID from the database. If the App ID sent with a request is same as a mapped for a consumer in DB then request will be forwarded to upstream service otherwise it will throw 403 access forbidden error with the error message `Invalid app ID`.

**Performance**

The plugin may need to frequently access datastore on every request to get the APP ID associated with the consumer for validation. This would happen on every request, and it would be very inefficient:

* Querying the datastore adds latency on every request, making the request processing slower.
* The datastore would also be affected by an increase of load, potentially crashing or slowing down, which in turn would affect every Kong node.

**Solution**

To avoid querying the datastore every time, we can cache custom entities in-memory on the node, so that frequent entity lookups don't trigger a datastore query every time, but happen in-memory, which is much faster and reliable than querying it from the datastore (especially under heavy load).

\*\*A. Lazy caching: \*\* Cache custom entities in-memory on the node on the first request, so that frequent entity lookups don’t trigger a datastore query every time (only the first time), but happen in-memory. On every first request by a consumer, associated App IDs to requester consumer will be retrieved from datastore and that will be cached, but If there are no APP IDs associated then empty App ID's arrays will be cached.&#x20;

By doing so it doesn’t matter how many requests the consumer makes, after the first request every lookup will be done in-memory without querying the datastore.

* &#x20;Pros
  * Size of cache will be less as it will cache the records that are in use.
  * The object is loaded from the datastore only one time per consumer. &#x20;
* Cons
  * In a multi node cluster, the data store may be hit once per node per consumer since the cache is local

We will use the following kong utility method to get APP-ID mapped to consumer. The method takes care of querying the datastore only the first time. Subsequent calls will return cached data.

| Method                                                                                                        | Description                                                                                                                                                                                                                                                                                                                                                                                          |
| ------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [value = cache.get\_or\_set(key, function)](https://docs.konghq.com/0.9.x/plugin-development/entities-cache/) | This is an utility method that retrieves an object with the specified key, but if the object is nil then the passed function will be executed instead, whose return value will be used to store the object at the specified key. This effectively makes sure that the object is only loaded from the datastore one time, since every other invocation will load the object from the in-memory cache. |

\*\* B. Full table cache on kong service start:\*\* Cache the all the records exist in the table on every node immediately after kong service start, so entity lookups don’t trigger a datastore query every time.  \*\* \*\* \*\* \*\*

* **Pros**
  * No lookup on the data-store except initial so it will help for reducing latency in request response time.&#x20;
* \*\* Cons  \*\* &#x20;
  * If the database is size is large then the cache and invalidation process will take time.&#x20;
  * Every Node will query datastore after the start of service that will put a load on data-store for some time.&#x20;
  * It will cache the all records even if record not in use and that will unnecessarily increase cache size on every node.&#x20;

Kong does not seem to have a specific "event" that is broadcasted on startup, so this approach may not be feasible. init\_worker is available, but the implementation for that seems complex.

**Cache Storage**

The cache will be stored in the key-value pair where the **key** will be **'appid'.consumer\_id** and **value** will be an **array of APP ids.**

**E.g**

{ appid.e1a622e8-c351-432a-83f5-a4e0e300449c : \["Portal", "Mobile"] }

{ appid.89a41fef-3b40-4bb0-b5af-33da57a7ffcf : \["NTP"] }

{ appid.2fc51405-5991-44c3-b851-bf5c88be8310 : \[ ] }

**Cache Invalidation**

Every time an entity is being created/updated/deleted in the datastore, Kong notifies the datastore operation across all the nodes telling what command has been executed and what entity has been affected by it.&#x20;

We can listen to these events and response with the appropriate action, so that when a cached entity is being modified in the datastore, we can explicitly remove it from the cache to avoid having an inconsistent state between the datastore and the cache itself. Removing it from the in-memory cache will trigger the system to query the datastore again, and re-cache the entity.

The events that Kong propagates are:

| EVENT NAME      | DESCRIPTION                       |
| --------------- | --------------------------------- |
| ENTITY\_CREATED | When any entity is being created. |
| ENTITY\_UPDATED | When any entity is being updated. |
| ENTITY\_DELETED | When any entity is being deleted. |

In order to listen to these events, we need to implement the hooks.lua file and distribute it with our plugin, for example:

```xml
-- hooks.lua

local events = require "kong.core.events"
local cache = require "kong.tools.database_cache"

local function invalidate_on_update(message_t)
  if message_t.collection == "appids" then
    cache.delete("appid."..message_t.old_entity.consumer_id)
  end
end

local function invalidate_on_delete(message_t)
  if message_t.collection == "appids" then
    cache.delete("appid."..message_t.entity.consumer_id)
  end
end

return {
  [events.TYPES.ENTITY_UPDATED] = function(message_t)
    invalidate_on_update(message_t)
  end,
  [events.TYPES.ENTITY_DELETED] = function(message_t)
    invalidate_on_delete(message_t)
  end
}


```

In the example above the plugin is listening to the ENTITY\_UPDATED and ENTITY\_DELETED events and responding by invoking the appropriate function. The message\_t table contains the event [properties](https://docs.konghq.com/0.9.x/plugin-development/entities-cache/)

**Error message**

* **If App ID is not sent with the request:** X-APP-ID can't be blank
* **Consumer and APP-ID mapping doesn't exist:**   Consumer and X-APP-ID mapping doesn't exist
* \*\*Invalid App ID: \*\* Invalid X-APP-ID

**Questions / Note**

1. Can we map same APP ID to different consumers ?
2. Process for issuing app id needs to be updated - for developer installation (in this case Sunbird credentials are needed and provided by support team) and for server installation (in this case Ekstep credentials will be needed which the developer currently creates himself)

**Migration**

1. Existing consumers that are using app id need to be updated

**Proposed format for appid**

To ensure the app ids are named consistently, the following format is proposed

.

Eg: arghyam.mobile\_app, shikshalokam.portal

The app id allows lowercase alphabets, numbers and dot.&#x20;

\*\*Database table structure \*\*

| Column       | Type                   |
| ------------ | ---------------------- |
| id           | uuid, Primary Key      |
| consumer\_id | uuid, Not Null         |
| appid        | varchar(100), Not Null |
| created\_at  | timestamp              |

#### Enabling the plugin on an API

Configure this plugin on an API by making the following request:

```
```

```
$ curl -X POST [http://localhost:8001/apis/](http://kong:8001/services/){api}/plugins \

--data "name=appid"




```

Associating App ID to Consumer

```
$ curl -X POST [http://](http://kong:8001/consumers/)[localhost](http://kong:8001/services/)[:8001/consumers/](http://kong:8001/consumers/){consumer}/appids \ 

 --data "appid={appid}"
```

```


{

 "appid": "{appid}",

 "Consumer_id": "e1a622e8-c351-432a-83f5-a4e0e300449c",

 "Created_at": 1541056142000,

 "Id": "9cad374f-006c-4ec2-aa3e-cdca58873c47"

}




```

Delete App ID Associated to Consumer

```
$ curl -X DELETE [http://localhost:8001/consumers/{consumer}/appid](http://localhost:8001/consumers/a8e5b7f1-841c-4001-a203-7fba4d816a09/plugins/rate-limiting)s/{appid}
```

Retrieve the App ID mapped to Consumer$ curl -X GET [http://localhost:8001/consumers/{consumer}/appid](http://localhost:8001/consumers/a8e5b7f1-841c-4001-a203-7fba4d816a09/plugins/rate-limiting)s

```xml
{
   "data":[
      {
         "created_at":1541419735000,
         "consumer_id":"e1a622e8-c351-432a-83f5-a4e0e300449c",
         "appid":"Portal",
         "id":"1b8e6843-7ecd-4b52-8349-a8159f22f8eb"
      },
      {
         "created_at":1541498560000,
         "consumer_id":"e1a622e8-c351-432a-83f5-a4e0e300449c",
         "appid":"NTP",
         "id":"1c96fd3a-0be4-4302-aeeb-eeb7d409ed14"
      },
      {
         "created_at":1541998382000,
         "consumer_id":"e1a622e8-c351-432a-83f5-a4e0e300449c",
         "appid":"Sunbird",
         "id":"888d3266-5450-4d0c-856e-502875d41c16"
      }
   ],
   "total":3
}
```

Retrieve all the App ID for all Consumers using the following request: _Note:_ Kong upgrade required

```
$ curl -X GET [http://](http://kong:8001/acls)[localhost](http://kong:8001/services/)[:8001/](http://kong:8001/acls)appids
```

```
{

    "total": 3,

    "data": \[

        {

            "appid": "diksha",

            "created_at": 1511391159000,

            "id": "724d1be7-c39e-443d-bf36-41db17452c75",

            "consumer_id": "89a41fef-3b40-4bb0-b5af-33da57a7ffcf"

        },

        {

            "appid": "sunbird",

            "created_at": 1511391162000,

            "id": "0905f68e-fee3-4ecb-965c-fcf6912bf29e",

            "consumer_id": "c0d92ba9-8306-482a-b60d-0cfdd2f0e880"

        },

        {

            "appid": "ekstep_portal",

            "created_at": 1509814006000,

            "id": "ff883d4b-aee7-45a8-a17b-8c074ba173bd",

            "consumer_id": "c0d92ba9-8306-482a-b60d-0cfdd2f0e880"

        }

    ]

}
```

You can filter the list using the following query parameters:

\|  ATTRIBUTES |  DESCRIPTION |  OPTIONAL | |  id |  A filter on the list based on the id field. |  Y | |  app\_id |  A filter on the list based on the app id field. |  Y | |  consumer\_id |  A filter on the list based on the consumer\_id field. |  Y | |  size |  A limit on the number of objects to be returned. |  Y default is 100 | |  offset |  A cursor used for pagination. An offset is an object identifier that defines a place in the list. |  Y |

**Retrieve consumers associated with the App Id**

```
Note: Kong upgrade required



$ curl -X GET http://[localhost](http://kong:8001/services/):8001/appids/{id}/consumer



{

  "created_at":1507936639000,

  "username":"foo",

  "id":"c0d92ba9-8306-482a-b60d-0cfdd2f0e880"

}
```

***

\[\[category.storage-team]] \[\[category.confluence]]
