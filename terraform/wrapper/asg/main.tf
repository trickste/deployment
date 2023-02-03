module "test-app_sg" {
  source = "../../modules/sg/"
  name   = "${local.test-app_sg_tags.component}-${local.test-app_sg_tags.type}-${local.test-app_sg_tags.environment}"
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "allow ssh"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 9000
      to_port     = 9000
      protocol    = "tcp"
      description = "allow ssh"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "outbound rule public"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
  tags = local.test-app_sg_tags
}


module "test-app_autoscaling_group" {
  source                    = "../../modules/asg"
  name                      = "${local.test-app_asg_tags.component}-${local.test-app_asg_tags.type}-${local.test-app_asg_tags.environment}"
  use_name_prefix           = false
  min_size                  = lookup(var.asg_configurations["test-app"], "min_size")
  max_size                  = lookup(var.asg_configurations["test-app"], "max_size")
  desired_capacity          = lookup(var.asg_configurations["test-app"], "desired_capacity")
  health_check_type         = lookup(local.asg_configurations["test-app"], "health_check_type")
  vpc_zone_identifier       = data.terraform_remote_state.vpc.outputs.private_subnets
  lt_name                   = "${local.test-app_asg_tags.component}-${local.test-app_asg_tags.type}-${local.test-app_asg_tags.environment}-lt"
  update_default_version    = lookup(local.asg_configurations["test-app"], "update_default_version")
  iam_instance_profile_name = lookup(local.asg_configurations["test-app"], "iam_instance_profile_name")
  use_lt                    = lookup(local.asg_configurations["test-app"], "use_lt")
  create_lt                 = lookup(local.asg_configurations["test-app"], "create_lt")
  image_id                  = data.aws_ami.ami_id.image_id
  instance_type             = lookup(var.asg_configurations["test-app"], "instance_type")
  key_name                  = lookup(local.asg_configurations["test-app"], "key_name")
  security_groups           = [module.test-app_sg.security_group_id]
  ebs_optimized             = lookup(local.asg_configurations["test-app"], "ebs_optimized")
  user_data_base64          = base64encode(local.asg_userdata)
  enable_monitoring         = lookup(local.asg_configurations["test-app"], "enable_monitoring")
  target_group_arns         = data.terraform_remote_state.alb.outputs.target_group_arns
  block_device_mappings     = lookup(local.asg_configurations["test-app"], "block_device_mappings")
  instance_refresh = {
    strategy = "Rolling"
    preferences = {
      checkpoint_delay       = 600
      checkpoint_percentages = [35, 70, 100]
      instance_warmup        = 300
      min_healthy_percentage = 50
    }
    triggers = ["tag"]
  }
  tag_specifications = [
    {
      resource_type = "instance"
      tags          = local.test-app_asg_tags
    },
    {
      resource_type = "volume"
      tags          = local.test-app_asg_tags
    }
  ]

  tags = [local.test-app_asg_tags]
}
