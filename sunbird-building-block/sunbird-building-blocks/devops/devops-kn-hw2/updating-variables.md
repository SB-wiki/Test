 **_Note:_** 
*  **If you want to run only Core services which will connect to Ekstep backend for other dependent services like Knowledge Platform and Data Pipeline, follow the below steps for Core module only** 


*  **Once you complete the below steps, go to this page to get details on extra variables that need to be added for Core service only to work - ** 






1. 
### Updating private repo with hosts and variables

    1. git clone [https://github.com/project-sunbird/sunbird-devops](https://github.com/project-sunbird/sunbird-devops)
    1. 
```
cd sunbird-devops && git checkout tags/release-1.14.0 -b release-1.14.0
```

    1. cp -rf sunbird-devops/private_repo .
    1. cd private_repo
    1. 
```
Folder Structure for the private directory which contains ansible hosts secrets and variables.
```

```bash
~/Documents/projects/subird-devops/private_repo(DO-470 ✗) tree ansible
ansible
└── inventory
    └── dev
        ├── Core
        │   ├── common.yml
        │   ├── hosts
        │   └── secrets.yml
        ├── DataPipeline
        │   ├── common.yml
        │   ├── hosts
        │   └── secrets.yml
        └── KnowledgePlatform
            ├── common.yml
            ├── hosts
            └── secrets.yml

5 directories, 9 files

```



    1. git init
    1. git add .
    1. git commit -m"Creating private files"
    1. 
```
git remote add origin <private repo url>
```

    1. 
```
git branch --set-upstream-to=origin/master master && git push --set-upstream origin master
```

    1. 
```
update the variables and push it to upstream.
```


    
1. 
```
Updating variables and hosts
```

    1. 
```
cd private_repo/ansible/inventory/dev/<module>/
```

    1. 
```
update hosts common.yml secrets.yml
```


    


```

```




| [S.NO](http://S.NO) | Service | Server | IP Address of the machine | Ansible Group Name | Module | 
| 1 | jenkins-master |  |  |  | Core | 
| 2 | manager | Server-1 (swarm) |  | swarm-manager-1,swarm-agent-for-prometheus-1 swarm-agent-for-grafana-1, swarm-agent-for-alertmanager-1, | 
| 3 | log-es | log-es-1 | 
| 4 |  |  | 
| 5 | keycloak | Server-2 (core-db) |  | keycloak-1 | 
| 6 | cassandra-lms (core) | cassandra-1 | 
| 8 | Postgress | postgresql-master-1, postgresql-slave-1 | 
| 9 | es-lms-1 | es-1 | 
| 10 |  |  | 
| 11 | cassandra-lp-dp | Server-3 (lp-db) |  | lp-cassandra, dp-cassandra | KnowledgePlatform | 
| 12 | kp-dp-es-1 | composite-search-cluster,es-ps | 
| 13 | Postgress |  | 
| 14 | neo4j | learning-neo4j-node1 | 
| 15 | learning-1 | Server-4 (lp-services) |  | learning1,logstash-ps | 
| 16 | redis | redis1 | 
| 17 | search | search1 | 
|  |  |  |  |  |  | 
| 18 | spark | Server 5 (spark) |  | spark | Data Pipeline | 
| 19 | yarn-rm | Server 6 (yarn-RM) |  | yarn-master,yarn-ps | 
| 20 | yarn-slave | Server 7 (yarn-slave) |  | yarn-slave,yarn-ps | 
| 21 |  |  |  |  | 
| 22 | analytics-api | Server 8 (dp-services) |  | analytics-api, analytics-ps, | 
| 23 | kafka-indexer | kafka-indexer | 
| 24 | secor | secor, secor-ps | 
| 25 | InfluxDB |  | 
| 26 |  |  |  |  |  | 
| 27 | kafka (Kp, Dp. Core) | Server 9 (kafka) |  | processing-cluster-kafka, processing-cluster-zookeepers, kafka-ps kafka-1 | Common | 





*****

[[category.storage-team]] 
[[category.confluence]] 
