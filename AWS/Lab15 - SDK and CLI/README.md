# Lab 15 - SDK and CLI Interactions

## **Objective**

####  Use the AWS CLI to Create an S3 bucket, configure permissions, and upload/download files to/from the bucket. Enable versioning and logging for the bucket.

![image](https://github.com/user-attachments/assets/7c15e0a0-d644-4363-9c3c-cd7be97b1e70)


## **Steps:**

#### 1. Create S3 bycket
```
aws s3api create-bucket --bucket <bucket-name> --region <region>
```
![image](https://github.com/user-attachments/assets/46c89ddf-74fb-4a8e-86ff-a102d88c0f15)

Test that it was successfully created 
```
aws s3 ls
```
![image](https://github.com/user-attachments/assets/519c5237-2250-4159-b26f-aab3890f72ad)

Test from console by openeing the s3 services, the bucket shiould be present

![image](https://github.com/user-attachments/assets/a25f2133-395b-45ac-957d-261a75f4d852)

#### 2. Configure policy  
```
vim policy.json
```
policy.jason content 
```
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::<accountid>:user/<userid>"
      },
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::m1412-bucket/*"
    },
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::<accountid>:user/<userid>"
      },
      "Action": "s3:PutObject",
      "Resource": "arn:aws:s3:::m1412-bucket/*"
    }
  ]
}

```
Set the policy then test if it was applied 
```
aws s3api put-bucket-policy --bucket <bucketname> --policy file://policy.json
aws s3api get-bucket-policy --bucket <bucketname>
```
![image](https://github.com/user-attachments/assets/4b23d8b6-e52f-4bec-9b6d-157981599bad)

#### 3. Put object
```
echo "hello" | aws s3 cp -s3://<bucketname>/<filename>
```
Test if object was put in the bucket 
```
 aws s3 ls s3://<bucketname>
```
![image](https://github.com/user-attachments/assets/59216aa2-56e5-4ad4-808d-fca5ac439120)

#### 4. Enable versioning 
```
aws s3api put-bucket-versioning --bucket <bucketname> --versioning-configuration Status=Enabled
```
Test if it is enabled
```
aws s3api get-bucket-versioning --bucket <bucketname> 
```
![image](https://github.com/user-attachments/assets/3d79ed33-f37e-4117-a716-0181c9287cb1)

#### 5. Enable logging 

**Enable Logging:** provides detailed records about requests made to a bucket. When logging is enabled for an S3 bucket, S3 automatically generates log files containing information about requests to the bucket.

**Edit policy.json to allow logging:** The AWS S3 service needs permission to write logs to your target bucket. By default, only the bucket owner has full permissions, and you need to explicitly grant access to logging.s3.amazonaws.com, which is the AWS service that will be generating the log files.
```
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "S3ServerAccessLogsPolicy",
      "Effect": "Allow",
      "Principal": {
        "Service": "logging.s3.amazonaws.com"
      },
    }
  ]
}

```
`logging.json`
```
{
     "LoggingEnabled": {
         "TargetBucket": "m1412-bucket",
         "TargetPrefix": "Logs/"
     }
 }

```
Enable logging and test 
```
aws s3api put-bucket-logging --bucket <bucketname> --bucket-logging-status file://logging.json
```
![image](https://github.com/user-attachments/assets/37a28f17-5123-422b-a200-d57cb8164cc8)



