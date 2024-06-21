variable "vpc_id" {
  description = "The ID of the VPC"
  type = string
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type = list(string)
}

variable "public_subnet_az" {
  description = "The public_subnet_az "
  type = string
  default = "us-east-1a"
}

variable "vpc_name" {
  description = "The name of the VPC"
  type = string
  default = "app-vpc"
}
