
## Introduction:
This document will help how to build the app and which file is required to build the app. Adopter can easily change the app name, logo, app icon etc.


* [Background](https://project-sunbird.atlassian.net/wiki/spaces/SUN/pages/3351412743/Build+factory+for+Sunbird+Mobile+App#Background%3A)


* [Problem Statement](https://project-sunbird.atlassian.net/wiki/spaces/SUN/pages/3351412743/Build+factory+for+Sunbird+Mobile+App#Problem-Statement%3A)


* [Key Design Problems](https://project-sunbird.atlassian.net/wiki/spaces/SUN/pages/3351412743/Build+factory+for+Sunbird+Mobile+App#Key-Design-Problems%3A)


* [Design](https://project-sunbird.atlassian.net/wiki/spaces/SUN/pages/3351412743/Build+factory+for+Sunbird+Mobile+App#Design%3A)




## Background:
Currently Sunbird Mobile App has two git repository for create the build in Jenkins. The main repository is public [Sunbird-Ed/SunbirdEd-mobile-app.git](https://github.com/Sunbird-Ed/SunbirdEd-mobile-app) another repository is private to use for change the app name, logo etc. It’s copy the logos, name, launcher etc from private repository and add in main repository at the build time. It’s difficult to use and understand by any adopter,  

So we want to use only main repository to build the app.


## Problem Statement:

* How can check bellow config files are available or not in public repository before the build time?                     1. build-extras.gradle(only for Android builds)                                                                                                                                    2. config.json                                                                                                                                                                                                                        3. local_notification_config.json                                                                                                                                                                                                              4. whitelabel.xml                                                                                                                                                                                                                                                                                                                                                   5. google-services.json                                                                                                                                                                  6.  i18n                                                                                                                                                                                                                7.  local_cache_download_config.json                                                                                                                                                    8.  ic_launcher.png                                                                                                                                                                                               9.  splash                                                                                                                                                                                                                      10.build.json                                                                                                                                                                                                              11. sunbird.properties                                                                                                                                                                                                                                                                                                                                               12.  sample.jks                                                                                                                                                            


* What should be the error message  if file is not available?




## Key Design Problems:

* Configurable




## Design: 
To eliminate all these problems, Write a script to check  the required config files are available or not in the sunbird mobile repository. If file is not there then it will be throwing error with proper message. 

The configurations are as follows



| S No | Config | Description | 
|  --- |  --- |  --- | 
| 1 | build-extras.gradle(only for Android builds) | Gradle file required to build android app | 
| 2 | config<ul><li>config.json

</li><li>local_notification_config.json

</li><li>whitelabel.xml

</li></ul> | <ul><li>config.json - Contains all onboarding/tab config

</li><li>local_notification_config.json - Contains notification confi

</li><li>whitelabel.xml - Contains splash config

</li></ul> | 
| 3 | google-services.json | Google firebase configuraion | 
| 4 | i18n | Localization assets | 
| 5 | local_cache_download_config.json | config to download bundles for offline support in app | 
| 6 | resources<ul><li>ic_launcher.png

</li><li>splash (drawable-hdpi-splash.png, drawable-ldpi-splash.png, drawable-xhdpi-splash.png)

</li></ul> | <ul><li>ic_launcher.png - App icon

</li><li>splash - Splash icons

</li></ul> | 
| 7 | signingConfig<ul><li>build.json

</li><li>sample.jks

</li></ul> | <ul><li>build.json - certificate config

</li><li>sample.jks - sample certificate

</li></ul> | 
| 8 | sunbird.properties | Contains all the properties reuired to configure sunbird app. | 


* All these configurations should be available to the public GitHub.





*****

[[category.storage-team]] 
[[category.confluence]] 
