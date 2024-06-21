aws_region              = "us-east-1"
log_group_name          = "/aws/ecs/app-logs"
retention_in_days       = 14
alarm_name              = "high_cpu_alarm"
comparison_operator     = "GreaterThanOrEqualToThreshold"
evaluation_periods      = 2
metric_name             = "CPUUtilization"
namespace               = "AWS/EC2"
period                  = 120
statistic               = "Average"
threshold               = 80
alarm_description       = "This metric monitors EC2 CPU utilization"
actions_enabled         = true
policy_name             = "cloudwatch-logs-policy"
policy_description      = "Policy to allow writing logs to CloudWatch"
role_name               = "app-role"
alarm_actions           = ["arn:aws:sns:us-east-1:339712892155:my-sns-topic"]

