
## Overview
This document provides the insights of horizontally scaling cassandra cluster with the observations and recommendations from benchmarking different scenarios.


## Tests and Observations
To test the scenarios, a keyspace with replication factor of 3 and a schema with all possible data types which are currently used in the platform is considered.


```
CREATE KEYSPACE test_keyspace_rf3 WITH replication = {'class': 'SimpleStrategy', 'replication_factor': '3'}  AND durable_writes = true;

CREATE TABLE test_keyspace_rf3.user_quorum_rw (
    id text PRIMARY KEY,
    channel text,
    countrycode text,
    createdby text,
    createddate text,
    currentlogintime text,
    dob text,
    email text,
    emailverified boolean,
    firstname text,
    flagsvalue int,
    framework map<text, frozen<list<text>>>,
    gender text,
    grade list<text>,
    language list<text>,
    lastname text,
    loginid text,
    password text,
    phone text,
    phoneverified boolean,
    profilevisibility map<text, text>,
    status int,
    updatedby text,
    updateddate text,
    userid text,
    username text,
    usertype text
);
CREATE INDEX inx_t3uq_userid ON test_keyspace_rf3.user_quorum_rw (userid);
CREATE INDEX inx_t3uq_loginid ON test_keyspace_rf3.user_quorum_rw (loginid);
CREATE INDEX inx_t3uq_email ON test_keyspace_rf3.user_quorum_rw (email);
CREATE INDEX inx_t3uq_status ON test_keyspace_rf3.user_quorum_rw (status);
CREATE INDEX inx_t3uq_phone ON test_keyspace_rf3.user_quorum_rw (phone);
CREATE INDEX inx_t3uq_username ON test_keyspace_rf3.user_quorum_rw (username);
```

### 1. Read and Write with QUORUM
Test was conducted on both 3 node cluster and 5 node cluster for reading data just after writing with same consistency level of QUORUM.

 **3Nodes Result:** 



| No. of requests | 50M (1000 Threads) | 
| Throughput | 8098.5 per sec | 
| CPU usage | 89% Max | 
| Error | 0 | 

 **5Nodes Result:** 



| No. of requests | 100M (1000 Threads) | 
| Throughput | 11429.6/s | 
| CPU usage | 85% Max | 
| Error | 3 - For writes, 1700 - for reads | 



 **Observation:** 

With 5nodes cluster, there is a considerable amount of increase in throughput, and a very negligible amount of errors.

Since the consistency is QUORUM, the data availability and consistency is met and this is the recommended consistency for both write and read.




### 2. Read with secondary index
Test was conducted on both 3 node cluster and 5 node cluster for reading data using secondary index, as defined in the above mentioned schema.

 **3Nodes Result:** 



| No. of requests | 1.6M (1000 threads) | 
| Throughput | 7847.6 per sec | 
| CPU usage | 65% Max | 
| Error | 0 | 
| Avg response time | 124 ms | 

 **5Nodes Result:** 



| No. of requests | 1.6M (1000 threads) | 
| Throughput |  894.2 per sec | 
| CPU usage | 91% Max | 
| Error | 0 | 
| Avg response time | 1.1 s | 

 **Observation:** 

As the number of nodes in the cluster increase, the performance of reads with secondary index decreases exponentially.

It is evident from the above tests, the average response time has increased drastically, as cassandra scans each node for the index value, thereby reducing the performance.

Reading from secondary index is not dependent on the consistency level.

It is not recommended to query data using secondary indices.


### 3. Read with QUORUM
Test was conducted on both 3 node cluster and 5 node cluster for reading data with QUROUM consistency.

 **3nodes result:** 



| No. of requests | 50M (1000 threads) | 
| Throughput | 20099.2 per sec | 
| CPU usage | 70% Max | 
| Error | 0 | 

 **5nodes result:** 



| No. of requests | 50M (1000 threads) | 
| Throughput | 22683.9 per sec | 
| CPU usage | 59% Max | 
| Error | 0 | 

 **Observation:** 

From the above results, with increased number of concurrency, we can get better throughput with 5 nodes cluster.




### 4. Write with QUORUM
Test was conducted on both 3 node cluster and 5 node cluster for writing data with QUROUM consistency.

 **3nodes result:** 



| No. of requests | 50M (1000 threads) | 
| Throughput | 12804.8 per sec | 
| CPU usage | 88% Max | 
| Error | 0 | 

 **5nodes result:** 



| No. of requests | 50M (1000 threads) | 
| Throughput | 18014.7 per sec | 
| CPU usage | 91% Max | 
| Error | 0 | 

 **Observation:** 

Writes with QUORUM gave better throughout with 5 nodes cluster.


## Summary
On adding nodes to cassandra cluster, writes and reads with QUROUM consistency level is recommended.

Avoiding or not using secondary indices for querying data is highly recommended as there is an exponential drop in performance.



*****

[[category.storage-team]] 
[[category.confluence]] 
