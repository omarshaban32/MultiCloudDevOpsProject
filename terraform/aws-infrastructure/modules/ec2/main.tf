resource "aws_instance" "app" {
  ami = var.ami
  instance_type   = var.instance_type
  subnet_id       = var.public_subnet_id
  security_groups = [var.security_group_id]
  key_name        = var.key_name
  
  tags = {
    Name = "app-instance"
  }
}

resource "aws_ebs_volume" "ec2_volume" {
  availability_zone = aws_instance.app.availability_zone
  size              = var.volume_size

  tags = {
    Name = "ec2_volume"
  }
}

resource "aws_volume_attachment" "ec2_attachment" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.ec2_volume.id
  instance_id = aws_instance.app.id
}
