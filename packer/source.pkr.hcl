packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

data "amazon-ami" "source_ami" {
  most_recent = true
  owners      = ["amazon"]
  filters = {
    name = var.source_ami_name
  }
}

source "amazon-ebs" "goldenami" {
  profile		      = "default"
  ami_name                    = "test-app-golden-ami"
  region                      = var.aws_region
  instance_type               = var.instance_type
  source_ami                  = data.amazon-ami.source_ami.id
  vpc_id                      = var.vpc_id
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true
  communicator                = "ssh"
  ssh_username                = var.username
  launch_block_device_mappings {
    volume_type           = var.volume_type
    device_name           = var.device_name
    delete_on_termination = var.delete_on_termination
    volume_size           = var.volume_size
  }
}

build {
  sources = [
    "source.amazon-ebs.goldenami"
  ]
  provisioner "ansible" {
    playbook_file   = "./ansible/main.yml"
    extra_arguments = ["-v"]
    ansible_env_vars = [
      "ANSIBLE_HOST_KEY_CHECKING=False"
    ]
    user = var.username
  }
}

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
  default = "amzn2-ami-kernel-*-x86_64-gp2"
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
