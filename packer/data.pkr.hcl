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
  owners      = ["aws-marketplace"]
  filters = {
    name = var.source_ami_name
  }
}
