# Adding-a-node-to-Cassandra-Cluster

**Overview** This document describes the standard operating procedure to add a new node to the existing Cassandra cluster

**Checklist**

* Make sure capacity for same instance type is available in the subscription/cloud account
* Make sure the new node being added is of same type instance type as current cluster node
* New Node should be part of the DB subnet of the environment VNET

**Steps**

* Create a VM of same instance type and disk size as current cluster from azure portal console&#x20;
* Bootstrap the VM using Jenkins job
* Ansible changes in Github private repo&#x20;
  * Create a new temporary branch in a private repository from the latest release branch and give a name like release-4.3.0-cassandra-provision
  * Remove the hostname and ip’s of current cassandra cluster nodes
  * Add  the hostname and ip information of the new node
* Provision Cassandra in the new node by triggering Provision/Core/Cassandra Jenkins job. Make sure new private repo branch name (release-4.3.0-cassandra-provision) is used in the job options
* Update the ulimit values to 65535 at /etc/security/limits.conf
*

```
hard  nofile  65535
soft  nofile  65535
```

* Provision the cassandra trigger jar and logback xml via Jenkins job Deploy/KnowledgePlatform/CassandraTrigger _(Before this update Cassandra ip_ ' _s in KP/hosts)_
* \_ \_ Enable monitoring in new node by deploying node exporter and process exporter and deploy monitoring _(Before this update Cassandra ip’s in Core/hosts)._ Use the bootstrap job under OpsAdministration
* Backup the existing cluster. Ensure backup has taken snapshots from all the current nodes in the cluster
* SSH to the new node and do the following
  * Stop cassandra process using command sudo service cassandra stop and verify if the process is stopped successfully
  * Edit /etc/cassandra/cassandra.yaml file and update/add the following
  *

```
endpoint_snitch: GossipingPropertyFileSnitch
seednodes: “node1-ip, node2-ip” . E.g. seednodes: “11.4.2.11, 11.4.2.26”
batch_size_warn_threshold_in_kb: 25
compaction_throughput_mb_per_sec: 128
concurrent_compactors: 4
streaming_socket_timeout_in_ms: 86400000
```

```
* Delete the files and folders under /var/lib/cassandra/data folder 
```

```
rm -rf /var/lib/cassandra/data/* 
```

* Start cassandra process using sudo service cassandra start
* Verify if the node is in the process of joining/bootstrapping the cluster&#x20;
  * Runnodetool statusYou will see the status of new node as UJ which mean Up and Joining
  * Check /var/log/cassandra/system.log and look for message JOINING: Starting to bootstrap...
  * Run nodetool compactionstats -H to check if any compactions are running&#x20;
  * In case of bootstrap failure, resume the node bootstrap using nodetool bootstrap resume command through tmux session
  * **DO NOT RESTART THE SERVICE ON THE NODE BEING ADDED DURING THE BOOTSTRAP OPERATION**
* Run nodetool clean once the node joined the cluster and is stable
  * Login to the node and run the command nodetool cleanup

***

\[\[category.storage-team]] \[\[category.confluence]]
