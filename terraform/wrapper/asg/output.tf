output "test-app_autoscaling_group_id" {
  description = "test-app autoscaling group id"
  value       = module.test-app_autoscaling_group.autoscaling_group_id
}

output "test-app_autoscaling_group_name" {
  description = "test-app autoscaling group name"
  value       = module.test-app_autoscaling_group.autoscaling_group_name
}

output "test-app_autoscaling_group_arn" {
  description = "test-app ARN for this AutoScaling Group"
  value       = module.test-app_autoscaling_group.autoscaling_group_arn
}

output "test-app_sg_id" {
  description = "The ID of the test-app_sg security group"
  value       = module.test-app_sg.security_group_id
}