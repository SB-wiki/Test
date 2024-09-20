# Cassandra-Audit-Logging-for-Different--Data-Types

The purpose of this document is to test Cassandra Trigger and ecAudit logging with different data types to evaluate their support.

Table schema on which we have performed operations.

```
CREATE TABLE practice.trigger_audit_log (
    id int PRIMARY KEY,
	bolbtype blob,
    listofmap list<frozen<map<text, text>>>,
    listvalues list<text>,
    mapvalues map<text, text>,
    stringvalue text,
    time date
) WITH bloom_filter_fp_chance = 0.01
    AND caching = {'keys': 'ALL', 'rows_per_partition': 'NONE'}
    AND comment = ''
    AND compaction = {'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy', 'max_threshold': '32', 'min_threshold': '4'}
    AND compression = {'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND crc_check_chance = 1.0
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99PERCENTILE';
CREATE TRIGGER trigger_on ON practice.trigger_audit_log USING 'org.iostream.cassandra.Trigger';


```

Query 1  and result :

```
Query : INSERT INTO trigger_audit_log (id , stringvalue , listvalues , mapvalues , listofmap ,time ) VALUES ( 1,'iostream',['utils','mw','service'],{'one':'1','two':'2'},[{'stu':'student','in':'instructor'},{'cls':'class','std':'standard'}],'2019-03-27') ;

EcAudit : 13:17:10.654 - client:'10.0.1.116'|user:'cassandra'|status:'ATTEMPT'|operation:'INSERT INTO practice.trigger_audit_log (id , stringvalue , listvalues , mapvalues , listofmap ,time ) VALUES ( 1,'iostream',['utils','mw','service'],{'one':'1','two':'2'},[{'stu':'student','in':'instructor'},{'cls':'class','std':'standard'}],'2019-03-27') ;'

Trigger : {keyspace=practice, listofmap=[{in=instructor, stu=student}, {cls=class, std=standard}], stringvalue=iostream, mapvalues={one=1, two=2}, operationType=UPDATE_ROW, time=-2147465666, id=1, listvalues=[utils, mw, service], table=trigger_audit_log}



```

Query 2 and result :

```
Query : UPDATE trigger_audit_log SET listofmap =[{'1':'one','2':'two'},{'ex':'example','ps':'pressure'}] , listvalues= ['util-u','mw-u','service-u'], mapvalues ={'x':'y'} WHERE id =1;

EcAudit : 13:26:16.256 - client:'10.0.1.116'|user:'cassandra'|status:'ATTEMPT'|operation:'UPDATE practice.trigger_audit_log SET listofmap =[{'1':'one','2':'two'},{'ex':'example','ps':'pressure'}] , listvalues= ['util-u','mw-u','service-u'], mapvalues ={'x':'y'} WHERE id =1;'

Trigger : {keyspace=practice, listofmap=[{1=one, 2=two}, {ex=example, ps=pressure}], mapvalues={x=y}, operationType=UPDATE_ROW, id=1, listvalues=[util-u, mw-u, service-u], table=trigger_audit_log}
```

Query 3 and result :

```
Query : DELETE from practice.trigger_audit_log WHERE id = 8 ;

EcAudit : 14:28:32.495 - client:'10.0.1.116'|user:'cassandra'|status:'ATTEMPT'|operation:'DELETE from practice.trigger_audit_log WHERE id = 8 ;'

Trigger : {operationType=DELETE_ROW, id=8, table=trigger_audit_log}
```

Query 4 and result :  if we use **blob** data type.

```
Query : INSERT INTO practice.trigger_audit_log (id , bolbtype ) VALUES ( 5, textAsBlob('bdb14fbe076f6b94444c660e36a400151f26fc6f'));

EcAudit : 14:58:52.704 - client:'10.0.1.116'|user:'cassandra'|status:'ATTEMPT'|operation:'INSERT INTO practice.trigger_audit_log (id , bolbtype ) VALUES ( 5, textAsBlob('bdb14fbe076f6b94444c660e36a400151f26fc6f'));'

Trigger : {bolbtype=java.nio.HeapByteBuffer[pos=0 lim=40 cap=40], keyspace=practice, operationType=UPDATE_ROW, id=5, table=trigger_audit_log}

```

***

\[\[category.storage-team]] \[\[category.confluence]]
