variable "vpc_id" {
  description = "The ID of the VPC"
  type = string
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type = list(string)
}

