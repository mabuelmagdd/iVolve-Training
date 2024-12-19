#  Daemonsets & Taint and Toleration

## **Objective**

### This lab focuses on managing node-specific configurations, ensuring efficient resource utilization, and controlling pod scheduling in a Kubernetes cluster.
**What is a DaemonSet?**

A DaemonSet ensures that all (or some) Nodes run a copy of a Pod. As nodes are added to the cluster, Pods are added to them. As nodes are removed from the cluster, those Pods are garbage collected. Deleting a DaemonSet will clean up the Pods it created.
In Kubernetes, a DaemonSet is named after the concept of a daemon because it is responsible for running specific pods on each node in the cluster to perform background tasks or provide essential services.
- Some typical uses of a DaemonSet are:
   - running a cluster storage daemon on every node
   - running a logs collection daemon on every node
   - running a node monitoring daemon on every node
- `kube proxy` on each node that handles network communication within the cluster can be deployed as a DaemonSet.

**Comparison between Taint & Toleration & Node Affinity**


| **Aspect**            | **Taint & Toleration**                                               | **Node Affinity**                                               |
|------------------------|----------------------------------------------------------------------|-----------------------------------------------------------------|
| **Purpose**           | Controls which pods are **repelled** or allowed on specific nodes.  | Controls which nodes a pod **prefers** or is required to run on. |
| **Mechanism**         | Uses taints on nodes and tolerations on pods to match or repel.     | Uses node labels and affinity rules defined in the pod spec.   |
| **Effect**            | Actively **prevents** pods without matching tolerations from scheduling on tainted nodes. | Passively **guides** or enforces pod placement based on preferences or requirements. |
| **Use Case**          | Ensuring only specific workloads (e.g., system-level pods) run on a node, such as GPU nodes or critical workloads. | Assigning pods to specific nodes based on hardware, location, or other labels. |
| **Configuration**     | - Add a **taint** to a node using `kubectl taint`.                  | - Use `nodeSelector` or `nodeAffinity` in the pod spec.         |
|                        | - Add a **toleration** to a pod in its spec to match the taint.    |                                                               |
| **Flexibility**        | More restrictive: Nodes repel pods by default unless toleration exists. | More flexible: Allows both **soft (preferred)** and **hard (required)** placement rules. |
| **Examples**           | - Taint: `kubectl taint nodes <node-name> key=value:NoSchedule`.   | - Node Affinity: Match pods with `preferredDuringSchedulingIgnoredDuringExecution` or `requiredDuringSchedulingIgnoredDuringExecution`. |

**Key Differences**
- **Taints & Tolerations** are used to **exclude pods** from nodes unless they explicitly tolerate the taint.
- **Node Affinity** is used to **direct pods** toward nodes that match specific criteria but doesn’t exclude them by default.

**When to Use**
- **Taints & Tolerations**: Use for strict exclusion of workloads (e.g., isolating nodes for specific tasks or hardware).
- **Node Affinity**: Use for guiding workloads to specific nodes based on preferences or requirements.

## **Steps:**

#### 1. Create a DaemonSet for Nginx
1. Apply the yaml file 
```
kubectl apply -f daemonset.yaml
```
2. Verify the DaemonSet pods
You will see one Nginx pod running on each node in your cluster.
```
kubectl get pods -o wide
```
#### 2. Taint the Node
1. Taint the Minikube Node
This adds a taint to the Minikube node, preventing pods without the proper toleration from being scheduled.
```
kubectl taint nodes minikube color=red:NoSchedule
```
#### 3. Create a Pod with Toleration
1. Apply the Pod YAML
```
kubectl apply -f toleration-pod.yaml
```
2. Check the Pod Status
The pod will remain in a Pending state because it does not have a toleration matching the taint (color=red).
```
kubectl get pods
```
#### 4. Update Toleration to Match the Taint
1. Edit the Pod YAML to Tolerate the Taint
```
kubectl edit -f toleration-pod.yaml
```
2. Apply the Updated YAML
```
kubectl apply -f toleration-pod.yaml
```
3. Check the Pod Status
The pod will now be scheduled and run on the Minikube node.
```
kubectl get pods
```

