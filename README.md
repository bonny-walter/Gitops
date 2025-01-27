# Githops

### Kubernetes is a container orchestration system for deployment, scaling, and management of containers.

### Basic Kubernetes objects are Pod, Service, and Volume.

### The Kubernetes control plane consists of kube-apiserver, kube-controller-manager, and kube-scheduler.

### Each Kubernetes worker node runs kubelet and kube-proxy.

### A Running Service in a Pod is accessible from your computer using kubectl port-forward.

### Pods can be deployed by using imperative or declarative syntax. 

### Imperative deployment is not idempotent, and declarative deployment is idempotent. 

### For GitOps, declarative is the preferred method.

### Controllers are the brains in Kubernetes to bring the Running state into thedesired state.

### A Kubernetes operator can be implemented simply as a shell script by monitoring ConfigMap changes and updating deployment.

### Kubernetes configuration is declarative.

### GitOps complements Kubernetes due to its declarative nature.

### GitOps operators trigger deployments to your Kubernetes cluster based on changes to revision-controlled configuration files stored in Git.

### A simple GitOps operator can be implemented as a script by regularly checking the manifest Git repo for changes.

### CI pipeline can be implemented as a script with steps to build the Docker image and update the manifest with the new image tag.
###########################################################################################################################
