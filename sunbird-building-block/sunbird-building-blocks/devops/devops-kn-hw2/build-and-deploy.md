# Build-and-Deploy

* **IMPORTANT: Take a backup of all your databases by running backup jobs located under OpsAdministration → Core / KnowledgePlatform / DataPipeline → BackupJobs OR You can use VM Disk Snapshots from your cloud provider**
* Once all the variables and Jenkins configurations are complete, you can start to build and deploy services.
* Build all the services mentioned in the table below.
* Ensure you provide the \*\*github\_release\_tag \*\* for Build jobs as per the tags mentioned in this sheet - \[\[Current Release Tags and Jenkins Jobs Reference|Current-Release-Tags-and-Jenkins-Jobs-Reference]].
* Ensure all ArtificatUpload Jobs as successful.
* Deploy services which are mentioned in the table below.  **IMPORTANT: The order of deployment for jobs in deploy directory should be same as mentioned in the below table.**
* If some build and deploy jobs are not relevant to your setup, you can skip them.
* Ensure you provide **branch\_or\_tag** as per the data mentoined in this sheet - \[\[Current Release Tags and Jenkins Jobs Reference|Current-Release-Tags-and-Jenkins-Jobs-Reference]] under  \*\*Jobs which use this repository \*\* column.
* Once all services are deployed, please perform the manaual configurations mentioned in this sheet - \[\[Manual configurations|Manual-configurations]]

**Optional:**

* You can run the Logging job if required which is located under  **Core → Deploy → Logging**
* The Logging jobs will provision Kibana and provide you access to containr logs. But this will consume additional resources in your Swarm machines and we do not recommend to run this job if you have a single swarm machine.

Here is the list of jobs that are required to be built and deployed for your reference

**Order: Top down per column**

| Knowledge Platform Build | Knowledge Platform Deploy                                                     | DataPipeline Build | DataPipeline Deploy   | Core Build | Core Deploy      |
| ------------------------ | ----------------------------------------------------------------------------- | ------------------ | --------------------- | ---------- | ---------------- |
|                          | StopNeo4jCluster                                                              |                    | CassandraDbUpdate     | Cassandra  | Cassandra        |
|                          | Neo4j                                                                         |                    | KafkaSetup            | Keycloak   | Keycloak         |
|                          | StartNeo4jCluster                                                             |                    | KafkaIndexer          | Player     | Player           |
|                          | KafkaSetup                                                                    | Secor              | Secor                 | Learner    | Learner          |
|                          | CassandraDbUpdate                                                             | Analytics          | AnalyticsAPI          | Content    | Content          |
|                          | Neo4jDefinitionUpdate **(Run manual queries mentioned below after this job)** | DataPipeline       | DataProducts          | Telemetry  | Telemetry        |
| KnowledgePlatform        | Learning                                                                      |                    | SamzaTelemetrySchemas | Proxy      | Proxy            |
|                          | Search                                                                        | Yarn               | Yarn                  |            | OnboardAPI       |
| Yarn                     | Yarn                                                                          |                    |                       |            | OnboardConsumers |
| SyncTool                 | Neo4jElasticSearchSyncTool                                                    |                    |                       |            | Logging          |

**Manual queries to be run for Neo4j:**

* Login to neo4j machine and switch to learning user
* Go to NEO4J\_HOME/bin directory
* Run ./cypher-shell
* Execute the below queries

_**match (n:domain) where n.IL\_FUNC\_OBJECT\_TYPE in \[“Content”, “ContentImage”] AND exists(n.medium) set n.medium = \[n.medium];**_

_**match (n:domain) where n.IL\_FUNC\_OBJECT\_TYPE in \[“Content”, “ContentImage”] AND exists(n.subject) set n.subject = \[n.subject];**_

_**match (n:domain{}) WHERE exists(n.sYS\_INTERNAL\_LAST\_UPDATED\_ON) remove n.sYS\_INTERNAL\_LAST\_UPDATED\_ON;**_

***

\[\[category.storage-team]] \[\[category.confluence]]
