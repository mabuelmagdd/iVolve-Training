# Updating Applications and Rolling Back Changes

## **Objective**

###  Deploy NGINX with 3 replicas. Create a service to expose NGINX deployment and use port forwarding to access NGINX service locally. Update NGINX image in the deployment to Apache image. View deployment's rollout history. Roll back NGINX deployment to the previous image version and Monitor pod status to confirm successful rollback.

## **Steps:**

### **Prerequistes**
Ensure the following files are present:
   - `nginx-deployment.yaml`
   - `nginx-service.yaml`
   - `nginx-update-image.yaml`
#### 1. Deploy NGINX with 3 replicas. 
This command creates a dry-run simulation of the NGINX deployment with 3 replicas and outputs the YAML configuration to the file nginx-deployment.yaml
```
kubectl create deployment nginx --image=nginx --replicas=3 --dry-run=client -o yaml > nginx-deployment.yaml
```
Check the generated YAML file:
```
cat nginx-deployment.yaml
```
Apply the YAML to create the deployment:
```
kubectl apply -f nginx-deployment.yaml
```
![image](https://github.com/user-attachments/assets/2480247c-edb6-4af2-a5c2-823c62f99f65)

#### 2. Create a service to expose NGINX deployment and use port forwarding to access NGINX service locally.
 This command creates a dry-run simulation of a Kubernetes service that exposes the NGINX deployment on port 80 and outputs the YAML configuration to the file nginx-service.yaml.
 ```
 kubectl expose deployment nginx --port=80 --target-port=80 --name=nginx-service --dry-run=client -o yaml > nginx-service.yaml
 ```
 Check the generated YAML file:
```
cat nginx-deployment.yaml
```
Apply the YAML to create the deployment:
```
kubectl apply -f nginx-service.yaml
```
#### 3. Use Port Forwarding to Access the NGINX Service Locally
This command forwards port 9090 on your local machine to port 80 on the nginx-service running in Kubernetes.
```
 kubectl port-forward service/nginx-service 9090:80
```
access the NGINX service locally via the browser

![image](https://github.com/user-attachments/assets/17d30de0-7cc9-4780-9d3a-0e53558a4aa7)

#### 4. Update NGINX Image to Apache 
This command simulates updating the nginx deployment with the httpd:latest (Apache) image and outputs the changes to a YAML file.
```
kubectl set image deployment/nginx nginx=httpd:latest --dry-run=client -o yaml > nginx-update-image.yaml
```
Apply the YAML to update the deployment:
```
kubectl apply -f nginx-update-image.yaml
```
#### 5. Update NGINX Image to Apache
This command shows the revision history of the nginx deployment, including the changes made to the deployment (e.g., the change from NGINX to Apache).
```
kubectl rollout history deployment/nginx
```
#### 6. Roll Back NGINX Deployment to the Previous Image Version
This command rolls back the deployment to the previous revision (i.e., the NGINX image before the update).
```
kubectl rollout undo deployment/nginx
```
#### 7. Test
Check the pods after rollback:
```
kubectl get pods
```
![image](https://github.com/user-attachments/assets/546c72f4-af9d-40a6-acba-933401fffec7)



