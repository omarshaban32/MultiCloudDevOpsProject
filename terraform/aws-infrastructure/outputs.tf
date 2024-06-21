output "s3_bucket_name" {
  description = "The name of the S3 bucket"
  value       = module.s3.bucket_name
}

output "dynamodb_table_name" {
  description = "The name of the DynamoDB table"
  value       = module.dynamodb.table_name
}

output "ec2_id" {
  description = "The ID of the EC2 instance"
  value       = module.ec2.instance_id
}

output "alarm_actions" {
  description = "The ID of the EC2 instance"
  value       = [aws_sns_topic.my_sns_topic.arn]
}
