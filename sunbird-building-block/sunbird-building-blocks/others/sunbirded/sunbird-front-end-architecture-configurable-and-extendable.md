# Sunbird-front-end-architecture---configurable-&-extendable

### Introduction:

This document talks about ease of adoption & contribution of front-end application.

### Background:

Present Sunbird adoption of front-end(portal/app) application configuration is manual driven. It is very difficult for the adopter to configure specific features as per his requirement & passing the required configuration for the application.

The intent of the document is for ease of adoption of front-end application.

### Problem Statement:

Today problems:

* To contribute to any specific feature entire portal has to setup with all the configurations properly.
* The features can’t deploy & verify independently. All the features has to be package & deployed as part of portal.
* Any change in code is executing all the unit test cases as part of CircleCI which is taking more time.
* Any specific component is having any compilation issues entire portal is blocked for testing.
* Software update should make sure all the component/modules also should be upgraded to the same version to build & deploy the portal.
* Huge list of configuration variables difficult to configure & maintain.
* Any dependent module/library is not supported, then entire portal is blocked.
* Large localisation files for

### Key design problems:

1. Configurable: Features/components should be configurable while building the portal(Adoption/Customisation).
2. Extendable: Ease of extension of specific feature or component
3. Templetization: Ease of configuring the different template/layout/theme for the components
4. Packaging: Ease of packaging of components to build portal(Adoption & Customisation)

### Design:

[Draw.io](http://draw.io) : [https://drive.google.com/file/d/1gofpbetuIsmLYjLWCm2C37wpH-nLOx7a/view?usp=share\_link](https://drive.google.com/file/d/1gofpbetuIsmLYjLWCm2C37wpH-nLOx7a/view?usp=share\_link)

[https://drive.google.com/file/d/1okc74n6mNqM97DSQ3KRLwhWBprn6auFS/view?usp=share\_link](https://drive.google.com/file/d/1okc74n6mNqM97DSQ3KRLwhWBprn6auFS/view?usp=share\_link)

![](<../../../../Others/SunbirdED/images/storage/micro frontend-Page-1.drawio.png>)

### Angular Front-end microservices:

In the single Angular project we can create the sub-projects based on feature/pages. This projects separation should able to work independently without any dependency on other projects.

**Sample application:**

[https://github.com/vinukumar-vs/ng-module-federation/tree/main/Module%20federation/mdmf-sample1/mdmf-starter](https://github.com/vinukumar-vs/ng-module-federation/tree/main/Module%20federation/mdmf-sample1/mdmf-starter)

Design diagram:![](<../../../../Others/SunbirdED/images/storage/Screenshot 2023-02-08 at 11.39.33 AM.png>)![](<../../../../Others/SunbirdED/images/storage/Screenshot 2023-04-25 at 3.19.31 PM.png>)

**Pros:**

* Each project can be run & deployed independently.
  * Ease of Adoption/Contribute: Adopter can setup the project specific to the requirement & test it independently.
  * The changes can to pushed to specific project & unit tests execution will be faster.
* Minimal list of environment variables specific to individual project.
  * ease of Adoption: can set-up specific project environment variables

**Cons:**

* All the projects dependencies has to be updated in the single root application package.json file only.
* Even though projects are separated, we have close the entire github repo to work on specific project.
* Versioning of projects should be handled manually, as individual projects can be deployed independently.
* Each project should be launched as individual hosts, hence the header & footer of the home project should be maintained across all the projects. (additional overhead)
* Sharing of data between projects only allowed through local-cache or passing through URL’s.(recommented)

### Frontend microservices as framework agnostic:

All front-end modules are published as pure NPM modules as framework agnostic(Pure HTML/JS/Typescript libraries). So any dependent application will load these libraries as NPM modules irrespective of tech stack being used by the parent application

Using Module Federation:[https://webpack.js.org/concepts/module-federation/](https://webpack.js.org/concepts/module-federation/)

**Pros:**

* One line statement of advantage with this solution.

**Cons:**

* One line statement of disadvantage with this solution.

### Reference links:

* [https://www.angulararchitects.io/en/aktuelles/the-microfrontend-revolution-part-2-module-federation-with-angular/](https://www.angulararchitects.io/en/aktuelles/the-microfrontend-revolution-part-2-module-federation-with-angular/)
*

***

\[\[category.storage-team]] \[\[category.confluence]]
