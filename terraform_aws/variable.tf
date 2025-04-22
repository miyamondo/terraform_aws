variable "stg_menta_ami_id" {
  type    = string
  default = "ami-023ff3d4ab11b2525"
}

variable "stg_menta_instance_type" {
  type    = string
  default = "t2.micro"
}

variable "stg_menta_hostzone_id" {
  type    = string
  default = "Z05550272XA47BMMA24AF"
}

variable "stg_menta_domain" {
  type    = string
  default = "udemytasty-miya.site"
}

variable "stg_menta_rds_instanceclass" {
  type    = string
  default = "db.r5.xlarge"
}
