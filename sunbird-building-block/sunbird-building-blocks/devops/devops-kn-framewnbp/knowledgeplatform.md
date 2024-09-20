

falseLog in to the Jenkins and do the following


## Build

* Switch to Build folder and run all jobs


## Provision

* Switch to Provision/<env>/KnowledgePlatform and run jobs in following order
    1. Cassandra
    1. CompositeSearch
    1. Neo4j
    1. Zookeeper
    1. Kafka
    1. Learning
    1. Redis
    1. Search

    

Deploy
* Switch to Deploy/dev/KnowledgePlatform and run all jobs in the following order
    1. CassandraDbUpdate
    1. Neo4j
    1. StartNeo4jCluster
    1. Learning
    1. Search
    1. Neo4jDefinitionUpdate
    1. Neo4jElasticSearchSyncTool
    1. KafkaSetup
    1. Yarn

    

    



*****

[[category.storage-team]] 
[[category.confluence]] 
