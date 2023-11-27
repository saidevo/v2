variable "region" {
  type = string
}
variable "vpc_info" {
  type = object({
    name       = string
    cidr_block = string
  })
}
variable "public_subnet_info" {
  type = object({
    name              = string
    cidr_block        = string
    availability_zone = string
  })
}
variable "igw_name" {
  type = string
}
variable "rt_name" {
  type = string
}
variable "sg_name" {
  type = string
}
variable "instance_info" {
  type = object({
    instance_type = string
    name          = string
  })
}
variable "null" {
  type = string
}