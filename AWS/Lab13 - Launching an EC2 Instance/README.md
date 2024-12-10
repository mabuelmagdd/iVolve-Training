# Lab 13 - Launching an EC2 Instance

## **Objective**

####   Create a VPC with public and private subnets and 1 EC2 in each subnet, configure private EC2 security group to only allow inbound SSH from public EC2 IP, SSH to the private instance using bastion host


![image](https://github.com/user-attachments/assets/8bcaf5fa-2bc8-406f-a54f-1a49db18ffee)

**Resource Map for the network**
![image](https://github.com/user-attachments/assets/0820b598-a768-447f-8317-74f872d32970)

## **Steps:**

#### 1. Create VPC with CIDR `10.0.0.0/16`
![image](https://github.com/user-attachments/assets/c2f422f5-c29e-4fb7-8421-506a4312a8bf)

#### 2. Create the 2 subnets 
The public subnet with CIDR `10.0.1.0/24`and the private subnet with CIDR `10.0.2.0/24`.
![image](https://github.com/user-attachments/assets/9b559f9f-21cf-44f4-9c3e-40ee8797523b)

#### 3. Create Internet Gateway
![image](https://github.com/user-attachments/assets/e57d98b3-d0fb-499a-b664-5b634351def2)

#### 4. Create public route table 
Add IGW as a target to the route table from `0.0.0.0/0` to connect to the internet.
![image](https://github.com/user-attachments/assets/a8b2d66d-4d45-4033-98da-a3af5de306fe)
Associate the public subnet with this route table by adding this subnet in the subnet association tab.
![image](https://github.com/user-attachments/assets/4a5278f9-9b82-4991-83af-3497db810d32)

#### 5. Create private route table 
Don't add a route to the internet.
![image](https://github.com/user-attachments/assets/cf8f4d5e-b11d-4da5-85ba-407b281c9b4c)
Associate the private subnet with this route table by adding this subnet in the subnet association tab.
![image](https://github.com/user-attachments/assets/50040dcf-a9c7-4ebb-a7f1-a7eef82579b2)

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


