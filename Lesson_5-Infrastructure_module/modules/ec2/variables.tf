# Environment
variable "env" {
  default = "dev"
}
# Region
variable "default_region" {
  default = "us-east-2"
}
# Instance type
variable "instance_type" {
  default = "t2.micro"
}
# SSH key
variable "ssh_key" {
  default = "password-generator"
}
# CIDR public subnet
variable "public_subnet" {
  type = list(any)
}
# Public subnet ID
variable "subnet_id" {
  type = list(any)
}
# SG
variable "sg_id" {
  type = any
}
# IGW
variable "igw" {}
# Availability zone
variable "availability_zone" {}
