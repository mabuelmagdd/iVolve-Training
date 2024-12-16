#  Role-based Authorization 

## **Objective**

### Create user1 and user2 and assign admin role for user1 & read-only role for user2

## **Steps:**

#### 1. Install Role-based Authorization Plugin
![image](https://github.com/user-attachments/assets/8542a0da-ef8c-43ea-989a-b1fdcbc73a8f)


#### 2. Configure Jenkins to Use Role-based Authorization
 Jenkins > Manage Jenkins > Configure Global Security
 In the Authorization section, select Role-Based Strategy > Save
 
![image](https://github.com/user-attachments/assets/584a16b8-b0e6-4190-9f31-00ce3a62e268)

 #### 3. Define Roles
 Jenkins > Manage Jenkins > Manage and Assign Roles > Manage Roles
    - Admin role (for user1): This role will allow full administrative access to Jenkins.
    - Read-only role (for user2): This role will allow user2 to view Jenkins resources but not modify anything.

![image](https://github.com/user-attachments/assets/0cabfe64-527c-4606-8ad5-6e8cb63631cd)

 #### 4. Create Users  
 Jenkins > Manage Jenkins > Users
 - Create user-1
 - Create user-2

![image](https://github.com/user-attachments/assets/e57930e2-f0c1-433f-9a5e-31160b18e6ea)


#### 5. Assign Roles
 Jenkins > Manage Jenkins > Manage and Assign Roles > Assign Roles

![image](https://github.com/user-attachments/assets/d6884d1f-0678-4020-bd08-f4a3558f1abd)

#### 5. Verify assigned roles 
 - Login as user-1
 - Login as user-2



