# iVolve Technologies - Lab10 - Ansible Roles for Application Deployment

## **Objective**

## Organize Ansible playbooks using roles. Create an Ansible role for installing Jenkins, docker, openshift CLI ‘OC’.
**What is role?**
An Ansible role is a collection of tasks used to configure a host for a specific purpose, such as configuring a service. YAML files with a predefined directory structure are used to define roles. The following directories are found in a role directory structure: defaults, vars, tasks, files, templates, meta, and handlers.
## **Prerequisites**
Before running this lab, ensure you have the following:
- **Operating System**: Ubuntu 24.04
- **Ansible Version**: 2.9 or higher
  ```
  sudo apt install ansible -y
  ```
- **Target Server**: Remote or local machine with Ubuntu 24.04 installed
- **Access**: SSH access to the target server with sudo privileges

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
#### 3. Structure of roles after running `tree` command 



