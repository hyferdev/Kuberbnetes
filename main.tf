provider "aws" {
  region = "us-west-2"
}

# Create your VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.1.0.0/16"

  tags = {
    Name = "hyfervpc"
  }
}

# Create your subnets
resource "aws_subnet" "my_subnet_1" {
  cidr_block = "10.1.1.0/24"
  vpc_id     = aws_vpc.my_vpc.id
  availability_zone = "us-west-2b"
  map_public_ip_on_launch = true

  tags = {
    Name = "pub-subnet-1"
  }
}

resource "aws_subnet" "my_subnet_2" {
  cidr_block = "10.1.2.0/24"
  vpc_id     = aws_vpc.my_vpc.id
  availability_zone = "us-west-2c"
  map_public_ip_on_launch = true

  tags = {
    Name = "pub-subnet-2"
  }
}

resource "aws_subnet" "my_subnet_3" {
  cidr_block = "10.1.3.0/24"
  vpc_id     = aws_vpc.my_vpc.id
  availability_zone = "us-west-2b"
  
  tags = {
    Name = "priv-subnet-3"
  }
}

resource "aws_subnet" "my_subnet_4" {
  cidr_block = "10.1.4.0/24"
  vpc_id     = aws_vpc.my_vpc.id
  availability_zone = "us-west-2c"

  tags = {
    Name = "priv-subnet-4"
  }
}

# Create your internet gateway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "my-igw"
  }
}

# Create route tables
resource "aws_route_table" "pub_rt" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "pub-rt"
  }
}

resource "aws_route_table" "priv_rt" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "priv-rt"
  }
}

# Associate public route table with internet gateway
resource "aws_route" "my_route" {
  route_table_id = aws_route_table.pub_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.my_igw.id
}

# Associate route tables with subnets
resource "aws_route_table_association" "my_rta_1" {
  subnet_id      = aws_subnet.my_subnet_1.id
  route_table_id = aws_route_table.pub_rt.id
}

resource "aws_route_table_association" "my_rta_2" {
  subnet_id      = aws_subnet.my_subnet_2.id
  route_table_id = aws_route_table.pub_rt.id
}

resource "aws_route_table_association" "my_rta_3" {
  subnet_id      = aws_subnet.my_subnet_3.id
  route_table_id = aws_route_table.priv_rt.id
}

resource "aws_route_table_association" "my_rta_4" {
  subnet_id      = aws_subnet.my_subnet_4.id
  route_table_id = aws_route_table.priv_rt.id
}

