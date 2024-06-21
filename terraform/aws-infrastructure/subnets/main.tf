resource "aws_subnet" "public" {
#  count = length(var.public_subnet_cidrs)
  vpc_id = var.vpc_id
#  cidr_block = element(var.public_subnet_cidrs, count.index)
  cidr_block = var.public_subnet_cidrs[0]
  availability_zone = var.public_subnet_az
  map_public_ip_on_launch = true

  tags = {
#    Name = "public-subnet-${count.index}"
    Name = "public-subnet"
  }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = var.vpc_id
    tags = {
      Name: "${var.vpc_name}-igw"
    }
}

resource "aws_route_table" "igw-rtw" {
    vpc_id = var.vpc_id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
      Name: "${var.vpc_name}-rtb-public"
    }
}

resource "aws_route_table_association" "rtb_igw_association" {
    subnet_id = aws_subnet.public.id
    route_table_id = aws_route_table.igw-rtw.id
}
