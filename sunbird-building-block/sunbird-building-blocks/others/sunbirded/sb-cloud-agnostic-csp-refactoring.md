# SB-Cloud-Agnostic---CSP-refactoring

### Introduction:

This document helps to how to make SB as cloud agnostic by refactoring the existing CSP specific switch/if condition in micro-services and applications.

### Background:

As part of cloud agnostic changes in SB, all the micro-services & applications are started using common cloud-sdk(different for frontend & backed services).

As part of cloud-sdk, SB was implemented for Azure, AWS & GCP. OCI team has contributed the changes for cloud-sdk of SB for one of the adopter. While reviewing the OCI PR’s, we have noticed multiple PR’s for many micro-services rather than just cloud-sdk changes.

This indicates, new CSP required changes in the code as well. Which is not cloud-agnostic. Hence we started reviewing the individual micro-services & applications code & refactoring these changes.

Each BB has documented how to onboard new CSP.

**References:**

Lern:

\[\[On Boarding New CSP|On-Boarding-New-CSP]]

Knowlg:

\[\[Knowlg - Add New CSP Storage - Implementation Changes & Testing|Knowlg---Add-New-CSP-Storage---Implementation-Changes-&-Testing]]

### Problem Statement:

* Is SB platform will work just by implementing the new CSP provider changes in cloud-sdk?
* Can any adopter configure the cloud-sdk of specific CSP by using the SB build tags?

### Key design problems:

* How to implement new CSP into cloud-sdk ?
* How to configure the CSP while build/deployment time by an adopter?
* How to define common environment variables for any CSP?

![](<../../../../Others/SunbirdED/images/storage/Screenshot 2023-07-10 at 1.32.41 PM-20230710-080247.png>)

### Design:

#### How to implement new CSP into cloud-sdk ?

At present(on Jun 2023) we have single repo of client-cloud-sdk

![](<../../../../Others/SunbirdED/images/storage/Screenshot 2023-07-10 at 1.29.28 PM-20230710-075942.png>)

### Solution 1:

Build cloud specific service(sb-cloud-service) & deploy. All the applications or microservices will use this cloud specific service API’s to do any actions specific to CSP.

sb-cloud-service will expose all the required API’s as generic which are required SB applications & micro-services. So that none of the other application should be really no need to know who is the CSP. This CSP specific configuration will be given to sb-cloud-service.

![](<../../../../Others/SunbirdED/images/storage/Screenshot 2023-07-12 at 10.54.30 AM.png>)

**Pros:**

* **Single Implementation for all tech stack:** As it is a separate service & deployed independently which is API driven, any application or micro-service(any tech) can communicate with API’s for CSP changes.
* **Avoids cloud specific code:** All the applications and micro-services except the sb-cloud-service are completely not aware of the CSP. Hence none of the service can write cloud specific logic in the code.
* **Avoids CSP configuration of multiple services:** All the services configurations specific to CSP can be removed & also it helps to make sure CSP is common for all.
* **Easy to deploy & push changes:** As this is api driven, any changes in the sb-cloud-service doesn’t require any deployment or changes in the micro-services(until if the service want to integrate).
* SB specific logic dependent on CSP also can be added to the individual sb-cloud-service(aws, gcp etc)
* **Reduce testing efforts:** The sb-cloud-service testing will confirm all the CSP integrations will work. Which will avoid the testing of all the micro-services testing.

**Cons:**

* **Multi cloud support:** Because all the micro-services are cloud agnostic, it will be difficult to configure multiple cloud support if required for specific workflow or few micro-services
* As all the micro-services are cloud-agnostic, so we can’t leverage the cloud-specific features.

### Solution 2:

Removing the multiple cloud specific SDK’s & use the single cloud-sdk for all applications & microservices.

Font-end application/service(nodeJS) will call the existing API’s for any cloud-specific actions rather than having cloud-sdk for front-end separately.

![](<../../../../Others/SunbirdED/images/storage/Screenshot 2023-07-12 at 3.05.58 PM-20230712-093603.png>) **Pros:**

* No configuration or logic specific to front-end application/service(nodeJS). All the front-end uses API driven which was exposed by the respective micro-services
* **No overhead of multiple cloud-sdk’s:** No need to maintain/write multiple cloud-sdk’s. One for javascript & one for java services.

**Cons:**

* None of the services(nodeJS) can implement CSP logics. It can only leverage the existing micro-service API’s

### Solution 3:

Using common sb-cloud-sdk and all the CSP implementations should be part of this single sb-cloud-sdk(similar to [jClouds](https://github.com/apache/jclouds/tree/master/providers)). All the services will implement the same library(using NPM/maven).

All the implementations should be written in the same SDK & the consumer will give the configuration which CSP should be initialised.

![](<../../../../Others/SunbirdED/images/storage/Screenshot 2023-07-12 at 1.34.15 PM-20230712-080424.png>)

**Pros:**

* **All in one:** As the single library have all the implementations, it is easy to discovery & integrate.
* **Consistant** : All the implementation will be same & consistant.
* **Multi-Cloud support:** As each micro-service is configured with CSP properties, they have have different CSP integration as per their need.

**Cons:**

* **Overhead to contribute:** Any change in the interface, all the implementations should be added with the change. Which is very difficult to single contributor to verify the change works for all CSP’s.
* **Version upgrade required all the micro-services change:** Any change/update of the version should require all the sb micro-services to take the new version to make is consistant across SB platform.
* **Duplicate effort:** As a contributor for new CSP has to write the library in Javascript & Java. For single CSP provider, adopter has to write & test both the libraries. Also maintenance orverhead of common logic change required both the place change & verifying.
* **Security and Maintaining CSP properties:** As all the micro-service which are implementing the cloud-sdk they should be having configuration of CSP specific environment variables. Each micro-services should be know the required CSP properties to test. Which will lead into security issue.
* **Code standard & testing effort:** As CSP specific properties has configured for the required micro-services, team can write the logics specific to CSP. Which leads into different implementation or logic by each-service before calling the cloud-sdk. Which intern has to be tested with multiple clous-sdks to verify for all the micro-servies.

### Reference links:

*
*

***

\[\[category.storage-team]] \[\[category.confluence]]
