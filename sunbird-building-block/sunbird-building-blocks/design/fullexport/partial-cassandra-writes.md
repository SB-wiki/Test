
### Overview 
This document contains observation on Batch execution with different configuration for partial writes.


## Tests and Observations
For testing different scenarios keyspace and table created 


```
CREATE KEYSPACE test WITH replication = {'class':'SimpleStrategy', 'replication_factor' : 2};

CREATE TABLE user(name text, id text, PRIMARY KEY (name));
```
In java 


```
PreparedStatement preparedStatement = session.prepare("insert into test.user (id, name) values (?, ?)");
PreparedStatement preparedStatement2 = session.prepare("update test.user set id='id_updated-1' where name=?");
PreparedStatement preparedStatement3 = session.prepare("update test.user set id='id_updated-2' where name=?");


int i = 1;
while(i <= 1000) {
	batchStatement.add(preparedStatement.bind("id_"+i, "user-" + i));
	++i;
}

batchStatement.add(preparedStatement2.bind("user-1"));
batchStatement.add(preparedStatement3.bind("user-2"));
```
In cassandra.yaml file change timeout to verify partial write


```
write_request_timeout_in_ms: 10
```
The above query will throw exception 


```
Caused by: com.datastax.driver.core.exceptions.WriteTimeoutException: Cassandra timeout during write query at 
consistency QUORUM (2 replica were required but only 1 acknowledged the write)
```

## Observation
The data got inserted into user table and got updated as above batch execution.

The WriteTimeoutException.getWriteType() == BATCH, ensures data is inserted into the table


## Approach
To handle above WriteTimeoutException we can use BatchStatement.Type


```
BatchStatement batchStatement = new BatchStatement(BatchStatement.Type.LOGGED);
```
Batch type of LOGGED, guarantees  atomic insertion of data, and WriteTimeoutException.getWriteType() == BATCH, eventually written to the appropriate replicas and the developer doesn't have to do anything.

Thus, the above two checks handles partial write.





*****

[[category.storage-team]] 
[[category.confluence]] 
