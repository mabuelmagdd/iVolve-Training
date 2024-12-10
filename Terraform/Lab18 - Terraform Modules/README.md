# Lab 18 - Terraform Modules

## **Objective**

###  Create VPC with 2 public subnets in main.tf file. Create EC2 module to create 1 EC2 with Nginx installed on it using user data. Use this module to deploy 1 EC2 in each subnet. 
![image](https://github.com/user-attachments/assets/424eee15-789b-4770-8f18-86b04a22d4b1)


### **File Structure**

Make sure the following files are present:
- `providers.tf`: Specifies provider configuration.
- `backend.tf`: Configures state management.
- `variables.tf`: Declares variables.
- `terraform.tfvars`: Provides variable values.
- `main.tf`: Configures the VPC, subnets, and EC2 instances with Nginx, referencing modules for VPC and EC2 setup.
- `vpc-module/`: Contains resources to create a VPC and subnets, making the network infrastructure reusable
- `ec2-module/`: Defines the EC2 instance resource, including the installation of Nginx and instance configuration.
- `userdata.sh`: A shell script to install and configure Nginx on EC2 instances via user data.


#### **What are terraform modules?**
In this lab, Terraform modules are used to organize and reuse code efficiently. A module is a container for multiple resources that are used together. Modules allow you to group related resources and configurations, making your code more modular, reusable, and easier to maintain.

- **VPC Module:** This module is responsible for creating a Virtual Private Cloud (VPC) and its associated subnets.
- **EC2 Module:** This module provisions EC2 instances with Nginx installed via a user data script.
### **Steps:**

#### 1. Initialize Terraform
```
terraform init
```
#### 2. Plan the deployment 
```
terraform plan
```
#### 3. Apply the configuration
```
terraform apply
```
#### 4. Verify from AWS Console
VPC Resource Map
![image](https://github.com/user-attachments/assets/e6ad1e25-d401-43b4-bf60-4a038fd4a1f4)

EC2 Instances
![image](https://github.com/user-attachments/assets/e9e2002d-1141-44b7-b9eb-dc3593256f57)

