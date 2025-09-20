output "vpc_id" {
  description = "ID of the created VPC"
  value       = alicloud_vpc.this.id
}

output "vswitch_id" {
  description = "ID of the created VSwitch"
  value       = alicloud_vswitch.this.id
}
output "vpc_cidr" {
  description = "CIDR block of the created VPC"
  value       = alicloud_vpc.this.cidr_block
}
output "availability_zone" {
  description = "Availability zone used for resources"
  value       = var.availability_zone
}
