output "vpc_id" {
  description = "ID of the created VPC"
  value       = alicloud_vpc.main.id
}

output "vswitch_id" {
  description = "ID of the created VSwitch"
  value       = alicloud_vswitch.main.id
}

output "security_group_id" {
  description = "ID of the created security group"
  value       = alicloud_security_group.main.id
}

output "ecs_instance_01_id" {
  description = "ID of the first ECS instance"
  value       = alicloud_instance.ecs_01.id
}

output "ecs_instance_01_public_ip" {
  description = "Public IP address of the first ECS instance"
  value       = alicloud_instance.ecs_01.public_ip
}

output "ecs_instance_01_private_ip" {
  description = "Private IP address of the first ECS instance"
  value       = alicloud_instance.ecs_01.private_ip
}

output "ecs_instance_02_id" {
  description = "ID of the second ECS instance"
  value       = alicloud_instance.ecs_02.id
}

output "ecs_instance_02_public_ip" {
  description = "Public IP address of the second ECS instance"
  value       = alicloud_instance.ecs_02.public_ip
}

output "ecs_instance_02_private_ip" {
  description = "Private IP address of the second ECS instance"
  value       = alicloud_instance.ecs_02.private_ip
}

output "ssh_connection_command_01" {
  description = "SSH connection command for the first ECS instance"
  value       = "ssh -i /path/to/your/private-key.pem root@${alicloud_instance.ecs_01.public_ip}"
}

output "ssh_connection_command_02" {
  description = "SSH connection command for the second ECS instance"
  value       = "ssh -i /path/to/your/private-key.pem root@${alicloud_instance.ecs_02.public_ip}"
}
