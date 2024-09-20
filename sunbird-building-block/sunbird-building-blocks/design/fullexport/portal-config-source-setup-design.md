# Portal-config-source-setup---Design

**Story link : System JIRAkey,summary,type,created,updated,due,assignee,reporter,priority,status,resolution2207a759-5bc8-39c5-9cd2-aa9ccc1f65ddSB-8170**

**Existing Solution**

In the existing config service integrations of portal by default config service was set as primary config source by default and it will fallback to environment variables configuration in any of the following cases:

1. if the environment variable 'config\_service\_enabled' is set to true.
2. Incase config service return blank response for fetch request
3. If config service returns error.

**Proposed solution**

Instead of having config service as a default config source,there should be the provision available for the adopter to specify multiple config sources while fetching configs and the order of preference will be sequential.Then the config helper should read the configuration from the given source.

It involves the following steps:

1\. Config Builder which builds  the config from the given sources

2. Config Helper which stores and fetches configuration data.
3. Scheduler which refreshes the fetched configuration at specific intervals

**Implementation design**

While implementing multiple config sources we need to have  Service-adapter js module for all of those config sources.While adding a config source for config builder we need to provide the instance of that config source.

The service adapters for config sources should contain method which returns the requested value of config key after its read process.

```js
module.exports = {
 readConfig: function(key){
  /*
   * makes a http request to backend service and return the value
   */
 }
}
```

In above example the ServiceSource js has a method readConfig which returns the value of config key from API response.Similarly other source adapters like environment ,json also should contain the similar method.

Config builder should build the configuration from given sources and keys and returns it to config Helper.Then those configurations can be read through configHelpers cache.

```js
module.exports = {
 init: function(keys,configSources){
       
 }
}
```

***

\[\[category.storage-team]] \[\[category.confluence]]
