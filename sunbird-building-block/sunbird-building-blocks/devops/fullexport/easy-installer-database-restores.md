As we are using kubernetes to host databases, so approach is different to restore database

Refer the following link to take backup of the databases: 

 **Neo4j Restore** 


1. copy backup folder from the azure storage account to the pod which you will create with the below manifest, this pod will mount same pv where data is present of neo4j.




```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: ubuntu-deployment
  labels:
    app: ubuntu
spec:
  replicas: 1
  selector:
    matchLabels:
      app: ubuntu
  template:
    metadata:
      labels:
        app: ubuntu
    spec:
      containers:
      - name: ubuntu
        image: ubuntu
        command: ["sleep", "123456"]
        volumeMounts:
        - mountPath: /data
          name: neo4j-data
      volumes:
      - name: neo4j-data
        persistentVolumeClaim:
          claimName: neo4j-claim

```

1. scale neo4j deployment to 0  


```
kubectl scale --replicas=0 deployment/neo4j -n sunbird
```

1.  Go inside the pod which you created with the manifest, navigate to /data/databases, rename graph.db to graph.db.backup and paste the graph.db folder at same location. Exit from the pod 


```
kubectl exec -it neo4j -n test -- /bin/bash
cd /data/databases
mv graph.db graph.db.backup
go to your backup file and move graph.db to /data/databases
mv yourbackup_graph.db /data/databases (make sure directory name shoudl remain graph.db)
```

1. Scale again neo4j pod to 1 which will load the data from the backup data 


```
kubectl scale --replicas=1 deployment/neo4j -n sunbird
```

1. Remove deployment which was created to restore neo4j backup





 **Elasticsearch Restore** 

As we took elasticsearch backup with help of azure plugin


```
kubectl exec -it eleasticsearch-0 -n sunbird -- /bin/bash
```
create repository with following command

curl -XPUT '[http://localhost:9200/_snapshot/azurebackup](http://localhost:9200/_snapshot/azurebackup)' -H 'Content-Type: application/json' -d '{ "type": "azure", "settings": { "container": "<blob_name>", "base_path": "<storage_account_name>"} }'



restore the snapshot with below command

curl -XPOST '[http://localhost:9200/_snapshot/azurebackup/snapshot_1/_restore](http://localhost:9200/_snapshot/azurebackup/snapshot_1/_restore)'



checking status of the snapshot restore

curl -s "[http://localhost:9200/_snapshot/azurebackup/snapshot_1/_status?pretty](http://localhost:9200/_snapshot/azurebackup/snapshot_1/_status?pretty)"



 **Cassandra Restore** 


1. Download restore script from below url


```
https://sunbirdstagingpublic.blob.core.windows.net/dbrestorescripts/restore.py
```

1. Download backup from storage account and untar the backup


1.  Copy backup folder to pod at location /bitnami/cassandra


```
kubectl cp backupfolder sunbird/cassandra-0:/bitnami/cassandra/ 
```

1. Copy restore script also which you have downloaded from the url to the pod and place it to /bitnami/cassandra 


```
kubectl cp restore.py sunbird/cassandra-0:/bitnami/cassandra/ 
```

1.  Restore schema got to backupfolder eg. /bitnami/cassandra/cassandrabackup, you will find db_schema.cql. Use below command


```
cqlsh -f db_schema.cql
```

1.  Use below command to restore


```
python3 restore.py --snapshotdir /bitnami/cassandra/cassandrabackupfolder --datadirectory /bitnami/cassandra/data/data/
```

1. Restart the statefulset once operations is done


```
kubectl rollout restart statefulsets cassandra -n sunbird
```

1. Validate data by using cqlsh


1. Delete backup folder which you have copied earlier you can delete restore.py script



 **Redis Restore** 


1. Download required backup from azure storage account and uncompress file


1. Copy backup to redis pod at location /data


```
kubectl cp dump.rdb sunbird/redis-master-0:/data
```

1. go to /data/appendonlydir you will see one rdb file eg. appendonly.aof.1.base.rdb , take copy of that file or rename same by appending backup to file name


1. rename downloded rdb file with the same name eg if the file name inside appendonlydir is appendonly.aof.1.base.rdb then rename your dump.rdb to the same name 


1. Past that rdb to the /data/appendonlydir


1. restart statefulset


```
kubectl rollout restart statefulsets redis -n sunbird
```


 **Postgres Restore** 


1. Download required backup from azure storage account and uncompress  backup file


1. Copy backup to /bitnami/postgresql directory inside file or you can connect database remotely and do a restore


```
kubectl cp backup.sql sunbird/postgres-0:/bitnami/postgresql
```

1. Use below command to restore inside the postgres pod


```
psql -U username --file=backupfile.sql
```

1. Validate databases 





*****

[[category.storage-team]] 
[[category.confluence]] 
