variable "aws_region" {
  description = "The AWS region to deploy resources"
  type = string
  default = "us-east-1"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type = list(string)
  default = ["10.0.1.0/24"]
}

variable "instance_type" {
  description = "The type of EC2 instance to use"
  type = string
  default = "t2.micro"
}

variable "ami" {
  description = "The AMI ID for the EC2 instance"
  type = string
  default = "ami-04b70fa74e45c3917" #  ubuntu server 24.04 AMI
}

