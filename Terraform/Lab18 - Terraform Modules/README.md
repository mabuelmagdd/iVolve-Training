# Lab 19 - Remote Backend and LifeCycle Rules

## **Objective**

###  Implement the below diagram with Terraform. Store state file in remote backend. Use create_before_destroy Lifecycle on the EC2 and verify it. Compare between different Lifecycles Rules.

![image](https://github.com/user-attachments/assets/f372152b-1410-4347-b573-154defcc194b)

### **File Structure**

Make sure the following files are present:
- `providers.tf`: Specifies provider configuration.
- `backend.tf`: Configures state management.
- `variables.tf`: Declares variables.
- `terraform.tfvars`: Provides variable values.
- `network.tf`: This file creates a VPC with a public subnet, an internet gateway, and a route table to enable internet access for resources within the subnet.
- `instance.tf`: This file provisions an EC2 instance using the latest Ubuntu AMI, assigns it a public IP, and secures it with a security group allowing SSH access
- `sns.tf`: This file creates an SNS topic for CPU alerts and sets up a subscription to send notifications to a specified endpoint using the defined protocol.
- `cloudwatch.tf`: This file sets up a CloudWatch alarm to monitor CPU utilization for an EC2 instance and triggers notifications via an SNS topic when the alarm state changes.

#### **What is a resource lifecycle?**
A resource lifecycle in Terraform is a way to control how Terraform manages the creation, update, and destruction of resources. The lifecycle block can be used within a resource definition to define specific behavior for managing the resource's lifecycle. Key arguments include:
1. `create_before_destroy`:
   - What it does: Ensures the new resource is created before the old one is destroyed.
   - Use case: Useful when updating resources (like EC2 instances) to avoid downtime. For example, if you change an instance type, Terraform will create a new instance first before destroying the old one.

2. `prevent_destroy`:
   - What it does: Prevents the resource from being destroyed.
   - Use case: Protects critical resources (e.g., a production EC2 instance or database) from accidental deletion. Terraform will throw an error if you try to destroy the resource
  
3. `ignore_changes`:
   - What it does: Tells Terraform to ignore changes to specific attributes of a resource.
   - Use case: Useful if certain attributes (like tags or user data) are managed outside of Terraform, and you don’t want Terraform to modify them during updates.

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
#### 4. Verify the deployed resources from the email for the subscribtion confirmation
![image](https://github.com/user-attachments/assets/6d1fda71-9a23-4a2a-8239-1aa1e43a375e)
