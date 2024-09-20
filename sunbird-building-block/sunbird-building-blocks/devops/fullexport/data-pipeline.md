

falseLog in to the Jenkins and do the following


## Build

* Switch to Build folder and run all jobs. Provide the tag as  **release-1.14.0**  in the build job parameter  **github_release_tag** 


## Provision

* Switch to Provision/<env>/DataPipeline and run all jobs
    1. AnalyticsApi
    1. AnalyticsSecor
    1. AnalyticsSpark
    1. Influxdb
    1. Kibana
    1. Postgress
    1. Yarn

    

Deploy
* Switch to Deploy/dev/DataPipeline and run all jobs in following order
    1. CassandraDbUpdate
    1. KafkaSetup
    1. AnalyticsApi
    1. DataProducts
    1. Secor
    1. KafkaIndexer
    1. SamzaTelemertySchemas
    1. Yarn

    



*****

[[category.storage-team]] 
[[category.confluence]] 
