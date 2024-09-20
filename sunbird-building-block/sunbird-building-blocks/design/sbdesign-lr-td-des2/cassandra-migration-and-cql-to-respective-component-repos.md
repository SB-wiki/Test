
# Introduction
Currently, all the migration scripts for all the services/repos (sunbird-lms-service, group-service, sunbird-notification-service, and sunbird-course-service) are packaged with the  **_cassandra-migration_**  module jar. And all the migration information is stored in the  **_cassandra_migration_version_**  and  **_cassandra_migration_version_counts_**  tables in the  **_sunbird_**  keyspace (used for sunbird-lms-service).

[LR-101 System JIRA](https:///browse/LR-101)


# Background & Problem Statement
If any adopter wanted to build and deploy any one of the services, then the adopter needed to create all the Cassandra keyspaces by executing the existing cassandra-migration module, even though the adopter was only adopting a specific service. There is no way for an adopter to only create/migrate specific keyspaces. 


### Key Design Problems

1. Group the migration script based on respective services/repos/keyspaces.


1. Remove the bundling on script as a part of cassandra-migration module and variabilise the script path.


1. Variabilize the keyspace for cassandra-migration module.


1. Variabilize the script location for cassandra-migration module.




# Design
Each keyspace will have its own cassandra_migration_version and cassandra_migration_version_counts table.


* Sample of cassandra_migration_version and cassandra_migration_version_counts table:




```
cqlsh> SELECT * FROM sunbird_groups.cassandra_migration_version;

 version | checksum    | description             | execution_time | installed_by | installed_on                    | installed_rank | script                           | success | type | version_rank
---------+-------------+-------------------------+----------------+--------------+---------------------------------+----------------+----------------------------------+---------+------+--------------
     1.1 | -1118871967 | cassandra-release-5.2.0 |              6 |    cassandra | 2023-02-06 05:04:39.893000+0000 |              1 | V1.1_cassandra-release-5.2.0.cql |    True |  CQL |            1

(1 rows)


cqlsh> SELECT * FROM sunbird_groups.cassandra_migration_version_counts;

 name           | count
----------------+-------
 installed_rank |     1

(1 rows)
```

* Separate all the migration script based on keyspaces:


    * Option 1: push it to the respective repo


    * Option 2: Keep in sunbird-utils repo and group is based on keyspace.



    
* Mapping of the available keyspaces with repos





|  **Repo Name**  |  **Keyspaces**  | 
|  --- |  --- | 
| sunbird-lms-service | sunbird | 
| groups-service | sunbird_groups | 
| sunbird-notification-service | sunbird_notifications | 
| sunbird-course-service | sunbird_courses | 


### Command 1:

```
java -jar \
-Dcassandra.migration.scripts.locations=filesystem:<absolute or relative path>/db/migration/cassandra \
-Dcassandra.migration.cluster.contactpoints=localhost \
-Dcassandra.migration.cluster.port=9042 \
-Dcassandra.migration.cluster.username=username \
-Dcassandra.migration.cluster.password=password \
-Dcassandra.migration.keyspace.name=keyspace_name \
target/*-jar-with-dependencies.jar migrate
```

### Command 2:

```
java -cp "cassandra-migration-0.0.1-SNAPSHOT-jar-with-dependencies.jar" com.contrastsecurity.cassandra.migration.utils.MigrationScriptEntryPoint
```
The system environment listed below is required for command 2.


### System Env

```
sunbird_cassandra_keyspace=<keyspace_name>
sunbird_cassandra_migration_location="filesystem:<absolute or relative path>/db/migration/cassandra"
```


*****

[[category.storage-team]] 
[[category.confluence]] 
