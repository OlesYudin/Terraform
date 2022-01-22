resource "aws_instance" "web1" {
  count                  = length(var.public_subnet)                # count numbers of public subnets
  ami                    = data.aws_ami.ubuntu.id                   # ubuntu 16.04
  instance_type          = var.instance_type                        # instant params
  subnet_id              = aws_subnet.public_subnet[count.index].id # attach EC2 to subnet
  vpc_security_group_ids = [aws_security_group.sg.id]               # attach sec group
  key_name               = var.ssh_key                              # key for SSH connection
  user_data              = file("./shell/apache.sh")                # install apache

  tags = {
    Name        = "Webserver-${count.index + 1}"
    AZ          = "${data.aws_availability_zones.available.names[count.index]}"
    Owner       = "Student"
    Environment = var.env
  }

  depends_on = [aws_internet_gateway.igw]
}
