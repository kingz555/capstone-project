# VPC
resource "aws_vpc" "vpc_team5" {
    cidr_block = "10.0.0.0/16"

    tags = {
        Name = "vpc_team5"
    }
  
}

# Public Subnet 1
resource "aws_subnet" "public_sn1_team5" {
    cidr_block = "10.0.1.0/24"
    vpc_id = aws_vpc.vpc_team5.id
    availability_zone = "eu-west-2a"

    tags = {
        Name = "public_sn1_team5"
    }
  
}

# Public Subnet 2
resource "aws_subnet" "public_sn2_team5" {
    cidr_block = "10.0.2.0/24"
    vpc_id = aws_vpc.vpc_team5.id
    availability_zone = "eu-west-2b"

    tags = {
        Name = "public_sn2_team5"
    }
  
}

# Public Subnet 3
resource "aws_subnet" "public_sn3_team5" {
    cidr_block = "10.0.3.0/24"
    vpc_id = aws_vpc.vpc_team5.id
    availability_zone = "eu-west-2c"

    tags = {
        Name = "public_sn3_team5"
    }
  
}

# Private Subnet 1
resource "aws_subnet" "prv_sn1_team5" {
    cidr_block = "10.0.4.0/24"
    vpc_id = aws_vpc.vpc_team5.id
    availability_zone = "eu-west-2a"

    tags = {
        Name = "private_sn1_team5"
    }
  
}

# Private Subnet 2
resource "aws_subnet" "prv_sn2_team5" {
    cidr_block = "10.0.5.0/24"
    vpc_id = aws_vpc.vpc_team5.id
    availability_zone = "eu-west-2b"

    tags = {
        Name = "private_sn2_team5"
    }
  
}

# Private Subnet 3
resource "aws_subnet" "prv_sn3_team5" {
    cidr_block = "10.0.6.0/24"
    vpc_id = aws_vpc.vpc_team5.id
    availability_zone = "eu-west-2c"

    tags = {
        Name = "private_sn3_team5"
    }
  
}

## create Internet gateway
resource "aws_internet_gateway" "igw_team5" {
  vpc_id = aws_vpc.vpc_team5.id
  tags = {
    Name = "igw_team5"
  }
}

## create NAT gateway
resource "aws_nat_gateway" "team5-ngw" {
  allocation_id = aws_eip.team5-ngw.id
  subnet_id     = aws_subnet.public_sn3_team5.id

  tags = {
    Name = "team5-ngw"
  }
}

# create Elastic IP
resource "aws_eip" "team5-ngw" {
  depends_on = [aws_internet_gateway.igw_team5]
}

# create Route table for public subnet
resource "aws_route_table" "team5-pb-rt" {
  vpc_id = aws_vpc.vpc_team5.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_team5.id
  }
}

# create Route table for private subnet
resource "aws_route_table" "team5-prv-rt" {
  vpc_id = aws_vpc.vpc_team5.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.team5-ngw.id
  }
}

# create Route table association for public subnet 1 
resource "aws_route_table_association" "pb-subnet-rt-AS1" {
  subnet_id      = aws_subnet.public_sn1_team5.id
  route_table_id = aws_route_table.team5-pb-rt.id
}


# create Route table association for public subnet 2
resource "aws_route_table_association" "pb-subnet-rt-AS2" {
  subnet_id      = aws_subnet.public_sn2_team5.id
  route_table_id = aws_route_table.team5-pb-rt.id
}


# create Route table association for public subnet 3
resource "aws_route_table_association" "pb-subnet-rt-AS3" {
  subnet_id      = aws_subnet.public_sn3_team5.id
  route_table_id = aws_route_table.team5-pb-rt.id
}

# create Route table association for private subnet 1
resource "aws_route_table_association" "prv-subnet-rt-AS1" {
  subnet_id      = aws_subnet.prv_sn1_team5.id
  route_table_id = aws_route_table.team5-prv-rt.id
}

# create Route table association for private subnet 2
resource "aws_route_table_association" "prv-subnet-rt-AS2" {
  subnet_id      = aws_subnet.prv_sn2_team5.id
  route_table_id = aws_route_table.team5-prv-rt.id
}

# create Route table association for private subnet 3
resource "aws_route_table_association" "prv-subnet-rt-AS3" {
  subnet_id      = aws_subnet.prv_sn3_team5.id
  route_table_id = aws_route_table.team5-prv-rt.id
}

# create Frontend security group
resource "aws_security_group" "team5-Front-sg" {
  name        = "team5-Front-sg"
  description = "Allow inbound traffic"
  vpc_id      = aws_vpc.vpc_team5.id
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "team5-Front-sg"
  }
}
# create Backend security group
resource "aws_security_group" "team5-Back-sg" {
  name        = "team5-Back-sg"
  description = "Allow outbound traffic"
  vpc_id      = aws_vpc.vpc_team5.id
  
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  }
  ingress {
    description = "MYSQL"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  }
  egress {
    description = "HTTP"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "team5-Back-sg"
  }
}
 
#create db subnet group
resource "aws_db_subnet_group" "team5-dbsg1" {
  name       = "team5-dbsg"
  subnet_ids = ["${aws_subnet.prv_sn1_team5.id}", "${aws_subnet.prv_sn2_team5.id}", "${aws_subnet.prv_sn3_team5.id}"]

  tags = {
    Name = "team5-dbsg1"
  }
}

#Create MySQL RDS Instance
resource "aws_db_instance" "team5-rds-inst" {
  identifier             = "projdatabase"
  storage_type           = "gp2"
  allocated_storage      = 20
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = var.db_instance_class
  port                   = "3306"
  db_name                = "projdb"
  username               = var.db-username
  password               = var.db-password
  multi_az               = true
  parameter_group_name   = "default.mysql8.0"
  deletion_protection    = false
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.team5-dbsg1.name
  vpc_security_group_ids = [aws_security_group.team5-Back-sg.id]
}


# Create s3 bucket-media
resource "aws_s3_bucket" "team5-mediabuc" {
  bucket = "team5-mediabuc"
  force_destroy = true

  tags = {
    Name        = "team5-mediabuc"
  }
}
# Create s3 bucket-backup
resource "aws_s3_bucket" "team5-code-buc" {
  bucket = "team5-code-buc"
  force_destroy = true

  tags = {
    Name        = "team5-code-buc"
  }
}

#update bucket policy for media
resource "aws_s3_bucket_policy" "team5mediabucpol" {
  bucket = aws_s3_bucket.team5-mediabuc.id
  policy = jsonencode({
    Id = "mediaBucketPolicy"
    Statement = [
      {
        Action = ["s3:GetObject","s3:GetObjectVersion"]
        Effect = "Allow"
        Principal = {
          AWS = "*"
        }
        Resource = "arn:aws:s3:::team5-mediabuc/*"
        Sid      = "PublicReadGetObject"
      }
    ]
    Version = "2012-10-17"
  })
}

# Create bucket for policy media logs
resource "aws_s3_bucket" "team5-logs" {
  bucket = "team5-logs"
  force_destroy = true

  tags = {
    Name        = "team5-logs"
  }
}
#update bucket policy for media logs
resource "aws_s3_bucket_policy" "team5mediabuclogs" {
  bucket = aws_s3_bucket.team5-logs.id
  policy = jsonencode({
    Id = "mediaBucketPolicy"
    Statement = [
      {
        Action = "s3:GetObject"
        Effect = "Allow"
        Principal = {
          AWS = "*"
        }
        Resource = "arn:aws:s3:::team5-logs/*"
        Sid      = "PublicReadGetObject"
      }
    ]
    Version = "2012-10-17"
  })
}
data "aws_db_instance" "team5-rds-inst" {
  db_instance_identifier = "projdatabase"
  depends_on = [
    aws_db_instance.team5-rds-inst
  ]
  
}

# Create an IAM role for EC2
resource "aws_iam_instance_profile" "team5-IAM-Profile" {
  name = "team5-IAM-Profile"
  role = aws_iam_role.team5-IAM-Role.name
}
resource "aws_iam_role" "team5-IAM-Role" {
  name = "team5-IAM-Role"
  description = "S3 Full Permission"
  
    assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "team5-IAM-Profile"
  }
}

# Create Role policy attachment
resource "aws_iam_role_policy_attachment" "team5-role-pol-attach" {
  role       = aws_iam_role.team5-IAM-Role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}
#Create key pair for EC2 appserver
resource "aws_key_pair" "appserver1" {
  key_name   = "appserver1"
  public_key = file(var.appserver1)
}

#Create EC2 appserver instance for wordpress
resource "aws_instance" "team5-appserver" {
  ami           = "ami-035c5dc086849b5de"
  instance_type = "t2.micro"
  iam_instance_profile = aws_iam_instance_profile.team5-IAM-Profile.id
  vpc_security_group_ids = [aws_security_group.team5-Front-sg.id]
  associate_public_ip_address = true
  key_name = "appserver1"
  subnet_id = aws_subnet.public_sn1_team5.id
  user_data = <<-EOF
#!/bin/bash
sudo yum update -y
sudo yum upgrade -y
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo yum install unzip -y
unzip awscliv2.zip
sudo ./aws/install
sudo yum install httpd php php-mysqlnd -y
cd /var/www/html
touch indextest.html
echo "This is a test file" > indextest.html
sudo yum install wget -y
wget https://wordpress.org/wordpress-5.1.1.tar.gz
tar -xzf wordpress-5.1.1.tar.gz
cp -r wordpress/* /var/www/html/
rm -rf wordpress
rm -rf wordpress-5.1.1.tar.gz
chmod -R 755 wp-content
chown -R apache:apache wp-content
wget https://s3.amazonaws.com/bucketforwordpresslab-donotdelete/htaccess.txt
mv htaccess.txt .htaccess
cd /var/www/html && mv wp-config-sample.php wp-config.php
sed -i "s@define( 'DB_NAME', 'database_name_here' )@define( 'DB_NAME', 'projdb' )@g" /var/www/html/wp-config.php
sed -i "s@define( 'DB_USER', 'username_here' )@define( 'DB_USER', 'team5un' )@g" /var/www/html/wp-config.php
sed -i "s@define( 'DB_PASSWORD', 'password_here' )@define( 'DB_PASSWORD', 'team5password' )@g" /var/www/html/wp-config.php
sed -i "s@define( 'DB_HOST', 'localhost' )@define( 'DB_HOST','${element(split(":", aws_db_instance.team5-rds-inst.endpoint), 0)}' )@g" /var/www/html/wp-config.php
sudo sed -i  -e '154aAllowOverride All' -e '154d' /etc/httpd/conf/httpd.conf
cat <<EOT> /var/www/html/.htaccess
Options +FollowSymlinks
RewriteEngine on
rewriterule ^wp-content/uploads/(.*)$ http://${data.aws_cloudfront_distribution.team5_s3_distribution.domain_name}/\$1 [r=301,nc]
# BEGIN WordPress
# END WordPress
EOT
aws s3 cp --recursive /var/www/html/ s3://team5-code-buc
aws s3 sync /var/www/html/ s3://team5-code-buc
echo "* * * * * ec2-user /usr/local/bin/aws s3 sync --delete s3://team5-code-buc /var/www/html/" > /etc/crontab
echo "* * * * * ec2-user /usr/local/bin/aws s3 sync /var/www/html/wp-content/uploads/ s3://team5-mediabuc" >> /etc/crontab
sudo chkconfig httpd on
sudo service httpd start
sudo setenforce 0
  EOF
  tags = {
    Name = "team5-appserver"
  }
}
data "aws_cloudfront_distribution" "team5_s3_distribution" {
id = "${aws_cloudfront_distribution.team5_s3_distribution.id}"
}
#Create cloud front distribution
locals {
  s3_origin_id = "aws_s3_bucket.team5-mediabuc.id"
}
resource "aws_cloudfront_distribution" "team5_s3_distribution" {
  enabled             = true
  origin {
    domain_name = aws_s3_bucket.team5-mediabuc.bucket_regional_domain_name
    origin_id   = local.s3_origin_id
  }
  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 600
  }
   price_class = "PriceClass_200"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = {
    Environment = "production"
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}