output "ec2_public_ip" {
  value = aws_instance.webserver.*.public_ip
}
output "ec2_private_ip" {
  value = aws_instance.webserver.*.private_ip
}
