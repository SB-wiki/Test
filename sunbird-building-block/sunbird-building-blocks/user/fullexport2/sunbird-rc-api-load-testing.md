
## Overview
The bench marking of the Sunbird RC APIs is to provide a confidence in the system for availability, scalability in the event of high load to the system. It also enables us to find the bottleneck in the system to attain such availability.


## System Configuration
Bench marking or load is performed using jmeter cluster to simulate the requests and the service is deployed in the load test environment. System configuration for the service to be deployed is decided as the base configuration to start the testing and gradually increases to horizontally(by increasing the number of machines) or vertical (By increasing the Memory or cpu core).


## Load Test Results:
Currently all the testing for RC APIs done with below docker image:






```
sign- dockerhub/sunbird-rc-certificate-signer:v0.0.7
certificateapi- dockerhub/sunbird-rc-certificate-api:pre-v0.0.8
registry- dockerhub/sunbird-rc-core:pre-v0.0.8-2
```
[https://docs.google.com/spreadsheets/d/1myp0oCR1_07t1o8UTXxLvvZCzCpLF280e8f8J0mg0bI/edit#gid=1611114406](https://docs.google.com/spreadsheets/d/1myp0oCR1_07t1o8UTXxLvvZCzCpLF280e8f8J0mg0bI/edit#gid=1611114406)

Document details for load testing the certificate-generator flink job:

[[Certificate-Generator Flink job:|Load-Test-Certificate-Generator-Flink-job]]



*****

[[category.storage-team]] 
[[category.confluence]] 
