resource "aws_instance" "webserver" {
  count                  = length(var.public_subnet)             # count numbers of public subnets
  ami                    = data.aws_ami.ubuntu.id                # ubuntu 16.04
  instance_type          = var.instance_type                     # instant params
  subnet_id              = var.subnet_id[count.index]            # attach EC2 to subnet
  vpc_security_group_ids = var.sg_id.*.id                        # attach sec group
  key_name               = var.ssh_key                           # key for SSH connection
  user_data              = file("./modules/ec2/shell/apache.sh") # install apache

  tags = {
    Name        = "Webserver-${count.index + 1}"
    AZ          = "${var.availability_zone.names[count.index]}"
    Owner       = "Student"
    Environment = var.env
  }
}
