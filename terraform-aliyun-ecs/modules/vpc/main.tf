resource "alicloud_vpc" "this" {
  vpc_name   = var.vpc_name
  cidr_block = var.vpc_cidr
}

resource "alicloud_vswitch" "this" {
  vswitch_name = var.vswitch_name
  vpc_id       = alicloud_vpc.this.id
  cidr_block   = var.vswitch_cidr
  zone_id      = var.availability_zone
}
