variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "tf-ecs-vpc"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "172.16.0.0/12"
}

variable "vswitch_name" {
  description = "Name of the VSwitch"
  type        = string
  default     = "tf-ecs-vswitch"
}

variable "vswitch_cidr" {
  description = "CIDR block for the VSwitch"
  type        = string
  default     = "172.16.0.0/21"
}

variable "availability_zone" {
  description = "Availability zone to create the VSwitch and resources"
  type        = string
  default     = "us-west-1a"
}

