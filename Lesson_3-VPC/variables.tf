variable "env" {
  default = "dev"
}
variable "default_region" {
  default = "us-east-2"
}
variable "instance_type" {
  default = "t2.micro"
}
variable "ssh_key" {
  default = "password-generator"
}

# Inbound/Outbound rules of Security group thats open port to CIDR like key --> value
variable "sg_port_cidr" {
  description = "Allowed EC2 ports"
  type        = map(any)
  default = {
    "22"   = ["X.X.X.X/32", "172.31.0.0/16"] # Use your IP
    "80"   = ["0.0.0.0/0"]
    "8080" = ["0.0.0.0/0"]
  }
}

# VPC
variable "cidr_vpc" {
  description = "CIDR of VPC"
  type        = string
  default     = "172.31.0.0/16"
}
# Public Subnet
variable "public_subnet" {
  type = list(string)
  default = [
    "172.31.1.0/24",
    "172.31.2.0/24"
  ]
}
