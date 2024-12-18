#  Storage Configuration 

## **Objective**

### Make a Comparison between PV, PVC, and StorageClass

## **Steps:**

#### 1. Create a deployment named my-deployment with 1 replica using the NGINX image.


#### 2. Exec into the NGINX pod and create a file at /usr/share/nginx/html/hello.txt with the content thello, this is <your-name>, verify the file is served by NGINX using curl localhost/hello.txt


#### 3. Delete the NGINX pod and wait for the deployment to create a new pod, Exec into the new pod and verify the file at /usr/share/nginx/html/hello.txt is no longer present.


#### 4. Create a PVC and modify the deployment to attach the PVC to the pod at /usr/share/nginx/html. 


#### 5. Repeat the previous steps and Verify the file persists across pod deletions. 






