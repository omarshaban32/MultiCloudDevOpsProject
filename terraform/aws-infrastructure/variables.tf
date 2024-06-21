variable "aws_region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "key_name" {
  description = "The key pair"
  type        = string
  default     = "mykeypair"
}

variable "filename" {
  description = "The filename for keypair"
  type        = string
  default     = "../../ansible/private_key.pem"
}


variable "sns_topic_name" {
  description = "The name of the SNS topic"
  type        = string
  default     = "my-sns-topic"
}

variable "notification_email" {
  description = "The email address to receive SNS notifications"
  type        = string
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
  default     = "app-vpc"
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "instance_type" {
  description = "The type of EC2 instance to use"
  type        = string
  default     = "t3.large"
}

variable "ami" {
  description = "The AMI ID for the EC2 instance"
  type        = string
  default     = "ami-04b70fa74e45c3917" #  ubuntu server 24.04 AMI
}


variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
  default     = "omarshaban32-s3-b1b2b3b4b5b6b7b8b9"
}

variable "table_name" {
  description = "The name of the DynamoDB table"
  type        = string
  default     = "terraform-lock-table"
}

variable "hash_key" {
  description = "The hash key for the DynamoDB table"
  type        = string
  default     = "ID"
}

variable "environment" {
  description = "The environment (e.g., dev, prod)"
  type        = string
  default     = "dev"
}


variable "log_group_name" {
  description = "The name of the CloudWatch log group"
  type        = string
  default     = "/aws/ecs/app-logs"
}

variable "retention_in_days" {
  description = "The number of days to retain the log events"
  type        = number
  default     = 14
}

variable "alarm_name" {
  description = "The name of the CloudWatch alarm"
  type        = string
  default     = "high_cpu_alarm"
}

variable "comparison_operator" {
  description = "The comparison operator for the CloudWatch alarm"
  type        = string
  default     = "GreaterThanOrEqualToThreshold"
}

variable "evaluation_periods" {
  description = "The number of periods over which data is compared to the specified threshold"
  type        = number
  default     = 2
}

variable "metric_name" {
  description = "The name of the metric to be monitored"
  type        = string
  default     = "CPUUtilization"
}

variable "namespace" {
  description = "The namespace of the metric to be monitored"
  type        = string
  default     = "AWS/EC2"
}

variable "period" {
  description = "The period in seconds over which the specified statistic is applied"
  type        = number
  default     = 120
}

variable "statistic" {
  description = "The statistic to apply to the alarm's associated metric"
  type        = string
  default     = "Average"
}

variable "threshold" {
  description = "The value against which the specified statistic is compared"
  type        = number
  default     = 80
}

variable "alarm_description" {
  description = "The description of the CloudWatch alarm"
  type        = string
  default     = "This metric monitors EC2 CPU utilization"
}

variable "actions_enabled" {
  description = "Indicates whether actions should be executed during any changes to the alarm's state"
  type        = bool
  default     = true
}

variable "alarm_actions" {
  description = "The list of actions to execute when this alarm transitions into an ALARM state"
  type        = list(string)
}

variable "policy_name" {
  description = "The name of the IAM policy"
  type        = string
  default     = "cloudwatch-logs-policy"
}

variable "policy_description" {
  description = "The description of the IAM policy"
  type        = string
  default     = "Policy to allow writing logs to CloudWatch"
}

variable "role_name" {
  description = "The name of the IAM role"
  type        = string
  default     = "app-role"
}

variable "assume_role_policy" {
  description = "The assume role policy for the IAM role"
  type        = string
  default     = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

