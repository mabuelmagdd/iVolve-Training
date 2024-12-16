#  Role-based Authorization 

## **Objective**

### Create user1 and user2 and assign admin role for user1 & read-only role for user2

## **Steps:**

#### 1. Install Role-based Authorization Plugin


#### 2. Configure Jenkins to Use Role-based Authorization
 Jenkins > Manage Jenkins > Configure Global Security
 In the Authorization section, select Role-Based Strategy > Save

 #### 3. Define Roles
 Jenkins > Manage Jenkins > Manage and Assign Roles > Manage Roles
    - Admin role (for user1): This role will allow full administrative access to Jenkins.
    - Read-only role (for user2): This role will allow user2 to view Jenkins resources but not modify anything.

 #### 4. Create Users  
 Jenkins > Manage Jenkins > Users
 - Create user-1
 - Create user-2

#### 5. Assign Roles
 Jenkins > Manage Jenkins > Manage and Assign Roles > Assign Roles

#### 5. Verify assigned roles 
 - Login as user-1
 - Login as user-2



