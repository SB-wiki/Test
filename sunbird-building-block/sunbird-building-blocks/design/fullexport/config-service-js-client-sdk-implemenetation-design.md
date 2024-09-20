# Config-Service-JS-client-sdk---Implemenetation-design

**Existing Solution:**

The existing implementation of config service integrations in portal are available as helper methods as part of the portal code which is tightly bounded to portal module.So if we want to implement it for content service it requires rewriting the whole helper part which adds the complexity whenever changes are to be done.

**Proposed Solution:**

Inorder to fit all js modules we should make changes into the existing config builder/helper implementations and we should convert it into a generic js module which works with portal or content service as a npm package.

&#x20;                                                                                                                                                                ![](<../../../../Design/FullExport/images/storage/Untitled Diagram.png>)￼&#x20;

The architecture and flow of sdk has been illustrated in the above figure.Sdk basically contains 3 major components namely configbuilder,confighelper and source-adapters.

\*\*Source Adapters \*\*

Source adapeters conatins the js methods to fetch the configurations from specific config source.These methods will be executed by the config builder and configuration values will be returned as js object in the callback.

Below example shows the outline for config API source adapter js.

```js
function ConfigServiceSourceAdpater(httpOptions){
	return {
       readConfigs: function(keys,callback){
          // reading configs from api code goes here
       }
	}
}
```

**Config Builder**

Config builder frames/builds the configurations by invoking the exported methods of provided config source adapter instances.It also contains the cron scheduler method to refresh the config cache at particular intervals.

```js
function ConfigBuilder(options){
	return {
       buildConfigs: function(){
        // read configurations from the config sources iteratively based on order and stores them into config using config helper 'setConfig' method
       }
	}
}
```

**Config Helper**

This js component gets or adds the given configuration to cache using its methods.

```js
function ConfigHelper(){
return {
       setConfig : function(configKey,configData){
           // save the given config data into cache
       },
       getconfig: function(configKey){
        // read the value of given ket from cache and return it.
       }
	}
}
```

**Installation and Integration**

This Config-service-js-sdk will be published as npm and installed into portal node modules through `npm install` command.

Then Config builder should be instantiated with necassary option like below.

```js
const configBuilderOptions =   {
	sources: [
		new configSourceSdk.adapters.ConfigServiceSourceAdpater({
			url: "{{config-source-url}}"
		}),
		new configSourceSdk.adapters.EnvVarsSourceAdpater(envHelper)
	],
	keys: ["sunbird_explore_button_visibility", "...."],
	cacheRefresh: {
		enabled: true,
		interval: 10
	}
};


const configBuilder = new configSourceSdk.ConfigBuilder(configBuilderOptions);
configBuilder.buildConfig().then(function(status){
// handle status response here
})
```

***

\[\[category.storage-team]] \[\[category.confluence]]
