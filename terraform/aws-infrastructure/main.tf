
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

