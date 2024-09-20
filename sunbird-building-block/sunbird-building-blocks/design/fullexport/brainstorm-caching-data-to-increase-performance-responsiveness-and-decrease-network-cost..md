# \[Brainstorm]-Caching-Data-to-increase-performance,-responsiveness-and-decrease-network-cost.

**Background:** Sunbird platform is build on micro-service architecture, and has different service layers. Sunbird client application request data from different service based on requirement. Request goes through multiple service layer before its served by service. This increases network overhead and load on services. Sunbird doesn't have proper caching mechanism in place to server different request from clients.

![](<../../../../Design/FullExport/images/storage/Sunbird platform overview.png>)

**Solutions:** Client request that can be cached can be broadly classified into below categories.

**1. Static Assets:** Contains all the js, css, images, fonts etc.. These are either served from CDN or cached at Proxy. No changes required here.

Tenant Folder need to be cached at Proxy to avoid load on Portal backend.

**2. Master Data:** Master Data are the resources that doesn't change often and are maintained by Admin. Below list contain most commonly used API’s

\| **API** | **Method** | **Cached** | **Cached @ Portal** | | GET | Yes @ Proxy | No | | GET | Yes @ Proxy | No | | GET | Yes @ Proxy | No | | GET | Yes @ Proxy | No | | GET | Yes @ Proxy | No | | POST | Yes @ Proxy | No | | POST | No | No | | POST | No | No | | --- | --- | --- | --- |

| ---  |
| ---- |
| ---  |
| ---  |
| ---  |
| ---  |
| ---  |
| ---  |
| GET  |
| GET  |
| GET  |
| GET  |
| GET  |
| POST |
| POST |
| POST |

Most of the API are cached at Proxy server with a TTL of 1 Hour. This reduces load on server. But client still have to make request to get the data. These data should also be cached at client for some period of time. This can be achieved by using cache control headers. Proxy Server can be configured to send these header for all response.

**3. User State:** This are the API’s that help maintain user data across clients. Below table list user state API’s

\| **API** | **Method** | **Cached** | | GET | No | | GET | No | | POST | No | | GET | No | | POST | No | | GET | No | | GET | No | | --- | --- | --- |

| ---  |
| ---- |
| ---  |
| ---  |
| ---  |
| ---  |
| ---  |
| GET  |
| GET  |
| POST |
| GET  |
| POST |
| GET  |
| GET  |

These data can be updated from Portal or Mobile. There are many API’s that changes these data. We need to maintain these state consistent across mobile and portal.

**Solutions 1: Caching at client (Session, Local Storage)** Session or Local storage can be used cache these data in browser or mobile. With these we can avoid calling API’s every time.

Pros:

1. Easy to implement.
2. Less API’s calls.
3. Less load on the platform.

**Cons:**

1. **Inconsistency** : If user updates these data using one of the client other client will have stale data.
2. **Cache bursting** : When user update the data, Client needs to remove the data and update it with new data.
3. **Client side Logic** : Client needs to maintain mapping of API’s that changes state of User Data. When the new API’s introduced to update the state, Client should also update it’s logic of updating cache.

**Solution 2: Server Side caching** We can implement server side caching using Redis. Write back caching logic can be applied to invalidate cache.

Pros:

1. Server side Logic. Server will have control on cache and can update cache when data gets updated.
2. Consistant

**Cons:**

1. Increase network calls and Network overhead.
2. Hard to implement.
3. Increase load on server.

**Solution 3: Proxy caching with server cache bursting.** Proxy servers like Nginx has ability to retrieve cache from [memcached](http://nginx.org/en/docs/http/ngx\_http\_memcached\_module.html) or [redis](https://www.nginx.com/resources/wiki/modules/redis/). Proxy server will not involve in updation or populating the data. Server should implement the logic preloading the data to inmemory databases. When the data gets updated server can update the cache also either sync or async.

Pros:

1. Less load on servers.
2. Cache bursting logic handled by server.
3. Low network latency.
4. Consistency if implemented sync update.

**Cons**

1. Complex logic and hard to implement.
2. Cache eviction, pre-population and cache busting all should be handled by server.

**4. Content Data:** This contains all content related API’s. Below table list Content data API’s.

\| **API** | **Method** | **Cached** | | GET | No | | GET | No | | POST | No | | POST | No | | --- | --- | --- |

| ---  |
| ---- |
| ---  |
| ---  |
| GET  |
| GET  |
| POST |
| POST |

These data are huge. We need priority based caching logic. These need more thinking.

***

\[\[category.storage-team]] \[\[category.confluence]]
