variable "aws_region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
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

