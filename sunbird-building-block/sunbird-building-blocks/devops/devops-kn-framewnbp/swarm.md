# Swarm

* **Docker Swarm**
  * Swarm makes sure, at any point of time, we have the state defined
  * When a container health-check fails for n times, swarm restarts the container
  * If a node become unresponsive swarm will reschedule the containers in active nodes
  * Networking via iptables, called overlay network
  * **packets travel:** container → docker bridge network → iptables → ipvs → second host ...

\*\*  \*\*

* **Creating a service in Docker Swarm**

```
version: "3.3"
services:
    telemetry:
        image: subird/telemetry-service:2.0.0
        ports:
            - "9001:9001"
        deploy:
            replicas: 2
            resources:
              reservations:
                memory: "50M"
              limits:
                memory: "100M"
```

\| |

![](../../../../DevOps/devops-kn-framewnbp/images/storage/telemetry-service.png)

***

\[\[category.storage-team]] \[\[category.confluence]]
