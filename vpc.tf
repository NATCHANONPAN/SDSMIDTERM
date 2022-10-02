data "aws_availability_zones" "azs" {

}

resource "aws_vpc" "vpc" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name = "${var.stack}-vpc"
  }
}

resource "aws_subnet" "public1" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "172.16.0.0/24"
  availability_zone = var.availability_zone

  tags = {
    Name = "public-subnet-1"
  }
}

# resource "aws_subnet" "public2" {
#   vpc_id = aws_vpc.vpc.id
#   cidr_block =  "172.16.1.0/24"
#   availability_zone = var.availability_zone

#   tags = {
#     Name = "public-subnet-2"
#   }
# }

# resource "aws_subnet" "private1" {
#   vpc_id = aws_vpc.vpc.id
#   cidr_block = "172.16.2.0/24"
#   availability_zone = var.availability_zone

#   tags = {
#     Name = "private-subnet-1"
#   }
# }

resource "aws_subnet" "private2" {
  vpc_id = aws_vpc.vpc.id
  cidr_block =  "172.16.3.0/24"
  availability_zone = var.availability_zone

  tags = {
    Name = "private-subnet-2"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags  = {
    Name = "internet-gateway"
  }
  
}



# resource "aws_nat_gateway" "natgw" {
#   allocation_id = aws_eip.nat1.id
#   subnet_id = aws_subnet.private2.id

#   tags = {
#     Name = "nat-gateway"
#   }  
# }

resource "aws_route_table" "rt1" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "rt1"
  }
  
}

resource "aws_route_table_association" "rt1asso" {
  subnet_id = aws_subnet.public1.id
  route_table_id = aws_route_table.rt1.id
  
}


#no need asso between nat and rt
# resource "aws_route_table" "rt2" {
#   vpc_id = aws_vpc.vpc.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     nat_gateway_id  = aws_nat_gateway.natgw.id
#   }

#   tags = {
#     Name = "rt2"
#   }
  
# }


