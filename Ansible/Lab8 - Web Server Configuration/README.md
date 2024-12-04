# iVolve Technologies - Lab8 -  Ansible Playbooks for Web Server Configuration

## Objective

###  Write an Ansible playbook to automate the configuration of a web server.

## Steps:

### 1. Create EC2 instance on AWS
![image](https://github.com/user-attachments/assets/9c14f63e-3624-40b1-aaec-d02414af3967)

### 2. Download the keypair .PEM file of the instance and change its permissions 
```
chmod 400 <path-to-pem-file>
```
### 3. Create inventory with the public DNS of the instance
![image](https://github.com/user-attachments/assets/fa269e87-073e-4347-a493-93824380f15b)

### 4. Create ansible.cfg file
![image](https://github.com/user-attachments/assets/9bc62b6c-dbb2-43cf-b63d-e10a3750094a)

### 5. Create playbook.yaml file to install NGINX on the instance
![image](https://github.com/user-attachments/assets/86f87705-b9a0-4ba8-ad5e-78c23479b658)

### 6. Test 
![image](https://github.com/user-attachments/assets/47cf6039-7c86-4c87-933a-4350a7cc48db)
