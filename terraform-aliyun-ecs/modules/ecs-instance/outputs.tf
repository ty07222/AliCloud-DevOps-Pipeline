output "instance_id" {
  description = "ID of the created ECS instance"
  value       = alicloud_instance.this.id
}

output "instance_public_ip" {
  description = "Public IP address of the ECS instance"
  value       = alicloud_instance.this.public_ip
}

output "instance_private_ip" {
  description = "Private IP address of the ECS instance"
  value       = alicloud_instance.this.private_ip
}
