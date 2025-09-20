output "security_group_id" {
  description = "ID of the created security group"
  value       = alicloud_security_group.this.id
}
