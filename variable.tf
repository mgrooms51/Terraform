# ami variable

variable "ami" {
  description = "ami-id"
  type        = string
  default     = "ami-0bef6cc322bfff646"
}

#instance_type variable

variable "instance" {
  description = "instance_type"
  type        = string
  default     = "t2.micro"
}

#bootstrap jenkins as a variable

variable "user_data_wk20" {
  description = "jenkinswk20"
  type        = string
  default     = <<-EOF
  #!/bin/bash
  sudo yum update -y
  sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
  sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
  sudo yum upgrade 
  sudo amazon-linux-extras install java-openjdk11 -y 
  sudo yum install jenkins -y
  sudo systemctl enable jenkins
  sudo systemctl start jenkins
  EOF
}

#s3 bucket variable

variable "pjs3" {
  description = "s3 bucket"
  type        = string
  default     = "wk20bucket"
}

#region variable

variable "region" {
  description = "enviorment region"
  type        = string
  default     = "us-east-1"
}

#vpc_id variable

variable "dvpc" {
  description = "vpc_id"
  type        = string
  default     = "vpc-0ba00454f291dc198"
}
      