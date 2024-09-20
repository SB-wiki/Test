# Knative

The Knative framework is built on top of Kubernetes and Istio which provide an Application revisions and advanced network routing

![](../../../../DevOps/FullExport/images/storage)

It includes two components:

1. Serving
2. Eventing

* \*\*Serving:  \*\* Knative Serving builds on Kubernetes and Istio to support deploying and serving of serverless applications and functions.&#x20;

![Diagram that displays how the Serving resources coordinate with each other.](../../../../DevOps/FullExport/images/storage)

* &#x20; \*\*Eventing: \*\*  Knative Eventing is a system that is designed to address a common need for cloud native development and provides composable primitives to enable late-binding event sources and event consumers.

&#x20;

### Benefits/Advantages

* Seamless autoscaling up and down to zero based on HTTP requests
* Gradual rollouts for new revisions (canary)
* Point-in-time snapshots of deployed code and configurations

### Hands-On:

Installing Knative

1. To install Knative, first install the CRDs by running the kubectl apply command once with the -l knative.dev/crd-install=true flag. This prevents race conditions during the install, which cause intermittent errors:

This will install both serving and eventing component, eventing depends on serving components but serving can be used independently.

To install only serving remove the second URL in below commands.

```
kubectl apply --selector knative.dev/crd-install=true \
--filename https://github.com/knative/serving/releases/download/v0.9.0/serving.yaml \
--filename https://github.com/knative/eventing/releases/download/v0.9.0/release.yaml

```

1. To complete the install of Knative and its dependencies, run the kubectl applycommand again, this time without the --selector flag, to complete the install of Knative and its dependencies:

```
 kubectl apply --filename https://github.com/knative/serving/releases/download/v0.9.0/serving.yaml \
   --filename https://github.com/knative/eventing/releases/download/v0.9.0/release.yaml
```

This will create 2 new namespaces for serving and eventing.

Deploying a simple application with Knative.Below link explains about to create a simple app deployment with Knative

[https://knative.dev/docs/serving/getting-started-knative-app/](https://knative.dev/docs/serving/getting-started-knative-app/)

Routing and managing traffic with blue/green deployment.Using knative we can achieve blue/green deployment which will help in doing Zero downtime deployment.

[https://knative.dev/docs/serving/samples/blue-green-deployment/](https://knative.dev/docs/serving/samples/blue-green-deployment/)

Autoscaling using knative.Knative supports autoscaling and by default it will scale down to zero if there is no requests.

Autoscaling can be done in knative based in number of requests, cpu usage.

[https://knative.dev/docs/serving/samples/autoscale-go/index.html](https://knative.dev/docs/serving/samples/autoscale-go/index.html)

***

\[\[category.storage-team]] \[\[category.confluence]]
