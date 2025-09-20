variable "aliyun_region" {
  description = "The Alibaba Cloud region to deploy resources (选择美国区域)"
  type        = string
  default     = "us-west-1"
}

variable "aliyun_access_key" {
  description = "Alibaba Cloud Access Key ID"
  type        = string
  sensitive   = true
}

variable "aliyun_secret_key" {
  description = "Alibaba Cloud Access Key Secret"
  type        = string
  sensitive   = true
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be one of: dev, staging, prod."
  }
}

variable "key_name" {
  description = "The name of an existing SSH key pair in the same region to use for the ECS instances"
  type        = string
}
