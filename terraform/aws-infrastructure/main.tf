
resource "tls_private_key" "myprivatekey" {
  algorithm = "RSA"
  rsa_bits  = 4096
}


resource "aws_key_pair" "generated_key" {
  # key name represent the name of private key and publci key 
  key_name   = var.key_name
  public_key = tls_private_key.myprivatekey.public_key_openssh
}

resource "local_file" "private_key" {
  content    = tls_private_key.myprivatekey.private_key_pem
  filename   = "../../ansible/private_key.pem"
  depends_on = [module.ec2]
}

resource "null_resource" "set_permissions" {
  provisioner "local-exec" {
    command = "chmod 400 ../../ansible/private_key.pem"
  }

  depends_on = [local_file.private_key]
}

#locals {
#  bucket_name = "${var.bucket_prefix}-${random_id.bucket_suffix.hex}"
#}

resource "aws_sns_topic" "my_sns_topic" {
  name = var.sns_topic_name
}

resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.my_sns_topic.arn
  protocol  = "email"
  endpoint  = var.notification_email
}

module "vpc" {
  source   = "./vpc"
  vpc_cidr = var.vpc_cidr
}

module "subnets" {
  source              = "./subnets"
  vpc_id              = module.vpc.vpc_id
  public_subnet_cidrs = var.public_subnet_cidrs
}

module "security_groups" {
  source = "./security-groups"
  vpc_id = module.vpc.vpc_id
}

module "ec2" {
  source            = "./ec2"
  vpc_id            = module.vpc.vpc_id
  public_subnet_id  = element(module.subnets.public_subnet_ids, 0)
  security_group_id = module.security_groups.security_group_id
  instance_type     = var.instance_type
  ami               = var.ami
  key_name          = var.key_name
}

module "s3" {
  source      = "./s3"
  bucket_name = var.bucket_name
  environment = var.environment
}

module "dynamodb" {
  source      = "./dynamodb"
  table_name  = var.table_name
  hash_key    = var.hash_key
  environment = var.environment
}

terraform {
  backend "s3" {
    bucket         = "omarshaban32-s3-b1b2b3b4b5b6b7b8b9"
    key            = "~/MultiCloudDevOpsProject/terraform/aws-infrastructure/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
}

resource "aws_cloudwatch_log_group" "app_log_group" {
  name              = var.log_group_name
  retention_in_days = var.retention_in_days
}

resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = var.alarm_name
  comparison_operator = var.comparison_operator
  evaluation_periods  = var.evaluation_periods
  metric_name         = var.metric_name
  namespace           = var.namespace
  period              = var.period
  statistic           = var.statistic
  threshold           = var.threshold
  alarm_description   = var.alarm_description
  actions_enabled     = var.actions_enabled

  dimensions = {
    InstanceId = module.ec2.instance_id
  }

  alarm_actions = var.alarm_actions
}

resource "aws_iam_policy" "cloudwatch_logs_policy" {
  name        = var.policy_name
  description = var.policy_description

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogStreams"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role" "app_role" {
  name = var.role_name

  assume_role_policy = var.assume_role_policy
}

resource "aws_iam_role_policy_attachment" "attach_cloudwatch_logs_policy" {
  role       = aws_iam_role.app_role.name
  policy_arn = aws_iam_policy.cloudwatch_logs_policy.arn
}
