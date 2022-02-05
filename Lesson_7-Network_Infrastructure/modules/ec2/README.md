# <div align="center">Creating EC2 instance</div>

Создание AWS EC2 instance в каждой подсети, согласно [заданой сетефой инфраструктуре](https://github.com/OlesYudin/Terraform/tree/main/Lesson_7-Network_Infrastructure/modules/vpc "сетефой инфраструктуре") с подключением [security group](https://github.com/OlesYudin/Terraform/tree/main/Lesson_7-Network_Infrastructure/modules/Security-group "security group").

## Description of EC2:

1. [Bastion Host](https://github.com/OlesYudin/Terraform/blob/main/Lesson_7-Network_Infrastructure/modules/ec2/main.tf#:~:text=Blame-,resource%20%22aws_instance%22%20%22bastion%22%20%7B,%7D,-%23%20resource%20%22aws_instance%22%20%22webserver "Bastion Host") in [Public Subnet](https://github.com/OlesYudin/Terraform/blob/main/Lesson_7-Network_Infrastructure/modules/vpc/variables.tf#:~:text=%22-,172.31.2.0/24,-%22 "Public Subnet")
2. 2 EC2 instance in Private Subnet that created by [ASG](https://github.com/OlesYudin/Terraform/blob/main/Lesson_7-Network_Infrastructure/modules/ec2/asg.tf "ASG")

## Connection to EC2 in Private Subnet:

1. Connect to Bastion Host use your private key
2. On bastion host generate SSH-key `ssh-keygen -t ed25519 -b 512 -f ~/.ssh/key_name -C 'Comment in public key'`
3. Give public key to destination point (EC2 in private subnet) `ssh-copy-id -i ~/.ssh/key_name.pub ubuntu@private_ip`. Username of user in instance **'ubuntu'**
4. Connect to instance `ssh -i ~/.ssh/key_name ubuntu@private_ip`

## Instance settings of [Bastion Host](https://github.com/OlesYudin/Terraform/blob/main/Lesson_7-Network_Infrastructure/modules/ec2/main.tf#:~:text=Blame-,resource%20%22aws_instance%22%20%22bastion%22%20%7B,%7D,-%23%20resource%20%22aws_instance%22%20%22webserver "Bastion Host"):

| Value                  | Default                                                                                                                                                                                                                           |
| ---------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Region                 | [us-east-2](https://github.com/OlesYudin/Terraform/blob/main/Lesson_7-Network_Infrastructure/modules/ec2/variables.tf#:~:text=variable%20%22default_region%22%20%7B,%7D "us-east-2")                                              |
| AMI                    | [Ubuntu 16.04 Server](https://github.com/OlesYudin/Terraform/blob/main/Lesson_7-Network_Infrastructure/modules/ec2/data.tf "Ubuntu 16.04 Server")                                                                                 |
| Environment            | [Developer](https://github.com/OlesYudin/Terraform/blob/main/Lesson_7-Network_Infrastructure/modules/ec2/variables.tf#:~:text=variable%20%22env%22%20%7B,%7D "Developer")                                                         |
| Count                  | 1 instance in [Public subnet (region: us-east-2b)](https://github.com/OlesYudin/Terraform/blob/main/Lesson_7-Network_Infrastructure/modules/ec2/main.tf#:~:text=var.public_subnet%5B1%5D.id "Public subnet (region: us-east-2b)") |
| Key for SSH connection | create yout own ssh-key in folder [SSH-key](https://github.com/OlesYudin/Terraform/tree/main/Lesson_7-Network_Infrastructure/modules/ec2/SSH-key "SSH-key")                                                                       |
| Download packages      | [nothing](https://github.com/OlesYudin/Terraform/blob/main/Lesson_7-Network_Infrastructure/modules/ec2/shell/bastion.sh"nothing")                                                                                                 |
| Subnet                 | Create in [VPC](https://github.com/OlesYudin/Terraform/tree/main/Lesson_7-Network_Infrastructure/modules/vpc "VPC") module                                                                                                        |
| Security Group         | Open [22](https://github.com/OlesYudin/Terraform/blob/main/Lesson_7-Network_Infrastructure/modules/ec2/main.tf#:~:text=us%2Deast%2D2b-,vpc_security_group_ids%20%3D%20var.sg_app.*.id,-%23%20attach%20sec%20group "22") ports     |

## Instance settings that create by [ASG](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group "ASG"):

| Value                  | Default                                                                                                                                                                                                                                               |
| ---------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Region                 | [us-east-2](https://github.com/OlesYudin/Terraform/blob/main/Lesson_7-Network_Infrastructure/modules/ec2/variables.tf#:~:text=variable%20%22default_region%22%20%7B,%7D "us-east-2")                                                                  |
| AMI                    | [Ubuntu 16.04 Server](https://github.com/OlesYudin/Terraform/blob/main/Lesson_7-Network_Infrastructure/modules/ec2/data.tf "Ubuntu 16.04 Server")                                                                                                     |
| Environment            | [Developer](https://github.com/OlesYudin/Terraform/blob/main/Lesson_7-Network_Infrastructure/modules/ec2/variables.tf#:~:text=variable%20%22env%22%20%7B,%7D "Developer")                                                                             |
| Count                  | 1 instance in 1 AZ, as default [**2**](<https://github.com/OlesYudin/Terraform/blob/main/Lesson_7-Network_Infrastructure/modules/ec2/main.tf#:~:text=count%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%3D%20length(var.public_subnet)> "2") |
| Key for SSH connection | create yout own ssh-key in folder [SSH-key](https://github.com/OlesYudin/Terraform/tree/main/Lesson_7-Network_Infrastructure/modules/ec2/SSH-key "SSH-key")                                                                                           |
| Download packages      | [apache2](https://httpd.apache.org/ "apache2")                                                                                                                                                                                                        |
| Subnet                 | Create in [VPC](https://github.com/OlesYudin/Terraform/tree/main/Lesson_7-Network_Infrastructure/modules/vpc "VPC") module                                                                                                                            |
| Security Group         | Open [22, 80](https://github.com/OlesYudin/Terraform/blob/main/Lesson_7-Network_Infrastructure/modules/ec2/asg.tf#:~:text=var.sg_app.id%2C%20var.sg_alb.id "22, 80") ports                                                                            |
