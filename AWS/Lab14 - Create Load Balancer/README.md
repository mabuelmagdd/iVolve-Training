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
Test the instance by opening the public ip in a new browser.

![image](https://github.com/user-attachments/assets/14bcbfd6-ac80-4004-a2df-30d5b84b8cc3)

#### 6. Create Apache instance
Add name > Use Ubuntu AMI > Create a key pair and save the .pem file.
Edit the Network Settings: add the vpc that we created> choose the public subnet we created for apache > create a new security group that allows HTTP requests from anywhere.
![image](https://github.com/user-attachments/assets/db37da81-cf8e-402e-9aad-703355aac630)

Add these commands to user data
```
#!/bin/bash
# Update the package list
apt update -y
apt install -y apache2
systemctl start apache2
systemctl enable apache2

```
Test the instance by opening the public ip in a new browser.

![image](https://github.com/user-attachments/assets/65623118-01f4-49e9-829a-a09508b543a9)

#### 7. Create the target group 
A Target Group is a logical grouping of targets (such as EC2 instances, IP addresses, or Lambda functions) that can receive traffic routed by a Load Balancer. It is a core component of the Elastic Load Balancer (ELB) service and helps manage traffic distribution.

Register both the apache and nginx instances 
![image](https://github.com/user-attachments/assets/8e6bbb22-226f-44ca-b80d-ebb083f4daff)

#### 8. Create the Load Balancer
1. Choose the type to be Application Load Balancer
2. Choose the VPC created
3. Choose the 2 AZs that contain both subnets
4. Specify the target group that targets the apache and nginx instances
![image](https://github.com/user-attachments/assets/244d2a0f-c14c-40d9-9856-2c97a61f2ca1)

#### 9. Load Balancer Test: Alternating Traffic Between Apache and Nginx
This test demonstrates the functionality of the configured Load Balancer (LB) in distributing incoming traffic alternately between two backend servers running Apache and Nginx.
1. **Retrieve the DNS of the Load Balancer**:
   - After deploying the Load Balancer, obtain its public DNS (e.g., `http://<LB-DNS>`).

2. **Access the Load Balancer in a Web Browser**:
   - Open any web browser and paste the Load Balancer's DNS into the address bar. Press **Enter** to load the page.

3. **Observe the Server Responses**:
   - Each time the page loads, the Load Balancer alternates traffic between the Apache and Nginx servers.
   - On the first refresh, you may see the response from the **Apache server** (e.g., "Welcome to Apache").
   - On the next refresh, you may see the response from the **Nginx server** (e.g., "Welcome to Nginx").

4. **Repeat the Process**:
   - Continue refreshing the browser to observe the round-robin traffic distribution.

**Expected Outcome**

- The Load Balancer ensures that traffic is evenly distributed between the Apache and Nginx servers.
- This confirms that the Load Balancer is functioning correctly and adhering to the round-robin load-balancing algorithm.

**Troubleshooting**

- If the responses do not alternate:
  - Verify the health of the backend servers.
  - Check the Target Group and Load Balancer configurations in AWS.

![image](https://github.com/user-attachments/assets/33f37fbe-9abb-42e2-a411-2541bdd59a99)
![image](https://github.com/user-attachments/assets/d1f13727-d790-470f-be8f-29917f42678a)


