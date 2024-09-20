# Keycloak-and-Kong-Analysis

#### Does Kong go to the DB for every jwt token validation&#x20;

No, One consumer can have multiple keys and it's going to DB only once per key and later use the values from cache.&#x20;

### Kong tables

#### Consumers table&#x20;

| id                                   | custom\_id | username | created\_at         |
| ------------------------------------ | ---------- | -------- | ------------------- |
| 4b189b85-a560-40f9-9935-6e2c297f5b71 |            | amol     | 2018-08-17 08:34:31 |

#### Jwt secrets table

| id                                   | consumer\_id                         | key                              | secret                           | created\_at         | algorithm | rsa\_public\_key |
| ------------------------------------ | ------------------------------------ | -------------------------------- | -------------------------------- | ------------------- | --------- | ---------------- |
| b135da3b-49cb-4832-9f6a-ba95783b9719 | 4b189b85-a560-40f9-9935-6e2c297f5b71 | 293deed37777447dbeb6fbb5b68c9b94 | 79935282fbad4ffc96517059bfa5bbb8 | 2018-08-17 08:50:22 | HS256     |                  |

#### Cached jwtauth\_credential\_key

| key                              | secret                           |
| -------------------------------- | -------------------------------- |
| 293deed37777447dbeb6fbb5b68c9b94 | 79935282fbad4ffc96517059bfa5bbb8 |

#### Cached consumer\_key

| key                              | consumer                             |
| -------------------------------- | ------------------------------------ |
| 293deed37777447dbeb6fbb5b68c9b94 | 4b189b85-a560-40f9-9935-6e2c297f5b71 |

Request authentication in kong

**JWT**

* Once the request reaches to JWT plugin, it reads jwt token sent with a request and decodes it to get the key.
* If the key is valid, then it gets secret mapped to key from the cache.
* If the key and secret mapping don't exist in the cache and it read it from DB and cache it for next use.&#x20;
* based on the secret it verifies the JWT signature and if it does then it Verify the JWT registered claims ( e.g expiry of the token)
* &#x20;Finally, it checks if the consumer available for the key in the cache.
* If the entry doesn't exist in the cache and it's read if from DB and cache it.&#x20;

#### Does Kong use a master key to create to the secret for every device (mobile device) so that it is able to just cache this master key and validate the tokens for each device

\-> No, Kong does not hold any master key but it's upon the API request that used to register and get the secret key for mobile device consumer. Kong creates a secret key against each unique key and sends it back to the requester. If the key is already registered then it just returns the secret key mapped to it.

curl -X POST \\

[https://dev.open-sunbird.org/api/api-manager/v1/consumer/mobile\_device\_openrap/credential/register](https://dev.open-sunbird.org/api/api-manager/v1/consumer/mobile\_device\_openrap/credential/register) \\

\-H 'Authorization: bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiI3Y2MzZDA2MDcyN2Q0Y2FmOTFmNTM4ODAzNjM4YzZmOSJ9.QVEpbyeV2AEXhNgA1xBIlxK75VGSN-w4eyEPiVZu64o' \\

\-H 'Content-Type: application/json' \\

\-d '{

"request": {

"key": "test-0.2.1"

}

}'

Response

{"id":"[ekstep.api.am](http://ekstep.api.am).adminutil.consumer.create","ver":"1.0","ets":1543319108287,"params":{"status":"successful","err":null,"errmsg":null,"msgid":"","resmsgid":"69ff1a9f-5216-4cd3-83bb-36b419593529"},"result":{"key":"test-0.2.1","secret":"5afdd8e574f144c2adba9923008394a4"\}}

#### How can we purge old records of rate limits from Kong

I think we can directly truncate table(`TRUNCATE TABLE ratelimiting_metrics`). We have already changed rate-limiting config policy to local for all the API's so truncating this table has no effect anywhere else.

#### Does keycloak go to the DB for every session validation

@Todo Need in-depth analysis- But I think no, Keycloak cache the users and sessions data locally on every node.

Ref

* [https://www.keycloak.org/docs/3.0/server\_development/topics/user-storage/cache.html](https://www.keycloak.org/docs/3.0/server\_development/topics/user-storage/cache.html)
* [https://www.keycloak.org/docs/3.0/server\_installation/topics/cache.html](https://www.keycloak.org/docs/3.0/server\_installation/topics/cache.html)

#### How can we purge keycloak sessions that have expired for DB housekeeping

* @Todo - need in-depth analysis for this but I think record from session table automatically getting purged after user/client logout.

#### Database growth rate - you can get the data from dev & prod from devops team to understand this

List of key tables in keycloak and kong and their current row counts

* Kong DB- [https://docs.google.com/spreadsheets/d/1mvk2L-uXlfxgJuFg\_VgSBaC7NPe3w8FPr67qZMZh6bw/edit#gid=1513347828](https://docs.google.com/spreadsheets/d/1mvk2L-uXlfxgJuFg\_VgSBaC7NPe3w8FPr67qZMZh6bw/edit#gid=1513347828)
* Keycloak DB- [https://docs.google.com/spreadsheets/d/1EsjGKAF1NXd34lAsWVbqpUg4JWv5QjEzXu0au94ePfU/edit#gid=193179170](https://docs.google.com/spreadsheets/d/1EsjGKAF1NXd34lAsWVbqpUg4JWv5QjEzXu0au94ePfU/edit#gid=193179170)

####

How do we enable time limits for jwt tokens to expire and how will the auth work in that scenario. Will Kong return 401 in that case? We can patch an existing jwt plugin: This adds verification for both nbf and exp claims:

curl -X PATCH http://kong:8001/plugins/{jwt plugin id} \\

\--data "config.claims\_to\_verify=exp,nbf"

| CLAIM NAME | VERIFICATION                                                                                  |
| ---------- | --------------------------------------------------------------------------------------------- |
| exp        | identifies the expiration time on or after which the JWT must not be accepted for processing. |
| nbf        | identifies the time before which the JWT must not be accepted for processing.                 |

MigrationsAfter adding this claim, old issued jwt token will not work and it will throw 403 error. We will need to re-issue the new jwt tokens.

### Kong cache

\*\*kong.cache is backed by kong.mlcache, which uses resty.lrucache for Lua VM cache and ngx.shared.DICT for shm cache. \*\*

**Tuning the kong\_cache size**

The Kong cache size can be tuned via the [mem\_cache\_size](https://docs.konghq.com/0.14.x/configuration/?&\_ga=2.243248898.1680938674.1543924337-1731030166.1539086089#mem\_cache\_size) configuration property. (See how the template injects it [here](https://github.com/Kong/kong/blob/0.13.0/kong/templates/nginx\_kong.lua#L32)).

**Can we assign unlimited memory to kong?**

The shared memory zones allocated by Nginx are not bounded by this limit, and we are free to assign very large areas of memory! More details on the ngx\_lua documentation for [lua\_shared\_dict](https://github.com/openresty/lua-nginx-module#lua\_shared\_dict).&#x20;

**Cache for rate limiting plugin**

As we are using the rate-liming to config policy as **local** and this plugin configured per consumer so it needs more cached memory.

**How to estimate the amount of cache memory needed?**

* There exist tools to monitor shared memory usage for OpenResty that we can leverage: [https://github.com/openresty/stapxx#ngx-lua-shdict-info](https://github.com/openresty/stapxx#ngx-lua-shdict-info).&#x20;

**Note:** As of now there is no inbuilt cache memory analysis tool available for  Kong open source/community.&#x20;

For the enterprise, there is bundled charts and information on cache size/ + hits/misses, for open source/community there is none provided by Kong or created by 3rd party community members.

Ref:  [https://discuss.konghq.com/t/how-to-do-cache-analysis/2409/2](https://discuss.konghq.com/t/how-to-do-cache-analysis/2409/2)

**What if cache memory full?**

When it fails to allocate memory for the current key-value item, then set will try removing existing items in the storage according to the Least-Recently Used (LRU) algorithm. Note that, LRU takes priority over expiration time here. If upto tens of existing items have been removed and the storage left is still insufficient (either due to the total capacity limit specified by lua\_shared\_dict or memory segmentation), then the err return value will be no memory and success will be false.

Conf file: local/share/lua/5.1/kong/templates/nginx\_kong.lua

lua\_shared\_dict kong 4m;

lua\_shared\_dict cache $\{{MEM\_CACHE\_SIZE\}};

**lua\_shared\_dict** - [https://github.com/openresty/lua-nginx-module#lua\_shared\_dict](https://github.com/openresty/lua-nginx-module#lua\_shared\_dict)

Ref: [https://github.com/openresty/lua-nginx-module#ngxshareddictset](https://github.com/openresty/lua-nginx-module#ngxshareddictset)

Ref- [https://discuss.konghq.com/t/how-to-tune-the-kong-cache-size-and-the-proxy-cache-size/1939](https://discuss.konghq.com/t/how-to-tune-the-kong-cache-size-and-the-proxy-cache-size/1939)

### The master key to sign different JWT tokens

→ Haven't found the way. @Todo

### Steps for Diksha consumer cleanup

* As of now, there are 10 consumers exist in Diksha Prod.
  * If we want then we can delete them by removing their entries from the Kong Diksha prod inventory
  * And after that run the Consumer onboard job

#### Does keycloak go to the DB for every session validation

→ No,  Keycloak cache using the cached data for this.

→ Ref

* [https://www.keycloak.org/docs/3.0/server\_development/topics/user-storage/cache.html](https://www.keycloak.org/docs/3.0/server\_development/topics/user-storage/cache.html)
* [https://www.keycloak.org/docs/3.0/server\_installation/topics/cache.html](https://www.keycloak.org/docs/3.0/server\_installation/topics/cache.html)

#### How can we purge keycloak sessions that have expired for DB housekeeping

→ Keycloak dose it owns. It stores only offline session data in DB and purges it when the session expires.&#x20;

→ Ref - [https://www.keycloak.org/docs/3.0/server\_installation/topics/cache/eviction.html](https://www.keycloak.org/docs/3.0/server\_installation/topics/cache/eviction.html)

***

\[\[category.storage-team]] \[\[category.confluence]]
