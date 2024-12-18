#  Storage Configuration 

## **Objective**

### Make a Comparison between PV, PVC, and StorageClass

## **Steps:**

#### 1. Create a deployment named my-deployment with 1 replica using the NGINX image.

![image](https://github.com/user-attachments/assets/63e2af5c-678e-4adc-9b03-f39af6c58b3b)
![image](https://github.com/user-attachments/assets/cf123ccd-ae38-42f8-b823-ae7f30ba64aa)

#### 2. Exec into the NGINX pod and create a file at /usr/share/nginx/html/hello.txt with the content thello, this is <your-name>, verify the file is served by NGINX using curl localhost/hello.txt
![image](https://github.com/user-attachments/assets/9b35d174-8863-4b13-b668-3b137062bcbf)

#### 3. Delete the NGINX pod and wait for the deployment to create a new pod, Exec into the new pod and verify the file at /usr/share/nginx/html/hello.txt is no longer present.
![image](https://github.com/user-attachments/assets/f2c1ca4c-8736-4061-9bdf-af054c3ab743)

#### 4. Create a PVC and modify the deployment to attach the PVC to the pod at /usr/share/nginx/html. 
![image](https://github.com/user-attachments/assets/89005d79-4443-4367-8cf8-5a6a09840c8b)
![image](https://github.com/user-attachments/assets/47e4b74b-8085-428b-aa49-0089e42c30dd)

#### 5. Repeat the previous steps and Verify the file persists across pod deletions. 
![image](https://github.com/user-attachments/assets/6a8b9af7-0537-484c-9c7c-7963f3bc2b89)






