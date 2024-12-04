# iVolve Technologies - Lab11 - Ansible Dynamic Inventories

## **Objective**

### Set up Ansible dynamic inventories to automatically discover and manage infrastructure. Use Ansible Galaxy role to install Apache.

**What is a Dynamic Inventory?**
Dynamic inventories in Ansible allow you to source your inventory data from external systems dynamically. This can be from cloud providers, databases, or any system that can output JSON formatted to Ansible’s specifications.

**Why Use Dynamic Inventories?**
  - Scalability: Automatically adapts to changes in your infrastructure.
  - Accuracy: Ensures that your playbooks use the most current server information.
  - Flexibility: Easily integrates with cloud providers and other dynamic systems.

## **Prerequisites**
1. Before running this lab, ensure you have the following:
- **Operating System**: Ubuntu 24.04
- **Install Ansible**: 2.9 or higher
  ```
  sudo apt install ansible -y
  ```
- **Install AWS CLI**
  ```
  sudo snap install aws-cli --classic
  ```
- **Install boto3**
  ```
  sudo apt install python3-boto3
  ```
- **Use Ansible Galaxy role to install Apache**
  ```
  ansible-galaxy install geerlingguy.apache
  ```
- **Target Server**: Remote or local machine with Ubuntu 24.04 installed
- **Access Keys**: Save access and secret access keys to be used to connect to aws account 
- **Access**: SSH access to the target server with sudo privileges
  
2. Ensure the following files are present:
    - `aws_ec2.yaml`: This is an Ansible dynamic inventory configuration that uses the `aws_ec2` plugin to automatically discover EC2 instances in AWS based on specific filters to manage them without needing to manually update the inventory list.
   - `ansible.cfg`: put the paths for the dynamic inventory file and the keypair file
   - `playbook.yaml`: This playbook file is an Ansible playbook used to install Apache on EC2 instances with the tag Name=Ansible  

## **Steps:**

#### 1. Set up your AWS CLI with your credentials and configuration
  ```
  aws configure
  ```
  This allows you to interact with AWS services from the command line without needing to manually input credentials each time.
  
#### 2. Create roles using `ansible-galaxy`
  ```
 ansible-galaxy init jenkins
 ansible-galaxy init docker
 ansible-galaxy init oc
  ```
#### 3. Run the `tree` commmand to see the structure of the roles 
  ```
  tree
  ```
#### 4. Run the playbook
  ```
  ansible-playbook playbook10
  ```



