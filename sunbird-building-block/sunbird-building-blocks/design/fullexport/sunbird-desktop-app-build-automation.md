# Sunbird-desktop-app-build-automation

```
* [Windows](#windows)
* [Linux ](#linux )
```

**Background** To build the desktop app to supported operating systems in the supported format in 32bit and 64bit  we need  Windows 32bit and 64bit systems with build setup which includes softwares

Node js, Editor and Git and same need to be installed in Linux to build for it and it is a manual process and requires manual distribution of the app which

is error-prone.

**Introduction** The wiki details the automated build process to distribute the desktop application to the users who use the different operating systems and this process will provide the app in different formats for different operating which are mentioned below&#x20;

| Operating system | Format | 64bit | 32bit |
| ---------------- | ------ | ----- | ----- |
| Windows          | .exe   | yes   | yes   |
| Ubuntu           | .deb   | yes   | NA    |
| CentOS/Redhat    | .rpm   | yes   | NA    |
| Mac              | .dmg   | yes   | NA    |

**Distribution Formats and arches**

#### Windows

For windows build we need to 32bit and 64bit app since we are using pouch DB as database which is having native node modules are dependencies we need to rebuild the native dependencies per OS and arch and we don't have cloud provider who provides 32bit windows machine still the automation is pending for the 32bit build.

#### Linux&#x20;

Initially, we planned to go with **appImage**  format which doesn't need installation but since it doesn't support features like

1\. opening content from file browser which will be the most use case from user to play the content

2. User may think **appImage** as an installed app from Pendrive if it is there or he can easily delete the app unlike an installed app
3. Logo of the app is not shown so it looks like a software instead of desktop application

we went will **deb** and **rpm**  format with which can be installed as other apps and also provides features like open content or any other files associated with the app.

**Design**

**Build process steps**

1. &#x20;The Jenkins job will clone the repos mentioned in the above diagram to the build server
2. &#x20;It reads the configuration for the build which includes below variables
   1. **GITHUD\_PRIVATE\_REPO** // Example: PROJECT\_SUNBIRD/PRIVATE\_ASSETS
   2. **TARGET\_ENVIRONMENT** // Example: staging, pre-prod, prod
   3. **GITHUB\_PRIVATE\_REPO\_ACCESS\_TOKEN** &#x20;
3. It installs the dependencies which are in the form of node modules for the app
4. The app triggers angular build script to build the UI which includes the desktop app modules as a dependency
5. The script will update the package.json and env.json and updates the assets
6. Electron builder will build the app based on the configuration provided to it&#x20;

**Limitations**

Since we have the native node module(pouch DB) dependency we need to build the app for 32bit and 64bit systems we need to build the app  separately&#x20;

***

\[\[category.storage-team]] \[\[category.confluence]]
