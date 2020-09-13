variable "key_name" {
    description = "Name of the SSH keypair to use in AWS."
    default = "mvvpkey"
}

variable "profile"{
default = "terraform_iam_user"
}
variable "aws_region" {
  default = "us-west-1"
}

variable "aws_access_key" {
    description = "AWS Access Key"
    default = "PASTE aws_access_key"
}

variable "aws_secret_key" {
    description = "AWS Secret Key"
    default = "PASTE aws_secret_key"
}

variable "aws_role_arn" {
    type    = "string"
    description = "Role ARN to launch instance"
    default = "arn:aws:iam::1234553:role/role-rw-all-ec2"
}

variable "vpc_id" {
  type = "string"
  description = "VPC ID to launch instance"
  default = "XXXX"
}
variable "subnet_id" {
    type    = "string"
    description = "Subnet ID to use in VPC"
    default = "XXXX"
}

variable "instance" {
  default = "t2.medium"
}

variable "instance_count" {
  default = "1"
}


variable "private_key" {
  default = "/home/vikas/vp/vp-base.pem"
}

variable "ansible_user" {
  default = "ubuntu"
}
# Ubuntu Precise 16.04 LTS (x64)
variable "amis" {
  type = "map"

  default = {
   "ap-south-1" = "vpc-6aaf4f03",
        "eu-west-3" = "vpc-aba902c2",
        "eu-west-2" = "vpc-18d03d71",
        "eu-west-1" = "vpc-46051e24",
        "ap-northeast-2" = "vpc-355dba5c",
        "ap-northeast-1" = "vpc-e57d6287",
        "sa-east-1" = "vpc-d916b1bc",
        "ca-central-1" = "vpc-1a53bf73",
        "ap-southeast-1" = "ami-b7f388cb",
        "ap-southeast-2" = "vpc-414d5223",
        "eu-central-1" = "vpc-9a46a1f3",
        "us-east-1" = "vpc-e44ca381",
        "us-east-2" = "vpc-318e6758",
        "us-west-1" = "ami-07585467",
        "us-west-2" = "ami-79873901"
  }
}

variable "ami" {
  default = "ami-07585467"
}
