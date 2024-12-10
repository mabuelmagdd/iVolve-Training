# Lab6 - SSH Configurations

## Objective

###  Generate public and private keys and enable SSH from your machine to another VM using the key. Configure SSH to just run ‘ssh ivolve’ without specify username, IP and key in the command. 

## Method 1: SSH the Normal Way (Specifying the PEM Key Path)

### 1. On one local machine, generate SSH key pair  
#### The private key will be saved as ivolve_key in the ~/.ssh directory, and the public key will be ivolve_key.pub.
![image](https://github.com/user-attachments/assets/951ddb1a-4f57-47f1-8e82-9b1ce67bccce)
### 2. Ensure both machines are connected 
#### Make sure that ssh is installed, enabled and started on VM2, let the FW allow ssh connections 
![image](https://github.com/user-attachments/assets/ba27ce94-8ece-4f49-b3bf-56e77a8e534c)
![image](https://github.com/user-attachments/assets/aba49f4e-3ae2-4e07-bbe2-b36c6c8589a3)
![image](https://github.com/user-attachments/assets/16693b01-43ef-4a2a-b1ca-95f2e6dca6bb)
### 3. Copy public key to target VM
![image](https://github.com/user-attachments/assets/7ac337b8-3b7d-420b-8016-0d1ee0078431)
### 4. SSH into target VM using PEM file
![image](https://github.com/user-attachments/assets/443ea914-fe3f-4c0d-a1b7-99702f7b6676)
## Method 2: SSH Config with Key File for Simplified Access

### 1. Create SSH config file
<img width="235" alt="image" src="https://github.com/user-attachments/assets/5dc10520-f021-4bf2-a3e0-6300173ef18a">

### 2. Add entry for the VM
#### Assign an alias ivolve for the VM whith the Vm's ip address, username and path to private key
![image](https://github.com/user-attachments/assets/0eff280b-c5b4-49c9-a740-55d67517294e)
### 3. Change permissions of file and test configuration
![image](https://github.com/user-attachments/assets/ddd6f733-ede0-42ac-8a46-6109886ad45a)







