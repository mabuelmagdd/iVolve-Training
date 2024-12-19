#  DMulti-container Applications 

## **Objective**

### This lab focuses on managing node-specific configurations, ensuring efficient resource utilization, and controlling pod scheduling in a Kubernetes cluster.

#### Init Container vs. Sidecar Container
**Init Container**
- Init containers are designed to run before the main application container starts.
- They ensure some pre-requisites are met (e.g., downloading configuration files or waiting for other services).

| **Aspect**       | **Init Container**                                         | **Sidecar Container**                                   |
|-------------------|-----------------------------------------------------------|--------------------------------------------------------|
| **Purpose**       | Prepares the environment before the main container starts.| Works alongside the main container to extend functionality. |
| **Lifetime**      | Runs once and exits before the app starts.                | Runs concurrently with the main container.            |
| **Examples**      | Setup configurations, wait for dependencies.              | Logging, monitoring, proxies.                         |

---

#### Readiness Probe vs. Liveness Probe

| **Aspect**       | **Readiness Probe**                  | **Liveness Probe**                |
|-------------------|--------------------------------------|------------------------------------|
| **Purpose**       | Ensures the app is ready to serve traffic. | Ensures the app is alive and running. |
| **When Used?**    | Before starting to accept traffic.   | Continuously during the container's lifetime. |
| **Action on Failure** | Traffic is not routed.               | Container is restarted.            |

## **Steps:**

#### 1. Create Deployment YAML for Jenkins with Init Container
1. Apply the yaml file 
```
kubectl apply -f deployment.yaml
```
**Explanation**:
1. **Init Container:**
- The busybox image runs a command to sleep for 10 seconds before Jenkins starts.
- Useful in real-world scenarios where you need to wait for dependencies like a database.

2. **Main Jenkins Container:**
- Uses the official Jenkins image.
- `readinessProbe`: Checks if Jenkins is ready to serve traffic by pinging the `/login` endpoint.
- `livenessProbe`: Ensures Jenkins is running and healthy.

#### 2. Create NodePort Service to Expose Jenkins
1. Apply the Pod YAML
```
kubectl apply -f service.yaml
```
**Explanation:**
- Exposes Jenkins on NodeIP:30000.
- Traffic on port 30000 on the node is forwarded to Jenkins' port 8080
**Not:**
Since Jenkins is already running on port 8080, add this to the `deployment.yaml` file:
- The `JENKINS_OPTS` environment variable is a common way to pass command-line arguments to Jenkins when it starts. These arguments control various runtime configurations for the Jenkins server.
- `--httpPort=8081`: This argument tells Jenkins to start its HTTP server on port 8081 instead of the default 8080
```
 env:
        - name: JENKINS_OPTS
          value: --httpPort=8081 
```
#### 3. Verify the Deployment
1. Verify the Deployment
Ensure the init container completes successfully, and Jenkins starts.
```
kubectl get pods
```
2. Access Jenkins
- Find Node's IP using:
```
kubectl get nodes -o wide
```
- Open http://<Node-IP>:30000 in a browser.
