# \[Design-Discussion]--Sunbird-Ed-Angular-Migration-from-NG11-to-NG12

**Introduction**

**Background** Currently, **Sunbird-Ed** is in Angular version 11. Since Angular team is releasing multiple updated versions in a year, it is necessary to cope-up with the latest version and update the project since the support for the older versions of Angular will be stopped, no security updates and not maintained (Non LTS) by the Angular team.

Since Sunbird-Ed is following the Open-Source approach, it is necessary that the codebase should be upto date with the latest available version.

Currently [Angular 15](https://angular.io/guide/update-to-version-15) is the latest version of the Angular framework available.

Roadmap for Angular future releases - [Angular Roadmap](https://angular.io/guide/releases#actively-supported-versions)

![](<../../../../Others/SunbirdED/images/storage/Screenshot 2023-01-19 at 4.26.01 PM.png>)[Source](https://angular.io/guide/releases#actively-supported-versions) : \* _Angular version 2 to version 12 are no longer under support_

**Problem Statement** Sunbird-Ed should be updated from Angular 11 to Angular 12 version and all the peer dependencies needs to be updated to Angular 12 with [ivy compilation](https://v12.angular.io/guide/ivy) enabled as mandatory checklist task

**Key design problems**

* All the dependencies that are used must be [upgraded](https://v12.angular.io/guide/creating-libraries#ivy-libraries) to Angular 12
* Resolve the issues caused by ivy compilation and strict type checking
* Resolve the circular dependencies that exists in the application modules

**Design** Angular Upgrade Guide:[https://update.angular.io/?l=3\&v=11.0-12.0](https://update.angular.io/?l=3\&v=11.0-12.0)

Dependencies List:[https://docs.google.com/spreadsheets/d/1VJZ21MBFIiuwQjbVUwokVyBrEKJeXkYYJyWHHL19gIw/edit#gid=1364778090](https://docs.google.com/spreadsheets/d/1VJZ21MBFIiuwQjbVUwokVyBrEKJeXkYYJyWHHL19gIw/edit#gid=1364778090)

* **Approach 1**
  * Updated the portal to Angular 12 using official upgradation guide [https://update.angular.io/?l=3\&v=11.0-12.0](https://update.angular.io/?l=3\&v=11.0-12.0)
  * Used the available updated dependencies that are migrated to v12 in Dependencies List:[https://docs.google.com/spreadsheets/d/1VJZ21MBFIiuwQjbVUwokVyBrEKJeXkYYJyWHHL19gIw/edit#gid=1364778090](https://docs.google.com/spreadsheets/d/1VJZ21MBFIiuwQjbVUwokVyBrEKJeXkYYJyWHHL19gIw/edit#gid=1364778090)

**Result** : _We encountered many module errors and binding errors_

![](../../../../Others/SunbirdED/images/storage/WeLDi3ajqCk-2cnvrsh0dXjLz\_-\_GD2ZdkEG7\_cOvxRVKZpHqzWPT-T0FdK3a2\_1ap4m9mepeep4QmD7BgavltMqDGNF\_pk7ZGKPQqL0PnJw3fzU0z80CFN\_JYhjlo93PEzRKxI6a96G--WN9JQR2NTLwFGfvmiyNETGHksH37oP4tgfYyRaCYs9eDRWuA) ![](../../../../Others/SunbirdED/images/storage/ZaVEFns2vMnWLp3Y47zwoWfylVPvp0i1pbcFSfO6LZbwD0oUbGdXVaXuB18olucI54oG71rX9P9W4woVChcHCXRr3uirE5Zt1HzCOxTd0TpLOCSSWGNoigKNajOb-cEBr\_cFj3oVkMuQHtW2bodPppc6tiFx7Zyi4Qmno-t9rbLBOSOKi3pR337F3C3SWQ) ![](../../../../Others/SunbirdED/images/storage/4pRPBP9lxkosDvNjRCTHDK1AwbDVql8o8iQtmng5zj8lWXHaSOxZsikaCq048ArmjSmdznhZGOt0-\_OwBpQ2WURzBTmiPUez56gBT-Y2bT7dRcg4Wn9tZrxDjlY3BAHKI\_-0I8z1KrS2sw\_d-WOWM8Kc8bp8m8mED5ByClDTQKIT3bEQiRHAT5nK4c8BRw)

* **Approach 2**
  * Removed Alias paths that were present in tsconfig and added relative imports in whole codebase by manually changing imports in all files.
  * Added exports to all components,directives, services in root barrel file.
  * Updated some dependencies that were being used in repo to 12 like _ng2-sematic-ui,@project-sunbird/web-extensions._
  * Used alternatives to some dependencies that lost support long back
  * Eg:angular-inport->@stockopedia/angular-inport, slick-carousel->ngx-slick-carousel

**Result** : _Errors faced in phase 1 approach still persists_

* **Approach 3**
  * Made Ivy flag to true in Angular 11 version of portal to check if those errors were because of Ivy compilation
  * Portal client outdated dependencies were updated to available latest version
  * Resolved some errors and changed some absolute paths to relative paths for module imports
  * Used some alternate dependencies that were available in place of the the outdated dependencies
  * Eg:ng2-ace-editor->@derekbaker/ngx-ace-editor-wrapper

**Result** : _Compilation was successful but application was not loading as expected_

![](../../../../Others/SunbirdED/images/storage/image-20230120-051148.png)

![](../../../../Others/SunbirdED/images/storage/nGmRB7EmbS0CtdNC\_X\_dluFBnpzcUXtLRPXk4FxM6bsrVI6vUHY2maIVLHeJrjgtARhSs-PhWGzAmPKUxzZ-82DcNLW8a0UvGrDX7LODmOpZ1X4m1oO8oMuRSSa82MpuXlO7n4se3MohEPPRPiRFRicnSupBTKX5z6nc3yd45AoBPt7IbDSh3f8CxksR5Q) **Approach 4**

* Created a fresh Angular 12 project using Angular CLI to simulate actual behaviour
* Added base code of the portal like app component, shared module, core module etc one by one
* Used available updated dependencies
* Resolved some typescript errors that arouse due to strict type checking

Result:

![](../../../../Others/SunbirdED/images/storage/kq3riOgpKioGOHvcpiN-JMfYOjgc8DRJ5LL4OlvICzW6pdHn4-CtmhnDssZK3\_Dm091craJcDhLPcA-jIAHNfAy69j5RdeIytaUbL8yC0a0KichgrRQAiMp3Sj7hvVOTmxalWXc6RZT2A3n1BN0KxH4wcrsJWZ6AmCL4Nr5q3hlNjeizbL80DR0QZ6Gg3w)

**Reference links**

* Angular Upgrade Guide:[https://update.angular.io/?l=3\&v=11.0-12.0](https://update.angular.io/?l=3\&v=11.0-12.0)
* Dependencies List:[https://docs.google.com/spreadsheets/d/1VJZ21MBFIiuwQjbVUwokVyBrEKJeXkYYJyWHHL19gIw/edit#gid=1364778090](https://docs.google.com/spreadsheets/d/1VJZ21MBFIiuwQjbVUwokVyBrEKJeXkYYJyWHHL19gIw/edit#gid=1364778090)
* [Angular Ivy](https://v12.angular.io/guide/ivy)
* [Angular Roadmap](https://angular.io/guide/releases#actively-supported-versions)
* [Creating Ivy Libraries](https://v12.angular.io/guide/creating-libraries#ivy-libraries)

[**Discussion Thread For Angular 12 Migration**](https://github.com/orgs/Sunbird-Ed/discussions/333)

***

\[\[category.storage-team]] \[\[category.confluence]]
