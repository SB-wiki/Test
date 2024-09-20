# Jenkins-X-and-Tekton

#### Jenkins X provides pipeline automation, built-in GitOps, and preview environments to help teams collaborate and accelerate their software delivery at any scale

#### Pros:

* End to End CI / CD integration including pushing images to registry, artifacts to Nexus
* Full integration with Github
* Full integration with GitOps to create and manage environments
* Support for preview environments for pull requests using Knative (Optional - Comes bundled with Jenkins X if required)
* Can create and update helm charts after a build and and deploy and auto commit to repository
* Internally translates all CI / CD pipelines to tekton pipelines
* A promising tool - Jenkins + Tekton with a highly active community backed by big organizations
* Artifact promotion to various environments based on criterias set by us

Cons:

* Very minimal UI - Unlike the traditional Jenkins
* Command line based approach
* Mainly intended for container build and deployment but can support other types of artifacts with self customizations
* Rewrite Jenkinsfiles to match Jenkins X code syntax
* Lots of tweaking and changes required in build and deployment strategy to make it work for our use case
* Requires at least 3 nodes in cluster to handle the Jenkins master, other dependent components and worker pods

**Jenkins X Typical Workflow** ![](../../../../DevOps/devops-kn-hw2/images/storage)

**Jenkins X Typical Workflow - Detailed**

![](../../../../DevOps/devops-kn-hw2/images/storage)

**Jenkins X Components**

![](../../../../DevOps/devops-kn-hw2/images/storage)

***

\[\[category.storage-team]] \[\[category.confluence]]
