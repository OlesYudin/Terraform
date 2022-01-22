resource "aws_security_group" "sg" {
  name        = "Security-group"
  description = "Security group for Password Generator"
  vpc_id      = aws_vpc.vpc.id

  # Inbound rules for 22,80,8080 ports
  # Open 22 to my IP and my VPC
  # Open 80, 8080 to all in the Internet
  dynamic "ingress" {
    for_each = var.sg_port_cidr
    content {
      from_port   = ingress.key
      to_port     = ingress.key
      protocol    = "tcp"
      cidr_blocks = ingress.value
    }
  }

  # Outbound rules for 22,80,8080 ports
  # Open 22 to my IP and my VPC
  # Open 80, 8080 to all in the Internet
  dynamic "egress" {
    for_each = var.sg_port_cidr
    content {
      from_port   = egress.key
      to_port     = egress.key
      protocol    = "tcp"
      cidr_blocks = egress.value
    }
  }

  tags = {
    Name        = "SG-${var.env}-Password_generator"
    Environment = var.env
  }
}
