variable "bucket_prefix" {
  description = "The prefix for the S3 bucket name"
  type        = string
  default     = "my-unique-bucket"
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
  default     = "omarshaban32-s3-a1a2a3a4a5a6a7a"
}


variable "environment" {
  description = "The environment (e.g., dev, prod)"
  type        = string
  default     = "dev"
}

