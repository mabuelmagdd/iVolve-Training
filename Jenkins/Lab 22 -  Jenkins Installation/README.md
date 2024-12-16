#  Jenkins Installation

## **Objective**

### Install Jenkins and connect with Minikube 

## **Steps:**

### **Prerequistes**
Before running this lab, ensure you have the following:
- **Operating System**: Ubuntu 24.04
- Make sure that the latest version of docker is installed
     

#### 1. Install Jenkins 

```
# Update package index
sudo apt update

# Install OpenJDK 17
sudo apt install openjdk-17-jdk -y

# Verify Java installation
java -version

# Add Jenkins repository key
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null

# Add Jenkins repository to sources.list
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# Update package index again
sudo apt update

# Install Jenkins
sudo apt install jenkins -y

# Start Jenkins service
sudo systemctl start jenkins

# Enable Jenkins to start on boot
sudo systemctl enable jenkins

# Allow port 8080 through the firewall
sudo ufw allow 8080
```

#### 2. Install Minikube
 ```
 sudo snap install kubectl --classic

 wget https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 -O minikube

 chmod 755 minikube

 sudo mv minikube /usr/local/bin/

 # verify installation
 minikube start --memory=4096 --cpus=2 --driver=docker --flannel=cni

 #check status
 minikube status
 ```
#### 3. Alow to Jenkins to access cluster bu creating a service account

```
kubectl create serviceaccount jenkins

kubectl create clusterrolebinding jenkins-admin --clusterrole=admin --serviceaccount=default:jenkins

kubectl create secret generic jenkins-token --from-literal=token=$(kubectl create token jenkins) --namespace=default

kubectl get secret jenkins-token -o jsonpath='{.data.token}' | base64 --decode
```
Copy this token and add as credential in jenkins. 

#### 4. Use the Kubernetes config file (~/.kube/config) directly from the Jenkins user (without uploading it to Jenkins as a file credential)

```
#login as jenkins user
sudo -i -u jenkins

#Verify the Kubernetes config file exists
ls -l ~/.kube/config

#Add Permissions to Access the Kubernetes Cluster
sudo chmod 600 ~jenkins/.kube/config
```
#### 5. HoW to use in pipeline

```
stage('Deploy to Minikube') {
    steps {
        script {
            sh '''
            export KUBECONFIG=~/.kube/config

            # Apply the deployment file
            kubectl apply -f ${DEPLOYMENT_FILE}

            # Validate the deployment
            kubectl rollout status deployment/${IMAGE_NAME} --timeout=60s
            '''
        }
    }
}
```
#### 6. Test pipeline access 

```
sudo -i -u jenkins
export KUBECONFIG=~/.kube/config
kubectl get nodes
```



