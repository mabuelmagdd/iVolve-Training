#  Helm Chart Deployment 

## **Objective**

### Create a new Helm chart for Nginx. Deploy the Helm chart and verify the deployment. Access the Nginx server. Delete nginx release.
![image](https://github.com/user-attachments/assets/635cf861-85a6-42ba-8447-aff641ce0a53)

**What is Helm?**
Helm is a package manager for Kubernetes that helps you manage complex applications in a Kubernetes cluster by simplifying the process of deploying, updating, and managing apps. It allows you to easily define, install, and upgrade applications, much like how a package manager like apt or yum works for operating systems.

**Key Concepts in Helm:**
- Helm Charts: Pre-configured templates for Kubernetes resources.
- Release: A deployment instance of a Helm chart.
- Repositories: Where Helm charts are stored and shared (like Docker Hub but for Helm charts).
- Values: Configuration options for customizing a chart.
## **Steps:**

#### 1. Install Helm
1. Install Helm 
```
sudo snap install helm --classic
```
2. Verify Installation 
```
helm version
```
#### 2. Create a New Helm Chart for Nginx
1. Create `quota.yaml` file
```
helm create nginx-chart
```
Navigate to chart directory
```
cd nginx-chart
```
Check the default files:
- `Chart.yaml`: Metadata about the chart.
- `values.yaml`: Configurable parameters.
- `templates/`: Kubernetes manifests.
2. Deploy the Helm Chart
```
helm install nginx-release ./nginx-chart
```
3. Verify deployment 
```
kubectl get pods
kubectl get services
```
![image](https://github.com/user-attachments/assets/cf599df2-4ae5-47d2-98b3-e6335e600f8b)

![image](https://github.com/user-attachments/assets/ae4582c7-ac63-4195-8bef-15950cc91299)

- if the service is of type `ClusterIP`, edit svc to change it to `NodePort`
```
kubectl edit svc nginx-release
```
![image](https://github.com/user-attachments/assets/ff5b64b7-397b-4e0c-b84f-6ab9cf4f5ee3)

4. Get Minikube IP and Access the Service
```
minikube ip
# get port 
kubectl get svc nginx-release
```
5. Open the browser and navigate to
```
http://<minikube-ip>:<service-port>
```
![image](https://github.com/user-attachments/assets/43e239de-ac62-4fb3-b60a-c54a132f0c49)

- If it's not accessible
```
minikube tunnel
```
This command runs in the background and exposes the services, allowing you to access them using the Minikube IP without needing to manually find the port.

![image](https://github.com/user-attachments/assets/39cd3c60-a282-4027-bb05-3785e60f166a)

#### 3. Delete the Nginx Release
1. Uninstall the deployment
```
helm uninstall nginx-release
```
2. Verify the removal
```
kubectl get all
```


