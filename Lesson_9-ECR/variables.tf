# Default region for AWS provider
variable "region" {
  default = "us-east-2"
}
# Default user
variable "aws_user" {
  default = "student"
}
# Application name
variable "app_name" {
  default = "password-container"
}
# Docker image tag
variable "image_tag" {
  type    = string
  default = "latest"
}
# Working app dir
variable "working_dir" {
  type    = string
  default = "./Docker"
}
