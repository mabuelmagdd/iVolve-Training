# iVolve Technologies - Lab6 - SSH Configurations

## Objective

###  Generate public and private keys and enable SSH from your machine to another VM using the key. Configure SSH to just run ‘ssh ivolve’ without specify username, IP and key in the command. 

## Method 1: SSH the Normal Way (Specifying the PEM Key Path)

### 1. On one local machine, generate SSH key pair  
#### The private key will be saved as ivolve_key in the ~/.ssh directory, and the public key will be ivolve_key.pub.

### 2. Ensure both machines are connected 
#### Make sure that ssh is installed, enabled and started on VM2, let the FW allow ssh connections 

### 3. Copy public key to target VM

### 4. SSH into target VM using PEM file

## Method 2: SSH Config with Key File for Simplified Access

### 1. Create SSH config file

### 2. Add entry for the VM
#### Assign an alias ivolve for the VM whith the Vm's ip address, username and path to private key

### 3. Change permissions of file and test configuration






