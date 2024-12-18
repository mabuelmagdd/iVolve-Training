# Lab10 - Ansible Roles for Application Deployment

## **Objective**

## Organize Ansible playbooks using roles. Create an Ansible role for installing Jenkins, docker, openshift CLI ‘OC’.
**What is a role?**
An Ansible role is a collection of tasks used to configure a host for a specific purpose, such as configuring a service. YAML files with a predefined directory structure are used to define roles. The following directories are found in a role directory structure: defaults, vars, tasks, files, templates, meta, and handlers.
## **Prerequisites**
1. Before running this lab, ensure you have the following:
- **Operating System**: Ubuntu 24.04
- **Ansible Version**: 2.9 or higher
  ```
  sudo apt install ansible -y
  ```
- **Target Server**: Remote or local machine with Ubuntu 24.04 installed
- **Access**: SSH access to the target server with sudo privileges
  
2. Ensure the following files are present:
   - `inventory`: make sure the inventory has the public DNS of the instance
   - `ansible.cfg`: put the paths for the inventory file, keypair file, and roles directory
   - `jenkins-main`: file to install Jenkins on target machine
     *copy contents of this file to roles/jenkins/tasks/main.yaml*
   - `docker-main`: file to install Docker on target machine
     *copy contents of this file to roles/docker/tasks/main.yaml*
   - `oc-main`: file to install OpenShift CLI on target machine
     *copy contents of this file to roles/oc/tasks/main.yaml*
   - `playbook10.yaml`


## **Steps:**

#### 1. Create roles directory
  ```
  mkdir roles
  cd roles
  ```
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
#### 5. On the target machine, test that services are installed and actively running 
  ```
  sudo systemctl status jenkins
  sudo systemctl status docker
  oc version
  ```
![image](https://github.com/user-attachments/assets/e9b82ce7-f3d9-4441-bff9-312d572f012b)

![image](https://github.com/user-attachments/assets/f51cb4f7-2d3f-40c2-9a9a-f9951e1d4ade)

![image](https://github.com/user-attachments/assets/def48875-0e5a-4065-afe2-724c8ced95b9)



