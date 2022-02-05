# Output VPC CIDR
output "vpc_ip" {
  value = module.vpc.vpc_ip
}
# Output Public Elastic IP
output "eip_public_ip" {
  value = module.vpc.eip_public_ip
}
# Output DNS name of ALB
output "alb_dns" {
  value = module.vpc.alb_dns
}
output "bastion_public_ip" {
  value = module.ec2.bastion_public_ip
}

# # Output Public Subnet CIDR
# output "public_subnet_ip" {
#   value = module.vpc.public_subnet_ip
# }
# # Output Private Subnet CIDR
# output "private_subnet_ip" {
#   value = module.vpc.private_subnet_ip
# }
# # Output Public IP of EC2
# output "ec2_public_ip" {
#   value = module.ec2.ec2_public_ip
# }
# # Output Private IP of EC2
# output "ec2_private_ip" {
#   value = module.ec2.ec2_private_ip
# }
