#  Jenkins Pipeline for Application Deployment

## **Objective**

### Create a Jenkins pipeline that automates the following processes: Build Docker image from Dockerfile in GitHub. Push image to Docker hub. Edit new image in deployment.yaml file. Deploy to k8s. Make any ‘Post action’ in your Jenkinsfile.

## **Steps:**

### **Prerequistes**
Before running this lab, ensure you have the following:
- **Operating System**: Ubuntu 24.04
Ensure you have the following files:
- `Dockerfile`
- `Jenkinsfile`
- `index.html`
- `deployment.yaml`
     
#### 1. Create pipeline on Jenkins

Click New Item -> Enter a name for the job -> Select Pipeline as the project type -> Click OK to create the job -> Configure the Pipeline Job: Select Pipeline script from SCM as the definition -> Set the SCM (Source Code Management) to Git: Under SCM, select Git ->
In the Repository URL field, enter the URL of GitHub repository (e.g., https://github.com/user/repository.git).

#### 2. Jenkinsfile 

1. Environment Variables:
- Defines environment variables for Docker Hub credentials, image details (name and tag), Kubernetes token, and the deployment YAML file.
2. Stage: 'Clone Repository':
- Action: Clones the repository from GitHub (specified branch main of https://github.com/mabuelmagdd/test.git).
- Purpose: Retrieves the source code from the repository to start the pipeline.
3. Stage: 'Build Docker Image':
- Action: Builds a Docker image using a Dockerfile in the repository, tagging it with the defined IMAGE_NAME and IMAGE_TAG.
- Purpose: Compiles the Docker image locally.
4. Stage: 'Push Docker Image to Docker Hub':
- Action: Logs into Docker Hub using stored credentials and pushes the built Docker image to Docker Hub with the specified tag.
- Purpose: Uploads the newly built image to Docker Hub so that it can be used in Kubernetes.
5. Stage: 'Update Deployment YAML':
- Action: Updates the image tag in the deployment.yaml file to the newly pushed image in Docker Hub.
- Purpose: Ensures the Kubernetes deployment uses the latest image.
6. Stage: 'Deploy to Minikube':
- Action: Exports the Kubernetes config, applies the updated deployment.yaml, and deploys the updated image to Minikube.
- Purpose: Deploys the new Docker image to a Kubernetes cluster (Minikube in this case).
7. Post Actions: Always:
- Action: Removes the Docker image locally from the Jenkins agent after the deployment is complete.
- Purpose: Cleans up local resources (Docker images) to free up space
 
 ```
 pipeline {
    agent any
    environment {
        DOCKER_HUB_CREDENTIALS = credentials('docker-hub-credentials')
        IMAGE_NAME = "nginx-test"
        IMAGE_TAG = "latest"  
        REGISTRY = "docker.io"
        DEPLOYMENT_FILE = "deployment.yaml"
        K8S_TOKEN = credentials('k8s-token')  // Token for Kubernetes authentication
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/mabuelmagdd/test.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -f Dockerfile -t ${REGISTRY}/${DOCKER_HUB_CREDENTIALS_USR}/${IMAGE_NAME}:${IMAGE_TAG} .'
                }
            }
        }

        stage('Push Docker Image to Docker Hub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh 'echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin'
                    }
                    sh 'docker push ${REGISTRY}/${DOCKER_HUB_CREDENTIALS_USR}/${IMAGE_NAME}:${IMAGE_TAG}'
                }
            }
        }

        stage('Update Deployment YAML') {
            steps {
                script {
                    sh "sed -i 's|image:.*|image: ${REGISTRY}/${DOCKER_HUB_CREDENTIALS_USR}/${IMAGE_NAME}:${IMAGE_TAG}|g' ${DEPLOYMENT_FILE}"
                }
            }
        }

        stage('Deploy to Minikube') {
            steps {
                script {
                    sh '''
                    export KUBECONFIG=~/.kube/config
                
                    # Apply the deployment file
                    kubectl apply -f ${DEPLOYMENT_FILE}
        
                    # Validate the deployment
                    #kubectl rollout status deployment/${IMAGE_NAME} --timeout=60s
                    '''
            }
        }
    }

    }

    post {
        always {
            script {
                sh 'docker rmi ${REGISTRY}/${DOCKER_HUB_CREDENTIALS_USR}/${IMAGE_NAME}:${IMAGE_TAG}'
            }
        }
    }
}
 ```
