locals {
  test-app_sg_tags = {
    component   = "application"
    type        = "sg"
    environment = "test"
    terraform   = "true"
  }
  test-app_asg_tags = {
    component   = "application"
    type        = "asg"
    environment = "test"
    terraform   = "true"
  }

  asg_configurations = {
    test-app = {
      health_check_type         = "EC2"
      update_default_version    = true
      iam_instance_profile_name = "EC2Role"
      use_lt                    = true
      create_lt                 = true
      key_name                  = "mumbai-pem"
      ebs_optimized             = true
      enable_monitoring         = true
      block_device_mappings = [
        {
          device_name = "/dev/xvda"
          ebs = {
            delete_on_termination = true
            encrypted             = true
            volume_size           = lookup(var.asg_configurations["test-app"], "root_volume_size")
            volume_type           = "gp3"
          }
          }, {
          device_name = "/dev/sdb"
          ebs = {
            delete_on_termination = true
            encrypted             = true
            volume_size           = lookup(var.asg_configurations["test-app"], "secondary_volume_size")
            volume_type           = "gp3"
          }
        }
      ]
    }
  }

  asg_userdata = <<-EOT
    #!/bin/bash
    docker-compose -f /usr/lib/docker-compose.yml up -d
  EOT
}
