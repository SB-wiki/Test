# Life-of-a-Plugin

Sunbird provides an extensible core – this allows new functionality to be built independently of the core development as a plugin. The plugin can be installed into Sunbird and run as part of the core application.&#x20;

This document covers the life of a plugin from its conception to it's ultimate demise (i.e. uninstallation).&#x20;

**Idea** When the idea of a plugin is conceived it is related to a specific task which is to be accomplished. The reason for someone thinking of creating a plugin is that this task cannot be accomplished using the core parts of Sunbird. The need to accomplish the same task (or a minor variant) may not be unique to the person or group who thinks up the plugin.

Thus **a repository of plugins with screenshots, descriptions and license terms**  can be instrumental in making plugins re-useable and discoverable by the community.

Providing a **template for adding screenshots and descriptions** will standardise the method in which templates are published

Providing a **means for rating and giving feedback** on plugins will create sense of security and confidence when installing the plugin.

Collectively, this can form the foundation of an app store for Sunbird plugins. (see [Envato marketplace for WordPress plugins](https://elements.envato.com/wordpress/plugins))

**Implementation Design** To design the implementation of a plugin, the plugin author will need access to a **specification of extension points** , one or more **examples demonstrating the scope of extensibility** and a **specification of Sunbird core APIs available** for creating a plugin

**UI Design (web/mobile)** When designing the UI for a potential plugin which has web/mobile views the plugin author can be faced by a few different scenarios

1. Adding elements to an existing UI view
2. Creating a new UI view
3. Providing an alternate implementation of an existing UI view

Adding elementsTo add elements to an existing view,

1. a **declarative language and format is needed** which can allow a plugin to declare elements for existing pages
2. to accomplish this the framework should provide **a vocabulary of pages which can be extended**
3. To simplify initial scope, there can be a fixed **vocabulary of view sections (like header, footer, menu, navbar, search filters and others) where new elements can be added**
4. The implementation may be interrogative where the framework interrogates the plugin for elements or could be registration based where the plugin registers elements with the framework. The latter provides easier debuggability

New views

1. Creating new views depends on adding elements to existing views to create navigation entry point for the new view
2. Creating a new view will also require **the ability to add common elements and behaviours** from other parts of the web app or the mobile app

Alternate implementationsTo provide an alternate implementation of a view,

1. the declarative language and format which allows a plugin to provide elements for existing pages can be extended for a plugin to provide implementations for pages
2. to accomplish this the framework should publish **a vocabulary of pages which can be replaced**

**UI Consistency**

1. to ensure that the plugin UI is consistent with the rest of the application, the framework will need to **publish styles which can be applied inside the plugin** UI
2. the framework will also need to **inject additional assets (CSS/JS/media) created by the plugin into views** where the plugin is loaded

**Implementation (Code)** To provide backwards compatibility with framework upgrades, the framework must **provide SDKs which exposes basic services used by the plugin** . The SDK implementations will provide interface compatibility with framework. Separate SDKs may be required for Web, Server and Mobile plugins

Server SDKAPI Management

* Declare an API
* Declare permissions for an API
* Provision an API into the gateway

Storage Management

* Create a new table
* Store data into a table
* Index stored data into a secondary index
* Retrieve data by PK
* Retrieve data by SK
* Search for data
* Delete data in the table
* Upgrade schema
* Delete tables

Sunbird

* Access Sunbird services
  * Authentication: to get data for the current logged in user and session
  * Logging: to add log records for debugging
  * Telemetry

Others

* Secrets: to register/retrieve/delete secrets which can be retrieved at runtime (eg: an API key for a 3rd party service)
* HTTP: to make 3rd party API calls
* Queue: Enqueue an asynchronous task, schedule a task for later

Web SDK

* HTTP service
* Auth service
* Token service: to get a token to call a sunbird backend API
* Secrets service
* EventBus Service: to dispatch and listen for events and allow for inter-plugin communication

Mobile SDKPermissions

* Request for permission
* Check for permission

**Testing** The framework will provide the basic testing env required by any plugin to test the Integration of the plugin with the framework

\*\*    Local testing\*\* The plugin developer must be able to test the plugin locally without the need for a slow compile, package, deploy cycle. The **plugin framework must support injecting a local plugin into a running application** for fast iteration&#x20;

\*\*    Unit testing\*\* The plugin developer will list out all the possible use cases and will write unit test cases to fulfil the use cases

&#x20;    **Integration testing** The plugin will list all the touch-points where the plugin can affect the application and any service it is using from the framework and will write the automated test for each of the use case.

The plugin will use the framework exposed system to do automated integration testing.

**Debugging** Debugging will be a strong need of any plugin development. The framework should ensure that loaded **plugins can have debuggers attached** within the plugin. This means that the plugin code must be reference-able from the standard debugger.

Each plugin should use an effe74ctive logging system which will provide all the logs in a central place. To accomplish this, the **framework will expose logging mechanism** that each plugin can extend and use to log. This will help in debugging process.

**Publishing** A standard **process to build and publish the plugin will be exposed** by the framework so that all plugin will follow the same process. The publishing process must allow for a **plugin to create its own dependencies** .

**Versioning** Plugins will be versioned to help in keeping the history of the plugin and helps collaboration between plugin developers.

#### Installation

The framework must provide a means for plugin to be installed into the application.

Web pluginsWeb plugins will be installed at build-time by incorporating the plugin source code into the portal source tree and rebuilding the portal client application. The installation will require updating the root app.js code to import the appropriate plugin modules into the root of the application.

Server pluginsServer plugins can be installed as NPM modules or by incorporating the plugin source code into the backend application source tree and rebuilding the portal server application

**Mobile plugins**

Mobile will be installed at run-time by the mobile app downloading the the plugin source code from the backend into the mobile app as a hot-code deployment.

#### Activation/Loading

#### Runtime: UI based plugin (web/mobile)

**Data access from UI** During this phase, the plugin uses the basic services provided by the UI framework to load data from one or more backend APIs

**JS decorate the DOM** Once the data is available from the service to the plugin, plugin JS will use this data to decorate the DOM and will use two-way data binding.

**User interaction with views** Once the DOM is created and updated with data now it will wait for user interaction or any event that is listened by the plugin.

**Respond to interaction or event**

1. The framework will provide event handling and broadcasting mechanism that a plugin can use to call other plugins or to broadcast its event. The plugin must register to these events and handle accordingly
2. The plugin can also emit events so that any dependant plugin can do a callback on that

**Data Update from UI** Once the user interaction is handled and all the data processing is done, the data needs to be persisted. The plugin calls one or more services to do this process.

**Runtime: Server Plugins** **Runtime: Mobile Plugins** **Deactivation/Unloading** **Upgrade** If the extensibility framework is updated then it should be backwards compatible to ensure plugins are not broken. There will be a times where the framework upgrade is backwards incompatible. In these situations, an alert has to be sent to the plugin contributor so that the developer can plan for a plugin upgrade. The framework upgrade should provide for a deprecation period where a framework API is deprecated giving plugin authors time to upgrade their plugins.

**Upgrade-Alert** If a plugin upgrade is available, an alert should be dispatched to all instances of Sunbird where the plugin is installed. The plugin author can share release features and any bug fixes so that the integrator can take a call to upgrade the plugin or not.

**Uninstallation** The framework will expose hooks so that the plugin can be uninstalled at any time by calling the methods. Each plugin must also should provide a process to uninstall itself and clean up schema and data which has been created during installation.

***

\[\[category.storage-team]] \[\[category.confluence]]
