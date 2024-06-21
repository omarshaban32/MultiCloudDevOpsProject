variable "backend_bucket" {
  description = "The name of the S3 bucket for the Terraform state"
  type        = string
}

variable "backend_key" {
  description = "The path to the state file inside the S3 bucket"
  type        = string
}

variable "backend_region" {
  description = "The AWS region for the S3 bucket and DynamoDB table"
  type        = string
}

variable "backend_dynamodb_table" {
  description = "The name of the DynamoDB table for state locking"
  type        = string
}

variable "backend_encrypt" {
  description = "Whether to enable encryption for the S3 state file"
  type        = bool
  default     = true
}

