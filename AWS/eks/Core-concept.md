# Architecture
### Master Node:
- kube-apiserver:
  + It acts as `front end` for the Kubernetes control plane. It `exposes` the Kubernetes API
  + Command line tools (like kubectl), Users and even Master components (scheduler, controller manager, etcd) and Worker node components like (Kubelet) `everything talk` with API Server
- etcd:
  + Consistent and highly-available `key value store` used as Kubernetes’ `backing store` for all cluster data
  + It `stores` all the masters and worker node information
- kube-scheduler:
  + Scheduler is responsible for distributing containers across multiple nodes
  + It watches for newly created Pods with no assigned node, and selects a node for them to run on
- kube-controller-manager:
  + Controllers are responsible for noticing and responding when nodes, containers or endpoints go down. They make decisions to bring up new containers in such cases
  + `Node Controller`: Responsible for noticing and responding when `nodes go down`
  + `Replication Controller`: Responsible for maintaining the `correct number of pods` for every replication controller object in the system
  + `Endpoints Controller`: `Populates` the Endpoints object (that is, joins Services & Pods)
  + `Service Account & Token Controller`: Creates default accounts and API Access for `new namespaces`
- cloud-controller-manager
  + A Kubernetes control plane component that embeds `cloud-specific control logic`.
  + It only runs controllers that are `specific` to your cloud provider.
  + `On-Premise` Kubernetes clusters will not have this component.
  + `Node controller`: For `checking` the cloud provider to determine if a node has been deleted in the cloud after it stops responding
  + `Route controller`: For setting up `routes` in the underlying cloud infrastructure
  + `Service controller`: For creating, updating and deleting cloud provider `load balancer`
### Worker Nodes
- Kubelet
  + Kubelet is the `agent` that runs on every node in the cluster
  + This agent is `responsible` for making sure that containers are running in a Pod on a node
- Kube-Proxy
  + It is a `network proxy` that runs on each node in your cluster.
  + It maintains `network rules` on nodes
  + In short, these network rules allow network communication to your Pods from network sessions inside or outside of your cluster
-  Container Runtime
  + Container Runtime is the `underlying software` where we run all these Kubernetes components
  + We are using Docker, but we have other runtime options like rkt, container-d etc.

### Pod
- With Kubernetes our core goal will be to `deploy our applications` in the form of `containers` on `worker nodes` in a k8s cluster.
- Kubernetes `does not` deploy containers directly on the worker nodes.
- Container is `encapsulated` in to a Kubernetes Object named POD.
- A POD is a `single instance` of an application.
- A POD is the `smallest object` that we can create in Kubernetes.
- PODs generally have `one to one` relationship with containers.
- To scale up we `create` new POD and to scale down we `delete` the POD.
- We cannot have multiple containers of same kind in a single POD.
- Example: Two NGINX containers in single POD serving same purpose is not recommended.

### Multi-Container Pods
- We can have multiple containers in a single POD, provided `they are not of same kind`.
- Helper Containers (Side-car)
  + `Data Pullers`: Pull data required by Main Container
  + `Data pushers`: Push data by collecting from main container (logs)
  + `Proxies`: Writes static data to html files using Helper container and Reads using Main Container.
- Communication
  + The two containers can easily communicate with each other easily as they share same `network space`.
  + They can also easily share `same storage space`.
- Multi-Container Pods is a `rare use-case` and we will try to focus on core fundamentals.

### Services - NodePort
- We can `expose an application` running on a set of `PODs` using different types of Services available in k8s.
  + ClusterIP
  + NodePort
  + LoadBalancer
- NodePort Service
  + To access our application `outside of k8s cluster`, we can use NodePort service.
  + Exposes the Service on each `Worker Node's IP` at a static port (nothing but NodePort).
  + A `ClusterIP` Service, to which the `NodePort` Service routes, is `automatically` created.
  + Port Range `30000-32767`
### ReplicaSets
- Feature:
  + High Availability or Reliability
  + Scaling
  + Load Balancing
  + Labels & Selectors
- A ReplicaSet’s purpose is to maintain a `stable set of replica Pods` running at any given time
- If our `application crashes (any pod dies)`, replicaset will `recreate` the pod immediately to ensure the configured number of pods running at any given time
- Load Balancing
  + To avoid overloading of traffic to single pod we can use `load balancing`.
  + Kubernetes provides pod load balancing `out of the box` using `Services` for the pods which are part of a ReplicaSet
  + `Labels & Selectors` are the `key items` which `ties` all 3 together (Pod, ReplicaSet & Service), we will know in detail when we are writing YAML manifests for these objects
- Scaling
  + When load become too much for the number of existing pods, Kubernetes enables us to easily `scale` up our application, adding additional pods as needed.
  + This is going to be `seamless and super quick`
  
### Deployment
- Feature:
  + Create a Deployment to rollout a ReplicaSet
  + Updating the Deployment
  + Rolling Back a Deployment
  + Scaling a Deployment
  + Pausing and Resuming a Deployment
  + Deployment Status
  + Clean up Policy
  + Canary Deployments

### Services
- ClusterIP: Used for communication between applications inside k8s cluster
>Example: Frontend application accessing backend application

- NodePort: Used for accessing applications outside of of k8s cluster using Worker Node Ports
>Example: Accessing Frontend application on browser

- LoadBalancer: Primarily for Cloud Providers to integrate with their Load Balancer services
>Example: AWS Elastic Load Balancer

- Ingress: Ingress is an advanced load balancer which provides Context path based routing, SSL, SSL Redirect and many more
>Example: AWS ALB

- externalName: o access externally hosted apps in k8s cluster
>Example: Access AWS RDS Database endpoint by application present inside k8s cluster

# EKS Storage
- In-Tree EBS Provisioner
  + Legacy
  + Will be deprecated soon
- `EBS CSI Driver`, `EFS CSI Driver`, `FSx for Luster CSI`
  + CSI means Container Storage Interface
  + Latest & Greatest available today & in Beta release & ready for production use
  + As on today, not supported on AWS EKS Fargate (Serverless)
  + Allows EKS Clusters to manage lifecycle of EBS Volumes for persistent storage, EFS File systems & FSx for Luster File systems
  + Supported for k8s 1.14 & later
  + Supported for k8s 1.16 &later

### AWS Elastic Block Store
- EBS provides `block level storage volumes` for use with `EC2 & Container instances`.
- We can mount these `volumes as devices` on our EC2 & Container instances.
- EBS volumes that are attached to an instance are `exposed as storage volumes that persist independently` from the life of the EC2 or Container instance.
- We can `dynamically change` the configuration of a volume attached to an instance.
- AWS recommends EBS for data that must be `quickly accessible` and requires `long-term persistence`.
- EBS is well suited to both `database-style applications` that rely on random reads and writes, and to `throughput-intensive applications` that perform long, continuous reads and writes.

# Important k8s Concepts for Application Deployments
### Probes
- Liveness Probe
  + Kubelet uses liveness probes to know `when to restart a container`
  + Liveness probes could catch a `deadlock`, where an application is running, but unable to make progress and `restarting container` helps in such state
- Readiness Probe
  + Kubelet uses readiness probes to know `when a container is ready to accept traffic`
  + When a Pod is not ready, it is `removed` from Service load balancers based on this `readiness probe signal`.
- Startup Probe
  + Kubelet uses startup probes to know when `a container application has started`
  + Firstly this proble `disables` liveness & readiness checks until it `succeeds` ensuring those pods don’t interfere with app startup.
  + This can be used to adopt liveness checks on `slow starting containers`, avoiding them getting killed by the kubelet before they are up and running
- Options to define Probes:
  + Check using Commands
  + Check using HTTP GET Request
  + Check using TCP
  + `/bin/sh -c nc -z localhost 8095`
  + `http get path:/health-status`
  + `tcpSocket Port: 8095`

### Namespaces
- Namespaces are also called `Virtual clusters` in our `physical` k8s cluster
- We use this in environments where we have `many users spread` across multiple teams or projects
- Clusters with `tens of users` ideally don’t need to use namespaces
- Benefits
  + Creates `isolation boundary` from other k8s objects
  + We can limit the resources like `CPU, Memory` on per namespace basis (`Resource Quota`)

# Microservices
- Microservices - also known as the microservice architecture - is an architectural style that structures an application as a collection of services that are
  + Highly maintainable and testable
  + Loosely coupled
  + Independently deployable
  + Organized around business capabilities
  + Owned by a small team

### Microservices - Benefits
- Developer independence: Small teams work in parallel and can iterate `faster` than large teams.
- Isolation and resilience: If a `component dies`, you spin up another while and the rest of the application continues to function.
- Scalability: Smaller components take up fewer resources and can be scaled to meet `increasing demand` of that component only.
- Lifecycle automation: Individual components are easier to fit into `continuous delivery pipelines` and complex deployment scenarios not possible with monoliths.
- Relationship to the business: Microservice architectures are split along business domain boundaries, increasing independence and understanding across the organization

# Microservices Distributed Tracing
### AWS X-Ray
- AWS X-Ray helps `analyse and debug` distributed applications built using microservices architecture.
>AWS X-Ray giúp phân tích và gỡ lỗi các ứng dụng phân tán được xây dựng bằng kiến ​​trúc vi dịch vụ.

- With X-Ray, we can `understand` how our application and its underlying services are performing to `identify and troubleshoot` the root cause of performance issues and errors.
>Với X-Ray, chúng tôi có thể hiểu ứng dụng của chúng tôi và các dịch vụ cơ bản của nó đang hoạt động như thế nào để xác định và khắc phục nguyên nhân cốt lõi của các vấn đề và lỗi về hiệu suất.

- X-Ray provides an `end-to-end view` of requests as they travel through our application and `shows a map` of our application’s underlying components.
>X-Ray cung cấp chế độ xem từ đầu đến cuối về các yêu cầu khi chúng di chuyển qua ứng dụng của chúng tôi và hiển thị bản đồ về các thành phần cơ bản của ứng dụng của chúng tôi

- We can also use X-Ray to analyse applications in `development and in production`, from simple three-tier applications to `complex microservices applications consisting of thousands of services`.
>Chúng tôi cũng có thể sử dụng X-Ray để phân tích các ứng dụng trong quá trình "phát triển và sản xuất", từ các ứng dụng ba tầng đơn giản đến "các ứng dụng vi dịch vụ phức tạp bao gồm hàng nghìn dịch vụ".

### AWS X-Ray - Benefits
- Review request behavior
- Discover application issues
- Improve application performance
- Ready to use with AWS
- Designed for a variety of applications

# DaemonSets
- A `DaemonSet` ensures that all (or some) Nodes run a copy of a Pod.
  + As nodes are `added` to the cluster, Pods are added to them.
  + As nodes are `removed` from the cluster, those Pods are garbage collected.
  + `Deleting` a DaemonSet will clean up the Pods it created.
- Some typical uses of a DaemonSet are:
  + running a `logs collection daemon` on every node (Example: fluentd)
  + running a `node monitoring daemon` on every node (Example: cloudwatchagent)
  + running an `application trace collection daemon` on every node (Example: AWS X-Ray)
- In a `simple case`, one DaemonSet, covering all nodes, would be used for each type of daemon.
- A `more complex setup` might use `multiple DaemonSets for a single type of daemon`, but with different flags and/or different memory and cpu requests for different hardware types

# Microservices Canary Deployments
- Canaries means `incremental` rollouts
- With canaries, the `new version` of the application is slowly deployed to the Kubernetes cluster while getting a very small amount of `live traffic`
- In short, `a subset of live users` are connecting to the `new version` while the rest are still using the `previous version`
- Using canaries, we can detect `deployment issues very early` while they effect only a small subset of users
- If we `encounter any issues with a canary`, the production version is still present, and `all traffic can simply be reverted to it`.

# Horizontal Pod Autoscaler – HPA
- In a very simple note Horizontal Scaling means `increasing and decreasing` the number of `Replicas (Pods)`
- HPA `automatically scales` the number of pods in a deployment, replication controller, or replica set, stateful set based on that resource's `CPU utilization`.
- This can help our applications `scale out to meet increased demand` or `scale in when resources are not needed`, thus freeing up your worker nodes for other applications.
- When we set a `target CPU utilization percentage`, the HPA scales our application in or out to try to meet that target.
- HPA needs `Kubernetes metrics server` to verify CPU metrics of a pod.
- We `do not need `to deploy or `install the HPA` on our cluster to begin scaling our applications, its out of the box available as a default Kubernetes API resource.

### Horizontal Pod Autoscaler – How to work
- Step 1: Query for Metrics from metrics server - `This control loop is executed every 15 seconds`
- Step 2: Calculate the Replica’s
- Step 3: Scale the app to desired replicas

### Horizontal Pod Autoscaler – HPA Configured
- HPA requires:
  + Scaling Metric: CPU Utilization
  + Target Value - CPU = 50%
  + Min Replicas = 2
  + Max Replicas = 1
> # kubectl autoscale deployment demo-deployment --cpu-percent=50 --min=1 --max=10

# Vertical Pod Autoscaler
• VPA automatically adjusts the CPU and memory reservations for our
pods to help "right size" our applications.
• This adjustment can improve cluster resource utilization and free up
CPU and memory for other pods.
• Benefits
• Cluster nodes are used efficiently, because Pods use exactly what they need.
• Pods are scheduled onto nodes that have the appropriate resources
available.
• We don't have to run time-consuming benchmarking tasks to determine the
correct values for CPU and memory requests.
• Maintenance time is reduced, because the autoscaler can adjust CPU and
memory requests over time without any action on your part.
