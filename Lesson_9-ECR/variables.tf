# Default region for AWS provider
variable "region" {
  type    = string
  default = "us-east-2"
}
# Default user
variable "aws_user" {
  type = string
}
# Application name
variable "app_name" {
  type = string
}
# Docker image tag
variable "image_tag" {
  type = string
}
# Working app dir
variable "working_dir" {
  type    = string
  default = "./Docker"
}
