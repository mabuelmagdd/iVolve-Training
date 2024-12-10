variable "subnet_id" {
  description = "Subnet ID where the instance will be created"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  description = "Key pair name"
}
variable "vpc_id" {
  description = "VPC ID where the security group will be created"
}
