variable "vpc_name" {
  type = string
}
variable "vpc_cidr" {
  type = string
}
variable "pub1_cidr" {
  type = string
}
variable "pub2_cidr" {
  type = string
}

variable "priv1_cidr" {
  type = string
}

variable "priv2_cidr" {
  type = string
}

variable "region" {
  type = string
}

variable "WS" {
  type = string

}

variable AMI {
  type        = string
}

variable db_Pass{
type  = string

}

variable db_User {
  type        = string

}
