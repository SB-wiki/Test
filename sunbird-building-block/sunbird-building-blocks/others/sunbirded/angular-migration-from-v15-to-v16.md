

 **Migration Steps** Before migrating to Angular 16, ensure that the Node.js version is V16 or V18. Additionally, the TypeScript version should be >= 4.9.3.

 **Updating ED Related Libraries** 

Update the Sunbird Mobile app related libraries to be compatible with Angular version 15. Below is the list of libraries owned by ED that require updating:


1. @project-sunbird/common-form-elements


1. @project-sunbird/client-services


1. @project-sunbird/discussions-ui


1. @project-sunbird/sb-dashlet


1. @project-sunbird/sb-svg2pdf


1. @project-sunbird/sunbird-sdk



 **Update Angular CLI/Core** 

Ensure angular core and cli are updated to v16. The repository should be clean before updating Angular.


```
ng update @angular/core@16 @angular/cli@16
```
Now, SunbirdEd-libraries are available for Angular 16. Update the below libraries' versions in your mobile package.json after updating Angular to V16:


```
"@project-sunbird/common-form-elements": "8.0.4", 
"@project-sunbird/client-services": "7.0.6", 
"@project-sunbird/discussions-ui": "8.0.3", 
"@project-sunbird/sb-dashlet": "8.0.1", 
"@project-sunbird/sb-svg2pdf": "8.0.3", 
"@project-sunbird/sunbird-sdk": "7.0.23"
```


 **Important Points** 


* Update Angular CDK to npm i @angular/cdk@16


* Ensure "zone.js" is 0.13.x or later.



Other libraries to update:


```
"@ionic/storage": "4.0.0", 
"@ionic/storage-angular": "^4.0.0", 
"@ngx-translate/core": "14.0.0", 
"@ngx-translate/http-loader": "6.0.0", 
"chart.js": "4.1.1", 
"chartjs-plugin-datalabels": "2.2.0", 
"chartjs-plugin-stacked100": "1.5.0", 
"jest-preset-angular": "13.1.4", 
"jspdf": "^2.5.1", 
"lodash-es": "^4.17.21", 
"ng-recaptcha": "12.0.2", 
"ng2-charts": "5.0.4", 
"ngx-bootstrap": "11.0.2", 
"ts-jest": "29.1.2"
```


 **ng2-charts Changes** 

Since some types are inherited from Chart.js v3, there are some breaking changes. Labels are now just a string\[]. Make adequate changes in bar-chart.component.ts, graph-circle.component.ts, percentage-column-charts.component.ts, pie-chart.component.ts.

ML related features also needs to be tested by the respective team since it has some changes.

 **Import Changes** 

In the shared-module.ts, change the import chartsModule to NgChartsModule.

ReferencesJira Ticket: [ED-3951 System Jira](https:///browse/ED-3951)

Angular migration guide: [https://update.angular.io/?v=15.0-16.0](https://update.angular.io/?v=15.0-16.0)



*****

[[category.storage-team]] 
[[category.confluence]] 
