variable "instance_name" {
  description = "Name of the ECS instance"
  type        = string
  default     = "tf-ecs-instance"
}

variable "availability_zone" {
  description = "Availability zone to launch the ECS instance"
  type        = string
}

variable "vswitch_id" {
  description = "The VSwitch ID to launch the ECS instance in"
  type        = string
}

variable "security_group_id" {
  description = "The Security Group ID to attach to the ECS instance"
  type        = string
}

variable "key_name" {
  description = "The name of the SSH key pair to use for the ECS instance"
  type        = string
}

variable "internet_max_bandwidth_out" {
  description = "Maximum outgoing bandwidth to the public network, in Mbps. Value >0 will assign a public IP."
  type        = number
  default     = 5 # 设置公网带宽为5Mbps
}

variable "system_disk_category" {
  description = "Category of the system disk"
  type        = string
  default     = "cloud_efficiency" # 高效云盘
}

variable "system_disk_size" {
  description = "Size of the system disk, in GB"
  type        = number
  default     = 40
}

variable "environment" {
  description = "Environment tag"
  type        = string
  default     = "dev"
}
