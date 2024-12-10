# AWS Architecture Deployment with Terraform

![image](https://github.com/user-attachments/assets/29d72172-26c5-40ec-b920-4490e48bc4b6)

## Overview
This Terraform project sets up an AWS infrastructure with load balancers, reverse proxy and web server EC2 instances, autoscaling, and network configuration within a VPC. This design ensures scalable and secure web hosting, with organized modules for ease of maintenance and reusability.

## Project Structure

- **autoscalling.tf**: Defines autoscaling resources.
- **backend.tf**: Configures remote backend using S3 for state storage and DynamoDB for state locking.
- **instances.tf**: Defines EC2 instances and AMI data sources.
- **keypair.tf**: Manages SSH key pairs for accessing instances.
- **loadbalancers.tf**: Configures application load balancers for traffic distribution.
- **network.tf**: Sets up VPC, subnets, and internet gateways.
- **securitygroups.tf**: Defines security group rules.
- **variables.tf** and **terraform.tfvars**: Holds customizable input variables for different environments.

## Requirements

### 1. Workspace
- Create a Terraform workspace named `dev` for deployment.
![image](https://github.com/user-attachments/assets/c8ee708d-fe87-4d06-9072-b62ec08f93c1)

### 2. Configure `terraform.tfvars`
Update `terraform.tfvars` with necessary variables such as instance types, VPC IDs, and subnet IDs.

### 3. Backend Configuration
1. Create an **S3 bucket** in the AWS console for storing Terraform state with deletion protection.
   ![image](https://github.com/user-attachments/assets/af8da4d2-456f-4f35-a52b-e86a3a71e11d)

2. Create a **DynamoDB table** with `LockID` as the partition key for state locking.
   ![image](https://github.com/user-attachments/assets/4c8927c8-4af3-4a86-b239-a63bc4e92a7b)

3. Update the `backend.tf` file with the S3 bucket and DynamoDB table details.
   ![image](https://github.com/user-attachments/assets/3d379712-eee5-4ec5-b0bf-452aec57d458)


### 4. Provisioning with `remote-exec` and `local-exec`
Uses **remote-exec** and **local-exec** provisioners to configure the proxy and web server instances.
#### 4.1. Proxy Instances
Reverse proxies (using Nginx) forward requests to an internal load balancer.
`remote-exec`:
```
provisioner "remote-exec" {
    inline = [
    "sleep 50",
    "sudo apt update -y",
    "sudo apt install nginx -y",
    "sudo systemctl enable nginx",
    "sudo systemctl start nginx",
    "sudo bash -c 'cat > /etc/nginx/sites-enabled/default <<EOL\nserver {\n    listen 80 default_server;\n    location / {\n        proxy_pass http://${aws_lb.lb_2.dns_name};\n    }\n}\nEOL'",
    "sudo systemctl reload nginx"
  ]
}

```
`local-exec`:
```
  provisioner "local-exec" {
    command = "echo '${self.public_ip}' >> all_ips.txt "
}
```
![image](https://github.com/user-attachments/assets/175a4acf-79ac-4983-92ef-0bab92f0304b)
#### 4.2. Web Server Instances
The web server instances are configured to serve content through an internal load balancer (LB2) located in private subnets.
`remote-exec`:
```
provisioner "remote-exec" {
      inline=[
        "sleep 50",
        "sudo apt update -y",
        "sudo apt install apache2 -y",
        "sudo systemctl enable apache2",  
        "sudo systemctl start apache2",
      ]
  }

```
`local-exec`:
```
  provisioner "local-exec" {
    command = "echo '${self.public_ip}' >> all_ips.txt "
}
```
![image](https://github.com/user-attachments/assets/d5ae9a4d-183c-46bb-bb7d-933a817ae7ff)
### 5. Use data source to get image 
```
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]

}
```
### 6. Load Balancer Configuration
The architecture includes two load balancers:
- **Load Balancer 1 (Public)**: Receives incoming traffic and directs it to the reverse proxy instances in public subnets.
- **Load Balancer 2 (Internal)**: Distributes traffic from the proxies to the web servers in private subnets.
### 7. DNS Test 
![image](https://github.com/user-attachments/assets/c4c82cdc-b886-4e89-b7f3-83f2463682c3)
