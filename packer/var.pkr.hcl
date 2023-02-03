#############SSH CONFIG#############
variable "username" {
  type    = string
  default = "ec2-user"
}

variable "timeout" {
  type    = string
  default = "10m"
}

##########INSTANCE CONFIG##########
variable "aws_region" {
  type    = string
  default = "ap-south-1"
}

variable "instance_type" {
  type    = string
  default = "t3a.micro"
}

variable "vpc_id" {
  type    = string
  default = "vpc-024923e0150529bc4"
}

variable "subnet_id" {
  type    = string
  default = "subnet-006ca13d0376733c7"
}

variable "source_ami_name" {
  type    = string
  default = "amzn2-ami-hvm-*-x86_64-gp2"
}

###########VOLUME CONFIG###########
variable "volume_type" {
  type    = string
  default = "gp3"
}

variable "device_name" {
  type    = string
  default = "/dev/sdb"
}

variable "delete_on_termination" {
  type    = bool
  default = true
}

variable "volume_size" {
  type    = number
  default = 10
}

