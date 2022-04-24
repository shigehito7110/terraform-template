variable vpc_name {}
variable "cidr_block" {
  default = "10.0.0.0/16"
}

variable subnet_name {}
variable subnet_cidr {}
variable subnet_az {}

variable route_table_name {}

variable igw_name {}

variable ec2_name {}

variable security_group_name {}

variable allowed_ip {}