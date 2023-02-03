data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "app-test-terraform-state-bucket-test-0223"
    key    = "test-app/test/vpc/vpc.tfstate"
    region = "ap-south-1"
  }
}

data "terraform_remote_state" "alb" {
  backend = "s3"
  config = {
    bucket = "app-test-terraform-state-bucket-test-0223"
    key    = "test-app/test/alb/alb.tfstate"
    region = "ap-south-1"
  }
}

data "aws_ami" "ami_id" {
  most_recent = true
  owners      = ["375838535931"]

  filter {
    name   = "name"
    values = ["test-app-golden-ami*"]
  }
}