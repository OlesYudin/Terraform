region = "us-east-1"
# ENV
env = "Dev"
# Network
cidr_vpc = "172.41.0.0/16"
public_subnet = [
  "172.41.1.0/24",
  "172.41.2.0/24"
]
# Security group
sg_port_cidr = {
  "22"   = ["195.88.72.206/32", "172.41.0.0/16"]
  "80"   = ["0.0.0.0/0"]
  "443"  = ["0.0.0.0/0"]
  "8080" = ["195.88.72.206/32", "172.41.0.0/16"]
}
# EC2
instance_type = "t2.micro"