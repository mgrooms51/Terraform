
#creates ec2 instance

resource "aws_instance" "Jenkinswk20" {
  ami                    = var.ami
  instance_type          = var.instance
  vpc_security_group_ids = [aws_security_group.jenkinssgwk20.id]
  key_name               = "swarm"
  user_data              = var.user_data_wk20

  tags = {
    Name = "jenkinswk20"
  }
}

# creates a security group for jenkins that allows traffic from port 22,8080,443

resource "aws_security_group" "jenkinssgwk20" {
  name   = "jenkinssgwk20"
  vpc_id = var.dvpc

  ingress {
    description = "shh traffic"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    description = "Access Jenkins"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    description = "https"
    from_port   = 443
    to_port     = 443
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
    Name = "jenkinssgwk20"
  }
}

# s3 resource to create a private bucket

resource "aws_s3_bucket" "wk20bucket" {
  bucket = var.pjs3

  tags = {
    Name = "wk20bucket"

  }
}

resource "aws_s3_bucket_ownership_controls" "jenkins_wk20_ownership" {
  depends_on = [aws_s3_bucket.wk20bucket]
  bucket     = aws_s3_bucket.wk20bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "pwk20bucket" {
  depends_on = [aws_s3_bucket_ownership_controls.jenkins_wk20_ownership]

  bucket = aws_s3_bucket.wk20bucket.id
  acl    = "private"
}

