#  Configuring a MySQL Pod using ConfigMap and Secret 

## **Objective**

### Configure and secure application environments within Kubernetes, leveraging ConfigMaps and Secrets for configuration management, along with resource quotas to manage pod resources effectively.

## **Steps:**

#### 1. Create the Namespace
1. Create namespace
```
kubectl create namespace ivolve
```
2. Switch to `ivolve` namespace 
```
kubectl config set-context $(kubectl config current-context) --namespace=ivolve
```

#### 2. Create Resource Quota
- A ResourceQuota is a Kubernetes object that allows you to limit the total resources (like CPU, memory, or the number of pods) that can be consumed by all resources within a specific namespace.
- Create `quota.yaml` file
```
apiVersion: v1
kind: ResourceQuota
metadata:
  name: pod-quota
  namespace: ivolve
spec:
  hard:
    pods: "2"
```
#### 3. Create a MySQL ConfigMap 
Create `configmap.yaml` file
```
apiVersion: v1
kind: ConfigMap
metadata:
  name: mysql-config
  namespace: ivolve
data:
  MYSQL_DATABASE: database
  MYSQL_USER: user
```
#### 4. Create a MySQL Secret
1. Encode password 
```
echo -n 'maryam' | base64
```
2. Create `secret.yaml` file
```
apiVersion: v1
kind: Secret
metadata:
  name: mysql-secret
  namespace: ivolve
type: Opaque
data:
  MYSQL_ROOT_PASSWORD: <encoded-pass> 
  MYSQL_PASSWORD: <encoded-pass>   
```

#### 5. Create the MySQL Deployment
Create `deployment.yaml` file
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mysql
  namespace: ivolve
spec:
  replicas: 3
  selector:
    matchLabels:
      app: mysql
  template:
    metadata:
      labels:
        app: mysql
    spec:
      containers:
      - name: mysql
        image: mysql:5.7
        envFrom:
        - configMapRef:
            name: mysql-config
        - secretRef:
            name: mysql-secret
        resources:
          requests:
            memory: "1Gi"
            cpu: "500m"
          limits:
            memory: "2Gi"
            cpu: "1"
        ports:
        - containerPort: 3306  
```
#### 6. Apply the YAML Files
```
kubectl apply -f quota.yaml
kubectl apply -f configmap.yaml
kubectl apply -f secret.yaml
kubectl apply -f deployment.yaml

```
#### 7. Verify 
1. Check the deployment and pods:
```
kubectl get pods 
kubectl get deployment
```
One pod should be unavailable due to the resource quota.
![image](https://github.com/user-attachments/assets/f9979c3e-7fa7-4ce1-b322-90474d1e6d8c)

2.Exec into a running MySQL pod to verify the configurations 
```
kubectl exec -it $POD_NAME -n ivolve -- bash
mysql -u user -p
# enter password
```
3. Once inside the pod, connect to MySQL
```
SHOW DATABASES;
```
![image](https://github.com/user-attachments/assets/7d7d3b17-3c6b-47e6-9361-5527673eafad)





