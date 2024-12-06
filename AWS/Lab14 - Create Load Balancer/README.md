# iVolve Technologies - Lab 14 - Create AWS Load Balancer

## **Objective**

####   Create VPC with 2 public subnets, launch 2 EC2s with Nginx and Apache installed using user data, create and configure a Load Balancer to access the 2 Web servers.

![image](https://github.com/user-attachments/assets/25d0ee0a-2bde-4302-8a58-00b41169b896)

**Resource Map for the network**
![image](https://github.com/user-attachments/assets/8cea142c-7a53-4e5d-bf09-dbeb2a317b9e)

## **Steps:**

#### 1. Create VPC with CIDR `10.0.0.0/16`
![image](https://github.com/user-attachments/assets/0361efb8-0a41-4805-b237-6e7d4b6081d7)

#### 2. Create the 2 subnets 
The public subnet with CIDR `10.0.1.0/24` and AZ `us-east-1a` and the other public subnet with CIDR `10.0.2.0/24` and AZ `us-east-1b`
![image](https://github.com/user-attachments/assets/83070104-6eb9-4fe9-8b5a-9fce7a61d2b3)

#### 3. Create Internet Gateway
![image](https://github.com/user-attachments/assets/dfb80a33-64cf-489a-8715-e9fdbe96b52f)

#### 4. Create public route table 
Add IGW as a target to the route table from `0.0.0.0/0` to connect to the internet.
Associate the 2 public subnets with this route table.
![image](https://github.com/user-attachments/assets/9f1c353c-8325-48bc-aa8a-7538d87a4ef9)

#### 5. Create NGINX instance
Add name > Use Ubuntu AMI > Create a key pair and save the .pem file.
Edit the Network Settings: add the vpc that we created> choose the public subnet we created for nginx > create a new security group that allows HTTP requests from anywhere.
![image](https://github.com/user-attachments/assets/aa6decd6-5b84-4a91-a72a-508b9f9c01c1)
Add these commands to user data
```
#!/bin/bash
# Update the system
sudo yum update -y
sudo yum install -y nginx
sudo systemctl start nginx
sudo systemctl enable nginx

```
Test the instance by openeing the public ip in a new browser.
![image](https://github.com/user-attachments/assets/14bcbfd6-ac80-4004-a2df-30d5b84b8cc3)

#### 6. Create the EC2 instance that will act as the Bastion host 
Add name > Use Ubuntu AMI > Create a key pair and save the .pem file.
Edit the Network Settings: add the vpc that we created> choose the public subnet we created > create a new security group that allows SSH from anywhere.
![image](https://github.com/user-attachments/assets/3f5fef3b-8d32-4334-8624-ac3e731eae57)

#### 7. Create the EC2 instance that will act as the private one 
Add name > Use Ubuntu AMI > Create a key pair and save the .pem file.
Edit the Network Settings: add the vpc that we created> choose the private subnet we created > create a new security group that **allows SSH from bastion host only by specifying the security group of the bastion host in the inbound rule.**
![image](https://github.com/user-attachments/assets/5db7f68e-8b15-4d78-98b2-05db62e69a7e)

#### 8. Connect to the bastion host 
```
chmod 400 <path-to-.pem-file-of-bastion-host>
ssh -i <path-to-.pem-file-of-bastion-host> ubuntu@<ip-of-bastion-host>
```
![image](https://github.com/user-attachments/assets/c6a2e014-4ae7-499d-aa3e-9aec920b846c)

#### 9. Connect to the private instance through the bastion host
##### 9.1 Open a new terminal and copy the .pem file of the private machine to the bastion host 
This command copies the private key from local machine to the Bastion host at the path /home/ubuntu/.ssh/ using SSH for secure transfer. The -i flag ensures the private key on local machine is used for authentication.
```
scp -i <path-to-.pem-file-of-private-instance> <path-to-.pem-file-of-bastion-host> ubuntu@<ip-of-bastion-host>:/home/ubuntu/.ssh/
```
##### 9.2 SSH to the private machine 
```
ssh -i <path-to-.pem-file-of-private-instance> ubuntu@<ip-of-private-instance>
```
![image](https://github.com/user-attachments/assets/6b4918ca-a8ba-4dda-87ed-9f9b26b04558)


