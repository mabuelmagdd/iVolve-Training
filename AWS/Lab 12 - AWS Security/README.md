# iVolve Technologies - Lab12 - AWS Security

## **Objective**

###  Create AWS account, set billing alarm, create 2 IAM groups (admin-developer), admin group has admin permissions, developer group only access to ec2,  create admin-1 user with console access only and enable MFA & admin-2-prog user with cli access only and list all users and groups using commands, create dev-user with programmatic and console access and try to access EC2 and S3 from dev user.

## **Steps:**

#### 1. Set billing alarm
##### 1.1 Make sure Cloud Watch Billing alerts are enabled from  
`Billing and cost Management > Billing Preferences`
![image](https://github.com/user-attachments/assets/9d11eda8-c989-4571-912a-555b24ae7113)

#### 2. On EC2 instance create a keypair .PEM file and ACCESS Keys
#### 3. Change the .PEM file permisions on management node 
 ```
  chmod 400 <path-to-pem-file>
  ```
#### 2. Set up your AWS CLI with your credentials and configuration
  ```
  aws configure
  ```
  It prompts you to enter your `AWS Access Key ID`, `Secret Access Key`, `default region`, and `output format`. This allows you to interact with AWS services from the command line without needing to manually input credentials each time.
  
#### 3. Create dynamic inventory
  ```
 --- 
plugin: aws_ec2
regions:
  - us-east-1
filters:
  # this selects only running instances with tag Name of value Ansible
  "tag:Name": "Ansible"
  "instance-state-name": "running"
keyed_groups:
  - key: tags.Name
    prefix: 'tag_'
  ```
#### 4. Create `ansible.cfg` 
   ```
 [defaults]
inventory = aws_ec2.yml
remote_user = ubuntu
private_key_file = /home/ubuntu/Downloads/ubuntukey.pem
  ```
#### 5. Test and display the correctness of your dynamic inventory configuration 
  ```
  ansible-inventory --list
  ```
#### 6. Test and visualize the relationships and groupings of hosts within the inventory 
  ```
 ansible-inventory -i <inventoryfile> --graph
  ```
#### 7. Create playbook
  ```
 ---
- name: Install Apache
  hosts: tag__Ansible
  become: yes
  roles:
    - geerlingguy.apache

  ```
#### 8. Run playbook
  ```
 ansible-playbook playbook.yaml
  ```



