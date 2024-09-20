# Knowledge-Platform

falseLog in to the Jenkins and do the following

### Build

* Switch to Build folder and run all jobs. Provide the value for  **github\_release\_tag** as per the details mentioned in this page - \[\[Current Release Tags and Jenkins Jobs Reference|Current-Release-Tags-and-Jenkins-Jobs-Reference]]

### OpsAdministration

1. Bootstrap                                                                                                               # Creates Deployer User

### Provision

* Download neo4j enterprise 3.3.x version and keep it in your private repo under artifacts directory. The name of the file should be ending with neo4j\*.tar.gz
* Since the file size of neo4j will be larger than 100 MB, you need to use git lfs to store this artifact in your private repo. Refer this link to see for git lfs details - [https://git-lfs.github.com/](https://git-lfs.github.com/)
* Switch to Provision//KnowledgePlatform and run jobs in following order
  1. Cassandra
  2. CompositeSearch
  3. Neo4j
  4. Zookeeper
  5. Kafka
  6. Learning
  7. Redis
  8. Search

Deploy

* Switch to Deploy/dev/KnowledgePlatform and run all jobs in the following order
  1. CassandraDbUpdate
  2. Neo4j
  3. StartNeo4jCluster
  4. Learning
  5. Search
  6. Neo4jDefinitionUpdate
  7. Neo4jElasticSearchSyncTool
  8. KafkaSetup
  9. Yarn

Manual Run - Content retire API

* Login to the cassandra VM and run the below commands
* **vi /etc/cassandra/cassandra.yaml**
* Update the value as  **batch\_size\_fail\_threshold\_in\_kb: 200**
* **service cassandra restart**
* **cd /tmp**
* **wget https://sunbirdpublic.blob.core.windows.net/installation/script\_data.csv**
* Run  **cqlsh**
* \*\*COPY dev\_script\_store.script\_data FROM '/tmp/script\_data.csv';          \*\* (Here  **dev**  will be you env name)
* \*\*SELECT COUNT(\*) FROM dev\_script\_store.script\_data ;                         \*\* (Output should be 324 rows)
* Login to learning VM and restart tomcat
* **sudo service tomcat restart**
* Now you should be able to delete contents from workspace, drafts, contents which are published etc.

***

\[\[category.storage-team]] \[\[category.confluence]]
