#  Network Configuration 

## **Objective**

### Build and expose a secure, accessible, and functional static website using Kubernetes

## **Steps:**

#### 1. Build a new Docker image from the Dockerfile
1. Clone the repository
```
git clone https://github.com/IbrahimmAdel/static-website.git
```
2. Navigate to the project directory
```
cd static-website
```
3. Build the Docker image
```
docker build -t static-website:latest .
```
4. Check if image was created 
```
docker images
```
#### 2. Push the Image to Docker Hub
1. Log in to Docker Hub
```
docker login
```
2. Tag image for Docker Hub
```
docker tag static-website:latest maryamabualmagd/static-website:latest
```
3. Push to Docker Hub
```
docker push maryamabualmagd/static-website:latest
```
#### 3. Create `deployment.yaml` file 
- Specify the image that was just pushed 
Create the deployment and check pods
```
kubectl apply -f deployment.yaml
kubectl get pods
```
#### 4. Create a Service (`service.yaml`) to Expose the Deployment
- A Service provides a stable, fixed endpoint to access the pods, even as they are replaced or rescheduled, the service type is `ClusterIP` that exposes the service only within the Kubernetes cluster.

Create the service and check for its presence
```
kubectl apply -f service.yaml
kubectl get service static-website-service
```

#### 5. Define a Network Policy 
- Kubernetes allows communication between all pods by default. This might not be secure, especially in production so, a NetworkPolicy resource restricts pod-to-pod communication based on rules, ensuring only authorized traffic flows between pods.
- This policy allows traffic to pods with the label `app: static-website` only from other pods in the same namespace

Create a file named `network-policy.yaml`
```
kubectl apply -f network-policy.yaml
kubectl get networkpolicy
```
#### 6. Enable the NGINX Ingress Controller
- An Ingress Controller handles HTTP/HTTPS traffic and allows you to use domain names to route traffic to different services.
- Ingress Controller: A pod (like NGINX) that implements the Kubernetes Ingress resource. It processes incoming traffic and forwards it to appropriate services.

1. Enable the addon to enable the Ingress controller in Minikube
```
minikube addons enable ingress
```
#### 6. Create an Ingress Resource
- An Ingress allows you to define rules for routing external traffic to services in the cluster.

Create a file named `ingress.yaml`
```
kubectl apply -f ingress.yaml
```
#### 7. Update /etc/hosts
1. Find the Minikube IP:
```
minikube ip
```
2. Edit /etc/hosts:
```
sudo nano /etc/hosts
#add this line 
<Minikube_IP> static-website.local
```
#### 8. Access the Service via the Ingress
For the domain name (static-website.local) to work, it needs to map to the Minikube IP address. This mapping allows your browser to resolve the domain to the correct cluster endpoint.
```
http://static-website.local
```




