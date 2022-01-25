variable "env" {
  default = "dev"
}
# Inbound/Outbound rules of Security group thats open port to CIDR like key --> value
variable "sg_port_cidr" {
  description = "Allowed EC2 ports"
  type        = map(any)
  default = {
    "22"   = ["195.88.72.206/32", "172.31.0.0/16"]
    "80"   = ["0.0.0.0/0"]
    "8080" = ["195.88.72.206/32", "172.31.0.0/16"]
  }
}
# VPC id
variable "vpc_id" {}
