##### Network #####
vpc_cidr_block = "10.0.0.0/16"
az = "us-east-1a"
pub_subnet_cidr_block= "10.0.0.0/24"

##### Instance #####
instance_type = "t2.micro"

##### SNS #####
sns_topic_name = "cpu_alert"
sns_target_protocol = "email"
sns_topic_target = "maryamabualmajd@gmail.com"

##### CW #####
cw_alarm_name = "high-cpu-utilization-alarm"
cw_comparison_operator = "GreaterThanThreshold"
cw_evaluation_periods = 1
cw_metric_name = "CPUUtilization"
cw_namespace = "AWS/EC2"
cw_period = 300
cw_statistic = "Average"
cw_threshold = 70
cw_alarm_description = "This metric monitors the EC2 instance CPU utilization"