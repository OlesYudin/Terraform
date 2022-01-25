# Output VPC CIDR
output "vpc_ip" {
  value = module.vpc.vpc_ip
}
# Output Subnet CIDR
output "subnet_ip" {
  value = module.vpc.subnet_ip
}
# Output Public IP of EC2
output "ec2_public_ip" {
  value = module.ec2.ec2_public_ip
}
# Output Private IP of EC2
output "ec2_private_ip" {
  value = module.ec2.ec2_private_ip
}
