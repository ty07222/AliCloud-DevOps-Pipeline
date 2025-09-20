resource "alicloud_security_group" "this" {
  security_group_name = var.sg_name
  vpc_id = var.vpc_id
}

resource "alicloud_security_group_rule" "allow_ssh" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "22/22"
  priority          = 1
  security_group_id = alicloud_security_group.this.id
  cidr_ip           = "0.0.0.0/0" # 为安全起见，生产环境中建议限制为特定IP
}

resource "alicloud_security_group_rule" "allow_all_internal" {
  type              = "ingress"
  ip_protocol       = "all"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "-1/-1"
  priority          = 1
  security_group_id = alicloud_security_group.this.id
  cidr_ip           = var.vpc_cidr # 允许VPC内部所有通信
}
