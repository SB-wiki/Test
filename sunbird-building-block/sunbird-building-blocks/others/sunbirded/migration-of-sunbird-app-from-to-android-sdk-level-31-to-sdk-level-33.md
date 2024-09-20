# Discussion thread

[https://github.com/orgs/Sunbird-Ed/discussions/608](https://github.com/orgs/Sunbird-Ed/discussions/608)

Migration to SDK 33 requires migration for cordova-android which is detailed in the [Cordova documentation](https://cordova.apache.org/announcements/2023/05/22/cordova-android-12.0.0.html)

In Sunbird-mobile-app, the following files need to be changed

**Step-1**

[**build.sh**](https://github.com/Sunbird-Ed/SunbirdEd-mobile-app/blob/release-5.1.0.10/build.sh)

In this file, the Cordova version needs to be changed along with the Gradle version.

The Gradle version should be changed to 7.5.1 and the Cordova version should be changed to 12.0.0

![](<../../../../Others/SunbirdED/images/storage/Screenshot 2023-08-25 at 12.04.01 PM.png>) **Step-2**

[buildConfig/build.gradle](https://github.com/Sunbird-Ed/SunbirdEd-mobile-app/blob/release-5.1.0.10/buildConfig/build.gradle)

In build.gradle update build-tool version to 33.0.2 and defaultTargetSdkVersion, defaultCompileSdkVersion to 33

![](<../../../../Others/SunbirdED/images/storage/Screenshot 2023-08-25 at 2.46.28 PM.png>) **Step - 3**

Update the targetSdk version in config.xml

![](<../../../../Others/SunbirdED/images/storage/Screenshot 2023-08-25 at 3.04.14 PM.png>) **Step - 4**

As we are supporting API level 33, we have to support Android’s new SplashScreen API. For that, we have to make the following changes

* Remove all splash-related tags from config,xml.
* Add [colors.xml](https://github.com/Sunbird-Ed/SunbirdEd-mobile-app/blob/release-5.1.0.10/resources/android/colors.xml) and [themes.xml](https://github.com/Sunbird-Ed/SunbirdEd-mobile-app/blob/release-5.1.0.10/resources/android/themes.xml) in r[esources/android](https://github.com/Sunbird-Ed/SunbirdEd-mobile-app/tree/release-5.1.0.10/resources/android) folder.
* The above-mentioned 2 files should be copied to platforms/android/app/src/main/res/values folder and to achieve that we have to execute the script [fix-android-sdk33-migration.js](https://github.com/Sunbird-Ed/SunbirdEd-mobile-app/blob/release-5.1.0.10/scripts/android/fix-android-sdk33-migration.js) during build time so this script should be added in the Cordova build hooks.

![](<../../../../Others/SunbirdED/images/storage/Screenshot 2023-08-25 at 3.02.55 PM.png>)

* Convert drawable-ldpi-icon.png to [drawable-ldpi-icon.xml](https://github.com/Sunbird-Ed/SunbirdEd-mobile-app/blob/release-5.1.0.10/resources/android/icon/drawable-ldpi-icon.xml) as the new SplashScreen API supports svg.

***

\[\[category.storage-team]] \[\[category.confluence]]
