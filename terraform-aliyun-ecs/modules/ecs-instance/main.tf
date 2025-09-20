data "alicloud_instance_types" "this" {
  cpu_core_count = 2
  memory_size    = 4
  availability_zone = var.availability_zone
  # 可以根据需要添加其他过滤器，如实例系列
}

# 查询镜像，例如选择一种常见的Linux镜像
data "alicloud_images" "this" {
  name_regex  = "^ubuntu_18.*64" # 以 Ubuntu 18.04 为例，可按需修改
  most_recent = true
  owners      = "system"
}

# 创建ECS实例
resource "alicloud_instance" "this" {
  instance_name              = var.instance_name
  instance_type              = data.alicloud_instance_types.this.instance_types.0.id
  availability_zone          = var.availability_zone
  image_id                   = data.alicloud_images.this.images.0.id
  vswitch_id                 = var.vswitch_id
  security_groups            = [var.security_group_id]
  internet_max_bandwidth_out = var.internet_max_bandwidth_out # 分配公网IP并设置带宽
  key_name                   = var.key_name # 指定密钥对名称:cite[8]

  system_disk_category = var.system_disk_category
  system_disk_size     = var.system_disk_size

  tags = {
    Environment = var.environment
    CreatedBy   = "Terraform"
  }
}
