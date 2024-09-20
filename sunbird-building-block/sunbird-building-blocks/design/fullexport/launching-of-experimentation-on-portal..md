# Launching-of-Experimentation-on-Portal.

## Background:&#x20;

Currently, Sunbird has one portal instance that has all the modules and has multiple tenant support. If a tenant request any changes to an existing feature or a new feature, all tenants will get these changes as well.

## Problem statement:

Sunbird should support experimenting with the portal, which allows customers to load the different portal app/module with new features. This should follow the below principle

1. Experiment feature should be isolated from the main app.
2. Deployment of the experiment should not affect the main app.
3. Loading of the experiment app should be configurable and loading logic should reside in the server.
4. Determine experiment Id  and fetch experiment details before the app loads .
5. It should not have any impact on the load times for the users who are not part of an experiment.
6. All telemetry generated from the portal thereafter should contain the experiment id (in tags section)

## Prerequisites :-&#x20;

* APP\_INITIALIZER :- The "APP\_INITIALIZER" is an instance of InjectionToken in angular that  will be executed when an application is initialized. We will make use of it and perform our device register call and get the experiment details at this step.
* Currently device register call is done after the app is initialized.

## Loading Experiment specific app:

\*\*Solution :- \*\*

![](<../../../../Design/FullExport/images/storage/Untitled Diagram (1) (1) (1) (2).jpg>)

**Workflow for Anonymous users  : -**

1. Anonymous user opens the sunbird portal by entering the url .
2. before the portal loads in browser a middleware is called in portal backend that determines which app to load
   1. if expID is set in the express session load the experiment app
   2. else load the default portal app .
3. App\_initializer factory method is called before the angular bootstrap process.
   1. generate the Did and uaspec from browser.&#x20;
   2. makes an device register api call from portal backend (did and uaspec are passed as parameters)
   3. From portal backend make a device register call passing " **url and did"** as extra parameters to fetch the experiment details .
   4. If any experimentation details is present then
   5. check for experiment build in blob
   6. if exists set the **experiment id** in express session.
   7. return the api response.
   8. If no experimentation details present&#x20;
   9. return the api response.
   10. API response from device register is received
   11. if experimentation details present then
   12. check whether expId is set
   13. continue with the portal bootstrap process.
   14. if expId is not set&#x20;
   15. reload the app.
   16. process continues from step 2.
   17. if experimentation details not present then
   18. continue with the portal bootstrap process.

**Workflow for Logged in users  : -**

1. Anonymous user opens the sunbird portal by entering the url .
2. before the portal loads in browser a middleware is called in portal backend that determines which app to load
   1. if expID is set in the express session load the experiment app
   2. else load the default portal app .
3. App\_initializer factory method is called before the angular bootstrap process.
   1. generate the Did and uaspec from browser.&#x20;
   2. makes an device register api call from portal backend (did and uaspec are passed as parameters)
   3. From portal backend make a device register call passing " **url and did and uid"** as extra parameters to fetch the experiment details .
   4. If any experimentation details is present then
   5. check for experiment build in blob
   6. if exists set the **experiment id** in express session.
   7. return the api response.
   8. If no experimentation details present&#x20;
   9. return the api response.
   10. API response from device register is received
   11. if experimentation details present then
   12. check whether expId is set
   13. continue with the portal bootstrap process.
   14. if expId is not set&#x20;
   15. reload the app.
   16. process continues from step 2.
   17. if experimentation details not present then
   18. continue with the portal bootstrap process.

***

\[\[category.storage-team]] \[\[category.confluence]]
