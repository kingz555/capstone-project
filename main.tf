# VPC
resource "aws_vpc" "vpc_team5" {
    cidr_block = "10.0.0.0/16"

    tags = {
        Name = "vpc_team5"
    }
  
}

# Public Subnet 1
resource "aws_subnet" "public_sn1_team5" {
    cidr_block = "10.0.0.0/24"
    vpc_id = aws_vpc.vpc_team5.id
    availability_zone = "eu-west-2a"

    tags = {
        Name = "public_sn1_team5"
    }
  
}

# Public Subnet 2
resource "aws_subnet" "public_sn2_team5" {
    cidr_block = "10.0.1.0/24"
    vpc_id = aws_vpc.vpc_team5.id
    availability_zone = "eu-west-2b"

    tags = {
        Name = "public_sn2_team5"
    }
  
}

# Public Subnet 3
resource "aws_subnet" "public_sn3_team5" {
    cidr_block = "10.0.2.0/24"
    vpc_id = aws_vpc.vpc_team5.id
    availability_zone = "eu-west-2c"

    tags = {
        Name = "public_sn3_team5"
    }
  
}

# Private Subnet 1
resource "aws_subnet" "prv_sn1_team5" {
    cidr_block = "10.0.3.0/24"
    vpc_id = aws_vpc.vpc_team5.id
    availability_zone = "eu-west-2a"

    tags = {
        Name = "private_sn1_team5"
    }
  
}

# Private Subnet 2
resource "aws_subnet" "prv_sn2_team5" {
    cidr_block = "10.0.4.0/24"
    vpc_id = aws_vpc.vpc_team5.id
    availability_zone = "eu-west-2b"

    tags = {
        Name = "private_sn2_team5"
    }
  
}

# Private Subnet 3
resource "aws_subnet" "prv_sn3_team5" {
    cidr_block = "10.0.5.0/24"
    vpc_id = aws_vpc.vpc_team5.id
    availability_zone = "eu-west-2c"

    tags = {
        Name = "private_sn3_team5"
    }
  
}# VPC
resource "aws_vpc" "vpc_team5" {
    cidr_block = "10.0.0.0/16"

    tags = {
        Name = "vpc_team5"
    }
  
}

# Public Subnet 1
resource "aws_subnet" "public_sn1_team5" {
    cidr_block = "10.0.0.0/24"
    vpc_id = aws_vpc.vpc_team5.id
    availability_zone = "eu-west-2a"

    tags = {
        Name = "public_sn1_team5"
    }
  
}

# Public Subnet 2
resource "aws_subnet" "public_sn2_team5" {
    cidr_block = "10.0.1.0/24"
    vpc_id = aws_vpc.vpc_team5.id
    availability_zone = "eu-west-2b"

    tags = {
        Name = "public_sn2_team5"
    }
  
}

# Public Subnet 3
resource "aws_subnet" "public_sn3_team5" {
    cidr_block = "10.0.2.0/24"
    vpc_id = aws_vpc.vpc_team5.id
    availability_zone = "eu-west-2c"

    tags = {
        Name = "public_sn3_team5"
    }
  
}

# Private Subnet 1
resource "aws_subnet" "prv_sn1_team5" {
    cidr_block = "10.0.3.0/24"
    vpc_id = aws_vpc.vpc_team5.id
    availability_zone = "eu-west-2a"

    tags = {
        Name = "private_sn1_team5"
    }
  
}

# Private Subnet 2
resource "aws_subnet" "prv_sn2_team5" {
    cidr_block = "10.0.4.0/24"
    vpc_id = aws_vpc.vpc_team5.id
    availability_zone = "eu-west-2b"

    tags = {
        Name = "private_sn2_team5"
    }
  
}

# Private Subnet 3
resource "aws_subnet" "prv_sn3_team5" {
    cidr_block = "10.0.5.0/24"
    vpc_id = aws_vpc.vpc_team5.id
    availability_zone = "eu-west-2c"

    tags = {
        Name = "private_sn3_team5"
    }
  
}