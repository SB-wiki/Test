 **Provisioning the K8s cluster** command to create AKS cluster:


```
az aks create --resource-group <resouse-group-name> --node-resource-group <k8s-resource-group-name> --name <cluster name>  --node-count 4 --admin-username deployer --kubernetes-version 1.19.9 --service-principal "<service principal id>" --node-vm-size Standard_D4s_v3 --client-secret "<client id>" --network-plugin azure --ssh-key-value @deployer.pub -l <region> --vm-set-type VirtualMachineScaleSets --vnet-subnet-id /subscriptions/<subscription id>/resourceGroups/<resouse-group-name>/providers/Microsoft.Network/virtualNetworks/<vnet-name>/subnets/<subnet name>
```
Get the kubeconfig file for your cluster with the below command:


```
az aks get-credentials --resource-group <resource group name> --name <cluster name> --file  k8s.yaml
```


 **Refer below link for Kubernetes Architecture, deployment files and Autoscaling.** 

[[Kubernetes|Kubernetes]]


### Creating deployment manifests for a microservice. Jenkinsfile, Ansible role, helm chart
helm chart includes deployment.yaml, configmap and values.yml files. below link is sample helmchart for content service, same format can be used to create helm chart for other services as well.                                                        [https://github.com/project-sunbird/sunbird-devops/tree/release-5.1.0/kubernetes/helm_charts/core/content](https://github.com/project-sunbird/sunbird-devops/tree/release-5.1.0/kubernetes/helm_charts/core/content)

jenkins file: [https://github.com/project-sunbird/sunbird-devops/blob/release-5.1.0/kubernetes/pipelines/deploy_core/Jenkinsfile](https://github.com/project-sunbird/sunbird-devops/blob/release-5.1.0/kubernetes/pipelines/deploy_core/Jenkinsfile)  This is the common jenkins file for all the kubenenets services except player, same can be used for any new services.

ansible role: There are 3 ansible roles used for kubernetes service deployments. 


* deploy-player: used for player services  [https://github.com/project-sunbird/sunbird-devops/tree/release-5.1.0/kubernetes/ansible/roles/deploy-player](https://github.com/project-sunbird/sunbird-devops/tree/release-5.1.0/kubernetes/ansible/roles/deploy-player)


* helm-deploy: New services can use this role, this role dosent have tasks to copy env variables from stack-sunbird role [https://github.com/project-sunbird/sunbird-devops/tree/release-5.1.0/kubernetes/ansible/roles/helm-deploy](https://github.com/project-sunbird/sunbird-devops/tree/release-5.1.0/kubernetes/ansible/roles/helm-deploy)


* sunbird-deploy: this is role is used by core services, which copies env file from stack-sunbird role [https://github.com/project-sunbird/sunbird-devops/tree/release-5.1.0/kubernetes/ansible/roles/sunbird-deploy](https://github.com/project-sunbird/sunbird-devops/tree/release-5.1.0/kubernetes/ansible/roles/sunbird-deploy)




### Best Practices to be followed

* CPU and Memory limits - Set as per the application requirements, do not leave it empty


* Add Liveliness and readiness probes for all the services. The following sample snippet should be part of the deployment yaml file. This allows us to configure the endpoints that K8s can use to detect that a new container is ready for use




```
        livenessProbe:      
         httpGet:
           path: /service/live
           port: 8080  
           scheme: HTTP
         initialDelaySeconds: 15   
         periodSeconds: 2
         successThreshold: 1
         timeoutSeconds: 3
       readinessProbe:
         httpGet:
           path: /service/ready
           port: 8080
           scheme: HTTP
         initialDelaySeconds: 15   
         periodSeconds: 2
         successThreshold: 1
         timeoutSeconds: 3
```

* Rolling Strategy: Kubernetes allows the containers to be updated without downtime. When we send a deploy request to K8s, it will bring up new containers with the requested version and for every new container(configurable) that is live and handling requests, it purges an old container and overtime the cluster will only have the newer version. Rollback is also allowed if there are errors after the new deployment. The following snippet should be part of the deployment yaml file. This allows to control the number of new containers and the old container purge count.




```
strategy:
   rollingUpdate:
     maxSurge: 1
     maxUnavailable: 0
   type: RollingUpdate
```


 **Steps to deploy new services to kubernetes** 


* create new jenkins jobs for build, artifcat upload and deploy


* create helm chart


* use exisiting jenkins file


* use exisiting ansible role(helm-deploy) and playbook




### Autoscaling of micro services and cluster
Deploy HPA  for  service and enable autoscaling on AKS cluster.

Sample HPA file: [https://github.com/project-sunbird/sunbird-devops/blob/release-5.1.0/kubernetes/helm_charts/core/content/templates/hpa.yaml](https://github.com/project-sunbird/sunbird-devops/blob/release-5.1.0/kubernetes/helm_charts/core/content/templates/hpa.yaml)  Same foramt can be used for all services.

Enable auto scaling on cluster using cli or azure console.


```
az aks update \
  --resource-group myResourceGroup \
  --name myAKSCluster \
  --enable-cluster-autoscaler \
  --min-count 1 \
  --max-count 3
```

### Cluster backup and Restore
Kubernetes cluster backup and restore using velero:  [https://github.com/project-sunbird/sunbird-devops/discussions/2112](https://github.com/project-sunbird/sunbird-devops/discussions/2112)


### Monitoring kubernetes cluster
Refer monitoring section for cluster monitoring [[Sunbird Monitoring|Sunbird-Monitoring]]


### Operations and maintenance
Known issues or Issues faced so far:


* AKS version upgrade - using velero or directly upgrade from azure console


* kube api deprication in upgraded version. (prometheus operators not working with upgraded AKS version)


* Service principal expiry -  Service principal credentials used to create AKS cluster got expired.


* Azure resources quota full -  if resource quota is full autoscaling wont work









*****

[[category.storage-team]] 
[[category.confluence]] 
