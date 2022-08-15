resource "aws_vpc" "goodclass-vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "goodclass-vpc"
  }
}


# PUBLIC SUBNET
resource "aws_subnet" "my-public-sub-1" {
  vpc_id     = aws_vpc.goodclass-vpc.id
  cidr_block = var.pub_sub_1_cidr
  availability_zone = "eu-west-2a"
  
  tags = {
    Name = "my-public-sub-1"
  }
}


# PUBLIC SUBNET
resource "aws_subnet" "my-public-sub-2" {
  vpc_id     = aws_vpc.goodclass-vpc.id
  cidr_block = var.pub_sub_2_cidr
  availability_zone = "eu-west-2b"

  tags = {
    Name = "my-public-sub-2"
  }
}


# PRIVATE SUBNET
resource "aws_subnet" "my-private-sub-1" {
  vpc_id     = aws_vpc.goodclass-vpc.id
  cidr_block = var.pri_sub_1_cidr
  availability_zone = "eu-west-2a"

  tags = {
    Name = "my-private-sub-1"
  }
}


# PRIVATE SUBNET
resource "aws_subnet" "my-private-sub-2" {
  vpc_id     = aws_vpc.goodclass-vpc.id
  cidr_block = var.pri_sub_2_cidr
  availability_zone = "eu-west-2b"

  tags = {
    Name = "my-private-sub-2"
  }
}


# PUBLIC ROUTE TABLE
resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.goodclass-vpc.id

  tags = {
    Name = "public-route-table"
  }
}


# PRIVATE ROUTE TABLE
resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.goodclass-vpc.id

  tags = {
    Name = "private-route-table"
  }
}


#PUBLIC ROUTE TABLE ASSOCIATION
resource "aws_route_table_association" "public-route-1-association" {
  subnet_id      = aws_subnet.my-public-sub-1.id
  route_table_id = aws_route_table.public-route-table.id
}


#PUBLIC ROUTE TABLE ASSOCIATION
resource "aws_route_table_association" "public-route-2-association" {
  subnet_id      = aws_subnet.my-public-sub-2.id
  route_table_id = aws_route_table.public-route-table.id
}


#PRIVATE ROUTE TABLE ASSOCIATION
resource "aws_route_table_association" "private-route-1-association" {
  subnet_id      = aws_subnet.my-private-sub-1.id
  route_table_id = aws_route_table.private-route-table.id
}


#PRIVATE ROUTE TABLE ASSOCIATION
resource "aws_route_table_association" "private-route-2-association" {
  subnet_id      = aws_subnet.my-private-sub-2.id
  route_table_id = aws_route_table.private-route-table.id
}

#INTERNET GATEWAY
resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.goodclass-vpc.id

  tags = {
    Name = "IGW"
  }
}


resource "aws_route" "public-IGW-route" {
  route_table_id         = aws_route_table.public-route-table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.IGW.id

}

