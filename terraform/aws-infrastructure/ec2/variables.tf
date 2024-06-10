variable "vpc_id" {
  description = "The ID of the VPC"
  type = string
}

variable "public_subnet_id" {
  description = "The ID of the public subnet"
  type = string
}

variable "security_group_id" {
  description = "The ID of the security group"
  type = string
}

variable "instance_type" {
  description = "The type of EC2 instance to use"
  type = string
}

variable "ami" {
  description = "The AMI ID for the EC2 instance"
  type = string
}

