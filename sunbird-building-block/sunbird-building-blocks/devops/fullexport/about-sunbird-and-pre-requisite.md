# About-Sunbird-and-Pre-requisite

Sunbird is an open-source repository of learning management microservices architected for scale and designed to support diverse teaching and learning solutions. Sunbird is the open-source contribution by EkStep Foundation and is licensed under MIT license.

This document explains the steps to setup Sunbird on your cloud infra.

&#x20;This installation has been tested with 10 VMs running the vanilla Ubuntu 16 image;

* a Public IP
* with all ports opened
* key based ssh possible to the machines.

**Sunbird consists of 3 major subsystems**

1. Knowledge platform aka Learning platform ( Taxonomy, Content and Content Management )
2. Data-pipeline ( Creating insights from telemetry)
3. Core ( User/Org, Courses, Badges, Content Studio)

### Prerequisites

1. Servers to be provisioned

| Application | server             | count |
| ----------- | ------------------ | ----- |
| Jenkins     | 4core 16G 250G HDD | 1     |
| LP          | 2core 8G 60G HDD   | 2     |
| DP          | 2core 8G 60G HDD   | 5     |
| Core        | 2core 8G 60G HDD   | 2     |
|             | LoadBalancers      | 4     |

2. Private GitHub repository to store ansible hosts and secrets
3. FQDN(fully qualified domain name) with SSL
4. Azure Storage account&#x20;
5. Docker hub account

***

\[\[category.storage-team]] \[\[category.confluence]]
