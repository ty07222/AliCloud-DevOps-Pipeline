variable "sg_name" {
  description = "Name of the security group"
  type        = string
  default     = "tf-ecs-sg"
}

variable "vpc_id" {
  description = "The ID of the VPC where the security group will be created"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block of the VPC for allowing internal traffic"
  type        = string
}
