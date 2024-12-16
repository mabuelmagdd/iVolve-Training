# Deployment vs. StatefulSet

## **Objective**

### Make a Comparison between Deployment and StatefulSet. Create a YAML file for a MySQL StatefulSet configuration. Write a YAML file to define a service for the MySQL StatefulSet.

**Stateful vs Stateless**
 - Stateful applications are those that store data or maintain some form of state between sessions. These applications rely on persistent storage, unique identifiers, and ordered operations. For example, a banking application remembers your account balance and transactions because it needs to keep track of your financial history.
 - Stateless applications (with memory) do not retain any information or context between sessions. Each request is independent and does not rely on past interactions or data. For example, a website showing the same page to every user without remembering who they are or what they did before.

**Similarities Between Deployments and StatefulSets**
 - Pod Management: Both Deployments and StatefulSets manage a set of Pods (containers running your app).
 - Scaling: Both can scale the number of replicas (pods) up or down based on the desired number of instances.
 - Rolling Updates: Both support rolling updates for deploying new versions of your application without downtime.
 - Selector Matching: Both use selectors to match the Pods they manage with the specific labels defined in the spec.

**Deployment**
  - Statelessness: Ideal for stateless applications that do not require persistent storage. 
  - Replica Management: Ensures that the correct number of replicas is running.
  - Rolling Updates: Supports smooth, non-disruptive updates to Pods.
  - Self-healing: Automatically replaces failed pods to maintain the desired state.
  - No Stable Identity: Pods are not guaranteed a stable name or persistent identity across restarts.
  - Pod Identity: Each pod created by a Deployment is identical and interchangeable.

**StatefulSet**
  - Statefulness: Perfect for stateful applications that require persistent storage and a stable identity.
  - Stable Network Identity: Each pod has a unique, stable hostname (e.g., web-0, web-1).
  - Persistent Storage: StatefulSets can create PersistentVolumeClaims, so storage is attached to individual pods and persists across restarts.
  - Ordered Deployment: Pods are created and deleted in a defined order. This is important for applications like databases that require ordered startup and shutdown.
  - Graceful Termination: Pods are terminated one at a time and in order, to avoid service disruption.
  - Rolling Updates: StatefulSets allow for ordered, rolling updates to ensure that applications with dependencies are updated one at a time.

## **Steps:**

#### 1. Create a YAML file for a MySQL StatefulSet configuration. 
```
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: mysql
  labels:
    app: mysql
spec:
  serviceName: "mysql"
  replicas: 3  # We are creating 3 replicas of MySQL for high availability.
  selector:
    matchLabels:
      app: mysql
  template:
    metadata:
      labels:
        app: mysql
    spec:
      terminationGracePeriodSeconds: 10  # Grace period for termination of MySQL pods.
      containers:
        - name: mysql
          image: mysql:8.0  # MySQL Docker image version 8.0.
          ports:
            - containerPort: 3306  # MySQL default port.
          env:
            - name: MYSQL_ROOT_PASSWORD  # Environment variable for setting the root password.
              value: "rootpassword"
          volumeMounts:
            - name: mysql-data  # Mounting persistent storage for MySQL.
              mountPath: /var/lib/mysql  # MySQL stores its data here.
  volumeClaimTemplates:
    - metadata:
        name: mysql-data  # Define the PersistentVolumeClaim to create stable storage for each Pod.
      spec:
        accessModes: ["ReadWriteOnce"]
        storageClassName: "standard"  # Define the storage class for the persistent volume.
        resources:
          requests:
            storage: 1Gi  # Each MySQL pod will get 1Gi of storage.

```
- volumeClaimTemplates: This section is what makes StatefulSets special. For each Pod created by the StatefulSet, Kubernetes will automatically create a PersistentVolumeClaim (PVC) based on the template. This ensures that each Pod has its own persistent storage, even if the Pod is rescheduled.
- metadata.name: The name of the PersistentVolumeClaim that will be generated. In this case, it’s called mysql-data. Kubernetes will create a separate PVC for each Pod, e.g., mysql-0-mysql-data, mysql-1-mysql-data, etc.
- spec.accessModes: The access mode defines how the PersistentVolume can be accessed by Pods. In this case, ReadWriteOnce means the volume can only be mounted by one Pod at a time (i.e., the MySQL instance).
- storageClassName: Specifies the StorageClass to use for creating PersistentVolumes. The standard class is typically the default in most Kubernetes setups, but it could vary based on your environment.
- resources.requests.storage: This specifies the amount of storage that each Pod's PVC will request. Here, each MySQL instance will request 1Gi of storage. You can adjust this value based on your application needs.

#### 2. Write a YAML file to define a service for the MySQL StatefulSet.
```
apiVersion: v1
kind: Service
metadata:
  name: mysql
  labels:
    app: mysql
spec:
  ports:
    - port: 3306  
      name: mysql
  clusterIP: None  
  selector:
    app: mysql  
```

#### 3. Test 
```
kubectl get pods

```
```
kubectl get pvc

```

