provider "aws" {
  region     = "us-east-2"
}


terraform {
  backend "s3" {
    bucket   = "my-bucket-omar-hamdaa123"
    key      = "file/s3hh"
    region   = "us-east-2"
  }

}
resource "aws_vpc" "main1" {
  cidr_block = "50.0.0.0/16"
}
resource "aws_subnet" "subnet1" {
  vpc_id     = aws_vpc.main1.id
  cidr_block = "50.0.1.0/24"

  tags = {
    Name = "subnet1"
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id     = aws_vpc.main1.id
  cidr_block = "50.0.2.0/24"

  tags = {
    Name = "subnet2"
  }
}




resource "aws_internet_gateway" "public-subnet-igw" {
  vpc_id  = aws_vpc.main1.id

tags = {
        Name = "public-subnet-igw"
    }

}


resource "aws_route_table" "public-route" {
  vpc_id = aws_vpc.main1.id

  route {
     cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.public-subnet-igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}


resource "aws_route_table_association" "public-subnet1-association" {
  subnet_id= aws_subnet.subnet1.id
  route_table_id = aws_route_table.public-route.id
}



resource "aws_route_table_association" "public-subnet2-association" {
  subnet_id= aws_subnet.subnet2.id
  route_table_id = aws_route_table.public-route.id
}


