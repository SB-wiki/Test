
## Overview
The bench marking of the group apis is to provide a confidence in the system for availability, scalability in the event of high load to the system. It also enables us to find the bottleneck in the system to attain such availability.


## System Configuration
Bench marking  or load is performed using jmeter cluster to simulate the requests and the service is deployed in the load test environment. System configuration for the service to be deployed  is decided as the base configuration to start the testing and gradually increases to horizontally(by increasing the number of machines) or vertical (By increasing the Memory or cpu core).


### Pre Configuration:
For the group service , the system configuration contains 12 instances with 4 GB RAM and 2 core CPU. Later during Soak test RAM is reduced to 3 GB and the service is benchmark by simulating the real traffic percentage of request to different APIs.


### Load Test & Soak Test:
Process :- 
1. Deploy the Group Service in the load test environment and create a base configuration to start the bench marking.


1. Write a Jmeter scripts to simulate the requests against each api and upload it into Jmeter clusters.


1. Run the Jmeter Scripts and observe the behaviour of other systems such as Cassandra, API manager , CPU and Memory utilization through grafana dashboard to find the bottleck. [https://loadtest.ntp.net.in/grafana/?orgId=1](https://loadtest.ntp.net.in/grafana/?orgId=1)


1. Run scripts with min 200 user concurrency for better metric for the group api benchmarking.


1. Report can be downloaded through Bash script.


1. Get the important metrics such as total number of request, Avg response time, 95th,99th percentile time, Throughput and Error percentage.



Jmeter Scripts Run and Report Down Load

Group Create : 


```
cd /mount/data/benchmark/sunbird-perf-tests/sunbird-platform/group-create
./run_scenario.sh /mount/data/benchmark/apache-jmeter-5.3/ '28.0.0.37,28.0.0.43,28.0.0.44,28.0.0.45' group-create group-create_Mar10_R6 10 30 10 <Beare key token> /mount/data/benchmark/sunbird-perf-tests/sunbird-platform/testdata/host_ips_5nodes.csv /mount/data/benchmark/sunbird-perf-tests/sunbird-platform/user-create/user-data-new/userdata-250K-tokens-05032021.csv /api/group/v1/create
```
Group Update Activity:


```
cd /mount/data/benchmark/sunbird-perf-tests/sunbird-platform/group-update-activity
./run_scenario.sh /mount/data/benchmark/apache-jmeter-5.3/ '28.0.0.37,28.0.0.43,28.0.0.44,28.0.0.45' group-update-activity group-update-activity_Mar10_R23 10 30 10 <Bearer Token> /mount/data/benchmark/sunbird-perf-tests/sunbird-platform/testdata/host_ips_5nodes.csv /mount/data/benchmark/sunbird-perf-tests/sunbird-platform/testdata/groups_testdata/groups_update_01.csv  /api/group/v1/update
```
Group Update Member


```
cd /mount/data/benchmark/sunbird-perf-tests/sunbird-platform/group-update-member
./run_scenario.sh /mount/data/benchmark/apache-jmeter-5.3/ '28.0.0.37,28.0.0.43,28.0.0.44,28.0.0.45' group-update-member group-update-member_Aug5_R100 10 30 10 <BearerToken> /mount/data/benchmark/sunbird-perf-tests/sunbird-platform/testdata/host_ips_5nodes.csv  /mount/data/benchmark/sunbird-perf-tests/sunbird-platform/testdata/groups_testdata/testdata_for_150members_add.csv /mount/data/benchmark/sunbird-perf-tests/sunbird-platform/user-create/user-data-new/userdata-250K-tokens-05032021.csv /api/group/v1/update
```
Group Read:


```
cd /mount/data/benchmark/sunbird-perf-tests/sunbird-platform/group-read
./run_scenario.sh /mount/data/benchmark/apache-jmeter-5.3/ '28.0.0.37,28.0.0.43,28.0.0.44,28.0.0.45' group-read group-read_RunId01 10 30 10 <Bearer Token> /mount/data/benchmark/sunbird-perf-tests/sunbird-platform/testdata/host_ips_5nodes.csv /mount/data/benchmark/sunbird-perf-tests/sunbird-platform/testdata/groups_150Members_20Courses.csv /api/group/v1/read
```
Group List


```
cd /mount/data/benchmark/sunbird-perf-tests/sunbird-platform/group-list
./run_scenario.sh /mount/data/benchmark/apache-jmeter-5.3/ '28.0.0.37,28.0.0.43,28.0.0.44,28.0.0.45' group-list group-list_RunId01 10 30 10 <Bearer Token> /mount/data/benchmark/sunbird-perf-tests/sunbird-platform/testdata/host_ips_5nodes.csv /mount/data/benchmark/sunbird-perf-tests/sunbird-platform/user-create/user-data-new/userdata-250K-tokens-05032021.csv /api/group/v1/list
```


SOAK Test:
```
cd /mount/data/benchmark/sunbird-perf-tests/sunbird-platform/group-soak-test
./run_scenario_soak.sh group-soak-test
```
Report Download from server:Create as script file  **_getReport.sh_**  with the below code and update the username and Ips as per the env.


```

#!/bin/bash
scenariolog=$1
tarpath=$(dirname $1)
tarname=$(basename $(dirname $(dirname $1)))
ssh -A <username>@27.0.1.5 "ssh <username>@<jmeter cluster ip> \"tar -cvf /tmp/${tarname}.tar ${tarpath}\""
ssh -A <username>@27.0.1.5 "sudo rm -rf /tmp/${tarname}.tar && scp <username>@<jmeter cluster ip>:/tmp/${tarname}.tar /tmp"
scp <username>@27.0.1.5:/tmp/${tarname}.tar .
tar -xvf ${tarname}.tar
open -a "Google Chrome" ./${tarpath}/summary/index.html
~                                                         
```
Run command: 


```
bash getReport-36.sh /mount/data/benchmark/sunbird-perf-tests/sunbird-platform/logs/group-read/group-read_apr27_R3/logs/summary/summary
```
Results : [https://docs.google.com/spreadsheets/d/1ZZDP5Fbjq0NK8_YUELe4BcKjyaVkmxw0KcYf6B4IAuE/edit?ts=60642e48#gid=1635038615](https://docs.google.com/spreadsheets/d/1ZZDP5Fbjq0NK8_YUELe4BcKjyaVkmxw0KcYf6B4IAuE/edit?ts=60642e48#gid=1635038615)





*****

[[category.storage-team]] 
[[category.confluence]] 
