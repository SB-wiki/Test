# Sunbird-Portal----Resource-Bundle-Externalisation

### Introduction

* [Introduction](sunbird-portal-resource-bundle-externalisation.md#introduction)
* [Background](sunbird-portal-resource-bundle-externalisation.md#background)
* [Problem Statement](sunbird-portal-resource-bundle-externalisation.md#problem-statement)
* [Design](sunbird-portal-resource-bundle-externalisation.md#design)
  * [Solution 1](sunbird-portal-resource-bundle-externalisation.md#solution-1)
  * [Solution 2](sunbird-portal-resource-bundle-externalisation.md#solution-2)
* [References](sunbird-portal-resource-bundle-externalisation.md#references)
* [Links](sunbird-portal-resource-bundle-externalisation.md#links)

### Background

Currently, Sunbird has a high degree of interdependence with assets (platform specific) and language translation JSONs1 which are being served through filesystem. This tightly coupled modules approach make it difficult for

* Understanding the system / module
* Difficulty in maintaining the system
  * Changes in a tightly coupled module can have ripple effects throughout the system, making it mandatory for deployment of application
* Difficulty in modifying the system
* Difficulty in reusing the system
  * Tightly coupled modules can make it difficult to reuse the system, as modules are tightly bound to other modules / process
* Difficulty in scaling the system
  * Tightly coupled modules can make it difficult to scale the system, as the dependencies between modules can limit the ability to add new functionality or distribute the system across multiple adopters

### Problem Statement

As a adopter of Sunbird;

* System must be capable and independent using of serving assets and JSONs1
* Configurable BLOB storage2 using [Client Cloud Services](https://github.com/Sunbird-Ed/client-cloud-services)
  * _For additional configuration and key mapping please refer to_ [_https://github.com/Sunbird-Ed/client-cloud-services_](https://github.com/Sunbird-Ed/client-cloud-services)

### Design

#### Solution 1

![](<../../../../Design/FullExport/images/storage/Screenshot 2023-01-25 at 5.06.57 PM.png>)

* This approach will
  * Take configuration in the form of JSON object
  * Based on the jobs specified in configuration, jobs will be loaded with appropriate and required config params
  * Once the loader is completed with onboarding configuration, all the jobs are executed by executor
  * Uploading to BLOB will be based on configuration across _**multiple providers**_
  * Allows to extend / add custom jobs, so that additional automation are handled automatically based on configuration
* Impact
  * **Code reuse** :
  * By externalising a module, adopters can easily reuse the functionality in their projects, saving time and effort
  * **Maintenance** :
  * Externalising a module can make it easier to maintain the code, as it can be updated and tested independently of the main project
  * **Modularity** :
  * Externalising a module can improve the overall design of the project by making it more modular, which can make it easier to understand, test, and maintain
  * **Collaboration** :
  * Externalising a module allows developers (adopters) to collaborate more easily, as they can work on different parts of the codebase simultaneously without interfering with one another

Scenario 1 **Configuration**

```json
[
  {
    "tenant": "Tenant 1",
    "container": "tenant_1",
    "jobs": [
      {
        "name": "resourceBundles",
        "isEnabled": true,
        "cloudServiceProvider": "azure",
        "folders": [
          {
            "name": "consumption",
            "path": "/resourcebundles/data/consumption/",
            "dest": "/resourcebundles/json/",
            "blobName": "label",
            "uploadPath": "tenant_1/labels/consumption"
          },
          {
            "name": "creation',",
            "path": "/resourcebundles/data/creation/",
            "dest": "/resourcebundles/json/",
            "blobName": "label",
            "uploadPath": "tenant_1/labels/creation"
          }
        ]
      },
      {
        "name": "assets",
        "isEnabled": true,
        "cloudServiceProvider": "aws",
        "folders": [
          {
            "name": "logos",
            "path": "/logos",
            "blobName": "images",
            "uploadPath": "tenant_1/images"
          }
        ]
      }
    ]
  },
  {
    "tenant": "Tenant 2",
    "container": "tenant_2",
    "jobs": [
      {
        "name": "resourceBundles",
        "isEnabled": true,
        "cloudServiceProvider": "azure",
        "folders": [
          {
            "name": "consumption",
            "path": "/resourcebundles/data/consumption/",
            "dest": "/resourcebundles/json/",
            "blobName": "label",
            "uploadPath": "tenant_2/labels/consumption"
          },
          {
            "name": "creation',",
            "path": "/resourcebundles/data/creation/",
            "dest": "/resourcebundles/json/",
            "blobName": "label",
            "uploadPath": "tenant_2/labels/creation"
          }
        ]
      },
      {
        "name": "assets",
        "isEnabled": true,
        "cloudServiceProvider": "aws",
        "folders": [
          {
            "name": "logos",
            "path": "/logos",
            "blobName": "images",
            "uploadPath": "tenant_2/images"
          }
        ]
      }
    ]
  }
]] ]></ac:plain-text-body></ac:structured-macro><h5><strong>Folder Structure</strong></h5><ac:structured-macro ac:name="code" ac:schema-version="1" ac:macro-id="1202043f-8884-4ea6-9784-20a6b09bb0be"><ac:plain-text-body><![CDATA[.
├── ekstep
│   ├── assets
│   │   ├── contact.png
│   │   └── logo.png
│   └── resource-bundles
│       ├── data
│       │   ├── consumption
│       │   │   └── en.properties
│       │   └── creation
│       │       └── en.properties
│       └── json
├── jobs
│   ├── asset-parser
│   ├── blob-uploader
│   └── resource-bundle-parser
── sunbird
│   ├── assets
│   │   ├── contact.png
│   │   └── logo.png
│   └── resource-bundles
│       ├── data
│       │   ├── consumption
│       │   │   └── en.properties
│       │   └── creation
│       │       └── en.properties
│       └── json
├── .env
└── configuration.json
```

#### Solution 2

![](<../../../../Design/FullExport/images/storage/Screenshot 2023-01-19 at 4.56.35 PM.png>)

* This approach will
  * Requires manual intervention and processing of all the properties files to JSON conversion
  * Uploading directly to BLOB storage requires special access
  * Maintaining assets is overhead
  * Managing multiple BLOBs required special attention and care

### References

1 Resource bundles properties and JSON files

2[BLOB storage provider](https://github.com/Sunbird-Ed/client-cloud-services)

### Links

* \[\[Sunbird Portal :: CSP implementation|Sunbird-Portal----CSP-implementation]]

***

\[\[category.storage-team]] \[\[category.confluence]]
