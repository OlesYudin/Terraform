output "vpc_id" {
  value = aws_vpc.vpc
}
output "vpc_ip" {
  value = aws_vpc.vpc.cidr_block
}
output "subnet_id" {
  value = aws_subnet.public_subnet.*.id
}
output "subnet_ip" {
  value = aws_subnet.public_subnet.*.cidr_block
}
output "public_subnet" {
  value = var.public_subnet
}
output "igw" {
  value = aws_internet_gateway.igw
}
# Availability zone
output "availability_zone" {
  value = data.aws_availability_zones.available
}
