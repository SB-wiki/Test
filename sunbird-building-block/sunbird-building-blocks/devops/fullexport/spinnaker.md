# Spinnaker is a application management and application deployment tool which has the capability of de

**Pros:**

* Provisioning / Mananging the cloud infrastructure required for the deployment
* Application deployment
* Supports various deployment strategies
* Amazing pipeline for deployments which can even update the infrastructure
* Artifact promotion to various environments based on criterias set by us

**Cons:**

* Does not have build capability
* The provisioning / managing the infrastrucure during a deployment feature doesn't suit our use case or deployment strategy
* Many of the pipeline features provided (related to infra) may not be used by us

**Usage:**

* Application Management
* Application Deployment

**Application Management:**

* View and manage cloud resources
* Core concepts - Server group, Cluster, Application

![](../../../../DevOps/FullExport/images/storage/spinnaker.png)

Server Group:

* Deployable artifact - In our case docker image (Can be VM image)
* Other cofigurations like autoscaling policy, number of replicas etc.
* A deployment can consist a collection of all these and can include load balancers and firewalls associated with your deployment

Cluster:

* Logical group of server groups

Application:

* Collection of clusters

**Application Deployment:**

* Pipeline which consists of Stages
* Pipeline invocation from a trigger, cron schedule or manual
* Notifications via Email, Slack and SMS

![](../../../../DevOps/FullExport/images/storage)

![](../../../../DevOps/FullExport/images/storage)

**Deployment Strategies:**

* Blue / Green
* Rolling
* Canary

![](../../../../DevOps/FullExport/images/storage)

**Spinnaker Wokrflow** ![](../../../../DevOps/FullExport/images/storage) **Spinnaker Components** ![](../../../../DevOps/FullExport/images/storage)

**Sample Application Page on Spinnaker** ![](../../../../DevOps/FullExport/images/storage)

**Sample Pipeline UI on Spinnaker** ![](../../../../DevOps/FullExport/images/storage)

***

\[\[category.storage-team]] \[\[category.confluence]]
