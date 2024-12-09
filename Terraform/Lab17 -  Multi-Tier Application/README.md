# Lab 17 - Multi-Tier Application Deployment with Terraform

### **Objective**

### Create ‘ivolve’ VPC manually in AWS and use Data block to get VPC id in your configuration file. Use Terraform to define and deploy a multi-tier architecture including 2 subnets, EC2, and RDS database. Use local provisioner to write the EC2 IP in a file called ec2-ip.txt.

![image](https://github.com/user-attachments/assets/879e55e5-b3f8-4a51-9fd4-5499e85de7cf)

#### **File Structure**
Make sure the following files are present:
- `main.tf`: Defines the core infrastructure (VPC, subnets, security groups, instances, etc.)
- `providers.tf`: Specifies provider configuration.
- `backend.tf`: Configures state management.

#### **Steps:**

#### 1. Manually create S3 bucket and DynamoDB
The state management is configured with an S3 backend and DynamoDB table for state locking.
Make sure the DynamoDB is with partition key `LockID`.
![image](https://github.com/user-attachments/assets/63affaaa-a441-4562-81e2-6bcde983965a)
![image](https://github.com/user-attachments/assets/23d00faa-1417-4f8e-8f8c-92e59f5289ac)

#### 2. Manually create VPC with CIDR `10.0.0.0/16`
![image](https://github.com/user-attachments/assets/a51711ef-a157-4e2a-a7e3-39b4d4769bbd)

Use data block to get vpc id in configuration.
```
data "aws_vpc" "ivolve" {
  filter {
    name   = "tag:Name"
    values = ["ivolve"]
  }
}
```

#### 3. Initialize Terraform
```
terraform init
```
#### 4. Plan the deployment 
```
terraform plan
```
#### 5. Apply the configuration
```
instanceterraform apply
```
#### 6. Verify the deployed resources in the AWS Management Console 
Network Resouce Map

![image](https://github.com/user-attachments/assets/3a33cc69-28c0-4985-b3b3-ec225c2c5db1)

Instance

![image](https://github.com/user-attachments/assets/e161f4ad-2917-4fcf-a695-a6149d360313)

Security group of the instance 

![image](https://github.com/user-attachments/assets/0fb445ae-1cda-43e7-b391-2fa0471913c1)

RDS 

![image](https://github.com/user-attachments/assets/9cd92bde-3033-453f-82fc-1b243e0136a7)

