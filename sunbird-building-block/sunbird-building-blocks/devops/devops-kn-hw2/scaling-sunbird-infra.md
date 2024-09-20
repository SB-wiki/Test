# Scaling-Sunbird-Infra

**Why are we scaling?**

* To serve incoming requests quickly
* Ability to handle increase in requests compared to current number of requests.
* Avoid single point of failure and ensure availability of services 99.9% time

**How are we scaling?**

* We are scaling horizontally wherever possible. This is the main area of focus.
* In components where horizontal scaling is not possible, we would scale it vertically

**Horizontal Scale components**

* Docker swarm
* Elasticsearch cluster
* Consumption and creations API's
  * Development team will make a change to send / receive such requests to / from elasticsearch or Redis
  * This would reduce the stress on the database for such API's and also the response would be faster
* YARN cluster  &#x20;
* Cassandra cluster
* Learning and Search servers

**Vertical Scale components**

* Neo4j
* Kafka
* Influx DB

**Multi-swarm Cluster for Resiliency** **Present Arch:**

* Single docker swarm cluster with multiple managers and nodes to run up to 256 containers in a overlay network. We have approx. 150 containers running to support 600 tps load

**Cons:**

* Network hiccups on single swarm cluster brings down site for while
* No automation for Infra for scaling
* Service downtime during upgrade

**Future Arch:**

* Multi-swarm cluster attaching to load-balancer
* Ability to ad/remove cluster without down-time&#x20;
* Blue-Green deployments are possible with Multi-swarm cluster
* Multiple backend pools to azure load balancer
* Each swarm cluster will be of same capacity&#x20;
* Auto-scaling of services (increasing replicas) can be done by polling prometheus data (cadvisor metrics)&#x20;

**Logging**

* Kibana will be moved to an individual VM
* Service label will be changed to identify the log
* Logs data from Multiple swarm clusters will be pushed to Log ElasticSearch Cluster
* Log aggregation for KP and DP services

**Monitoring**

* Upgrade Prometheus version to support hierarchical federation and snapshots
* Enable hierarchical federation
* Configure grafana dashboard to view metrics from each swarm cluster

**CDN**

* Enabling CDN for faster loading of static contents
* Dev team will be implementing a fallback to default loading when CDN not available
* After analyzing multiple CDN providers, we have selected to use Verizon Standard CDN as it is cost effective, performance and feature set looks satisfying for our needs
* Changing a CDN provider can be done easily if we require more features after a go-live evalutation
  * Azure POP locations - [https://docs.microsoft.com/en-us/azure/cdn/cdn-pop-locations](https://docs.microsoft.com/en-us/azure/cdn/cdn-pop-locations)
  * Azure CDN compare - [https://docs.microsoft.com/en-us/azure/cdn/cdn-features](https://docs.microsoft.com/en-us/azure/cdn/cdn-features)

**Load Testing**

* A production replica infrastructure would be created (without production data) with multi-swarm and other scaled up components.
* Various type of load testing would be performed on this infrastructure to test the capacity and stability
* Once the data is validated and meets our standards, the same would be planned for production.

***

\[\[category.storage-team]] \[\[category.confluence]]
