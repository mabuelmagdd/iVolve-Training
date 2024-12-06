# iVolve Technologies - Lab12 - AWS Security

## **Objective**

####  Create AWS account, set billing alarm, create 2 IAM groups (admin-developer), admin group has admin permissions, developer group only access to ec2,  create admin-1 user with console access only and enable MFA & admin-2-prog user with cli access only and list all users and groups using commands, create dev-user with programmatic and console access and try to access EC2 and S3 from dev user.

## **Steps:**

#### 1. Set billing alarm
##### 1.1 Make sure Cloud Watch Billing alerts are enabled from  
`Billing and cost Management > Billing Preferences` By Alert preferences choose Edit>
Choose Receive CloudWatch Billing Alerts > Choose Save preferences.
![image](https://github.com/user-attachments/assets/9d11eda8-c989-4571-912a-555b24ae7113)

##### 1.2 Create Alarm: `CloudWatch > All Alarms > Create ALarm`
![image](https://github.com/user-attachments/assets/5e919770-88d9-443d-8e99-3cdf25f66af4)
![image](https://github.com/user-attachments/assets/7cf4eaa0-b44d-4b7f-b22d-ce11de0730d2)
Specify an Amazon SNS topic to be notified when your alarm is in the ALARM state. The Amazon SNS topic can include your email address so that you recieve email when the billing amount crosses the threshold that you specified.
![image](https://github.com/user-attachments/assets/18852878-18e8-44af-80c6-af65d726510b)
**Result:**
![image](https://github.com/user-attachments/assets/14d201c0-57ed-43b4-9577-b4e3fa7c1e20)

#### 2. Create `admin` group with the required permissions
![image](https://github.com/user-attachments/assets/01b881fe-2838-4ef9-ae0a-06fbc6ea3d03)

#### 3. Create `developer` group with the required permissions 
![image](https://github.com/user-attachments/assets/2f291c41-f64a-4eed-9a1b-3ddd54ef4195)
![image](https://github.com/user-attachments/assets/2b2a3c8d-8c17-49a0-b75e-4327e212b253)

#### 4. Create `admin-1` user with MFA
![image](https://github.com/user-attachments/assets/805447ef-86af-46dc-b443-7194d4bd295b)
![image](https://github.com/user-attachments/assets/2333c02d-b952-4e60-bd7d-9bf339d97137)

#### 5. Create `admin-2` with disabled control access
![image](https://github.com/user-attachments/assets/cf5f0277-1d48-4a15-a0e1-4f10f8c46c32)

#### 6. Test by listing users 
![image](https://github.com/user-attachments/assets/1a65cb2c-2a46-4326-851a-edc1fcccddfb)

#### 7. Test by listing groups
![image](https://github.com/user-attachments/assets/f2d7277e-5e20-485a-a0de-7e98b253ca43)

#### 8. Create `dev-user`, log in using dev-user, try to access ec2
![image](https://github.com/user-attachments/assets/238f13d4-597d-4aef-9d2c-547e110c50ca)

#### 9. Test `dev-user` trying to create an s3 bucket 
![image](https://github.com/user-attachments/assets/3eed9c1e-72d3-46ca-a792-fec4bb16746f)




