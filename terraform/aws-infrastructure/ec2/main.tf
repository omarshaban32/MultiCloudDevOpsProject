resource "aws_instance" "app" {
  ami = var.ami
  instance_type = var.instance_type
  subnet_id = var.public_subnet_id
  security_groups = [var.security_group_id]

  tags = {
    Name = "app-instance"
  }
}

