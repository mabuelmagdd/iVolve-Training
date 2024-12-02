# iVolve Technologies - Lab5 - Disk Management and Logical Volume Setup

## Objective

### Attach a 15GB disk to your VM, partition it into 5GB, 5GB, 3GB, and 2GB sections. Use the first 5GB partition as a file system, configure the 2GB partition as swap, initialize the second 5GB as a Volume Group (VG) with a Logical Volume (LV), then extend the LV by adding the 3GB partition.

## Steps:

### 1. Partition 
![image](https://github.com/user-attachments/assets/40432803-31a0-4f2e-964e-e8473495c135)
![image](https://github.com/user-attachments/assets/5a0e5259-708b-4bc1-92a2-c2a4079e7cd8)
![image](https://github.com/user-attachments/assets/012eecab-f66a-4b2d-ad9b-322ae613d557)
![image](https://github.com/user-attachments/assets/05bb7424-8e46-43d2-bcae-190777ace9e1)

### 2. Create LVs
![image](https://github.com/user-attachments/assets/3bd1ce9d-6e3a-4580-bf6c-0867b1e781f6)
![image](https://github.com/user-attachments/assets/d8f0e57c-b16f-4c61-98dd-b77f966f06e1)
![image](https://github.com/user-attachments/assets/c8273135-2706-43eb-93bc-c1ec86337ee6)
#### 2.1 Before Extension
![image](https://github.com/user-attachments/assets/9b2db4e6-cdaf-4d02-9fb3-76bdc1e7e385)
![image](https://github.com/user-attachments/assets/cc840ace-2f42-41de-95df-5c6651bc0e0c)
![image](https://github.com/user-attachments/assets/a8ec71f1-f40a-4063-9b94-abd753e2ace0)
#### 2.2 After Extension
![image](https://github.com/user-attachments/assets/f9a402aa-7e7b-43f0-bf31-3148e5ea1974)

### 3. Format
![image](https://github.com/user-attachments/assets/32fb29ce-4bae-4378-80a4-1b89ad98867d)
![image](https://github.com/user-attachments/assets/51276537-0a42-4736-b697-0a20cff66107)
![image](https://github.com/user-attachments/assets/b0126f7e-2249-4322-9fe7-ca93ef782976)
![image](https://github.com/user-attachments/assets/d516f5bc-5eca-4110-8c43-c8b68955dd44)

### 4. Mount
![image](https://github.com/user-attachments/assets/1106889a-b0ca-449c-9749-4f7bf97a020b)
![image](https://github.com/user-attachments/assets/19f51492-3e42-4891-90d2-af557929cafd)

### 5. Add to /etc/fstab
![image](https://github.com/user-attachments/assets/ba82f9c7-b0b5-41ef-9e42-59168aba3cee)




