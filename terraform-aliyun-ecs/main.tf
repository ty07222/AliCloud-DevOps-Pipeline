provider "alicloud" {
  access_key = ""
  secret_key = ""
  region     = "us-east-1"
}

data "alicloud_images" "aliyun_linux" {
  owners      = "system"
  name_regex  = "^aliyun_3.*64"
  most_recent = true
}

resource "alicloud_vpc" "main" {
  vpc_name   = "tf-ecs-vpc"
  cidr_block = "172.16.0.0/12"
}

resource "alicloud_vswitch" "main" {
  vswitch_name = "tf-ecs-vswitch"
  vpc_id       = alicloud_vpc.main.id
  cidr_block   = "172.16.0.0/21"
  zone_id      = "us-east-1b"
}

resource "alicloud_security_group" "main" {
  security_group_name = "ecs-sg"
  vpc_id              = alicloud_vpc.main.id
}

resource "alicloud_security_group_rule" "allow_ssh" {
  type              = "ingress"
  ip_protocol       = "tcp"
  policy            = "accept"
  port_range        = "22/22"
  priority          = 1
  security_group_id = alicloud_security_group.main.id
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_instance" "ecs_01" {
  instance_name              = "us-ecs-01"
  instance_type              = "ecs.c7.large"
  availability_zone          = "us-east-1b"
  image_id                   = data.alicloud_images.aliyun_linux.images.0.id
  vswitch_id                 = alicloud_vswitch.main.id
  security_groups            = [alicloud_security_group.main.id]
  internet_max_bandwidth_out = 5
  system_disk_category       = "cloud_essd"
  system_disk_size           = 20
}

resource "alicloud_instance" "ecs_02" {
  instance_name              = "us-ecs-02"
  instance_type              = "ecs.c7.large"
  availability_zone          = "us-east-1b"
  image_id                   = data.alicloud_images.aliyun_linux.images.0.id
  vswitch_id                 = alicloud_vswitch.main.id
  security_groups            = [alicloud_security_group.main.id]
  internet_max_bandwidth_out = 5
  system_disk_category       = "cloud_essd"
  system_disk_size           = 20
}
