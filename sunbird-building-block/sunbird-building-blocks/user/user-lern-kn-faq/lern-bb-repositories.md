# Lern-BB-repositories

* 2 new repositories will be created -
  1. [github.com/Sunbird-Lern/data-products](https://github.com/Sunbird-Lern/data-products/)
  2. [github.com/Sunbird-Lern/data-pipeline](https://github.com/Sunbird-Lern/data-pipeline)
* No devops repo in Lern, continue to use sunbird-devops and sunbird-devops-private (For API, Env and ES Mappings, Jenkins and Kubernetes scripts)
* for Cassandra migration, sunbird-utils will be moved to Lern
* All the core microservices will be moved from **project-sunbird** and **Sunbird-Ed** to Lern

\|   | UserOrg Service | Batch Service | Notification Service | Groups Service | Discussion Forum | | **Core Microservices** |

1. sunbird-lms-service
2. sunbird-auth
3. sunbird-apimanager-util

|

1. sunbird-course-service
2. sunbird-viewer-service
3. certificate-registry
4. cert-service

|

1. sunbird-notification-UI
2. sunbird-notification-service

|

1. groups-service

|

1. discussions-UI
2. discussions-middleware
3. nodebb-plugin-sunbird-api
4. nodebb-plugin-sunbird-oidc
5. nodebb-plugin-azure-storage
6. nodebb-plugin-sunbird-telemetry
7. sunbird-nodebb

\| | **Data Products**   | **data-products repository** /adhocscripts(scala/python/java) /jobs(reports/etl)

1. Geo report (stateadmingeoreport)
2. User-consent report( stateadminreport)
3. User declaration report
4. user details report
5. course status updater
6. collection reconcilation
7. coursebatch status updater
8. progressexhaustjob
9. responseexhaust
10. userinfoexhaust
11. course consumption
12. course enrolment
13. collectionsummaryjobv2

\| | **Flink Jobs** -  | **data-pipeline repository**

1. Notification job
2. assessment aggregate updater
3. merge courses job
4. activity aggregate updater
5. certificate processor
6. collection-cert-pre-processor
7. collection-certificate-generator
8. relation cache updater
9. enrolment-reconciliation

|

### Jenkins Details

Jenkins jobs need to trigger for all LERN components.

| **Service**   | **Build**                                                                              | **Artifact upload**                                                                                        | **Deploy**                                                                                       |
| ------------- | -------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------ |
| DiscussionsMW | [DMW-Build](http://10.20.0.5:8080/job/Build/job/Core/job/DiscussionsMiddleware/)       | [DMW-Artifact](http://10.20.0.5:8080/job/ArtifactUpload/job/dev/job/Core/job/DiscussionsMW/)               | [DMW-Deploy](http://10.20.0.5:8080/job/Deploy/job/dev/job/Kubernetes/job/DiscussionsMW/)         |
| Nodebb        | [NBB-Build](http://10.20.0.5:8080/job/Build/job/Core/job/Nodebb/)                      | [NBB-Artifact](http://10.20.0.5:8080/job/ArtifactUpload/job/dev/job/Core/job/Nodebb/)                      | [NBB-Deploy](http://10.20.0.5:8080/job/Deploy/job/dev/job/Kubernetes/job/Nodebb/)                |
| DataProducts  | [DP-Build](http://10.20.0.5:8080/job/Build/job/DataPipeline/job/EdDataProducts/)       | [DP-Artifact](http://10.20.0.5:8080/job/ArtifactUpload/job/dev/job/DataPipeline/job/EdDataProducts/)       | [DP-Deploy](http://10.20.0.5:8080/job/Deploy/job/dev/job/DataPipeline/job/EdDataProducts/)       |
| DataPipeline  | [Pipeline-Build](http://10.20.0.5:8080/job/Build/job/KnowledgePlatform/job/FlinkJobs/) | [Pipeline-Artifact](http://10.20.0.5:8080/job/ArtifactUpload/job/dev/job/KnowledgePlatform/job/FlinkJobs/) | [Pipeline-Deploy](http://10.20.0.5:8080/job/Deploy/job/dev/job/KnowledgePlatform/job/FlinkJobs/) |

***

\[\[category.storage-team]] \[\[category.confluence]]
