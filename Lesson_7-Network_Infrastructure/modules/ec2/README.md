# <div align="center">Creating EC2 instance</div>

Создание AWS EC2 instance в каждой подсети, согласно [заданой сетефой инфраструктуре](https://github.com/OlesYudin/Terraform/tree/main/Lesson_7-Network_Infrastructure/modules/vpc "сетефой инфраструктуре") с подключением [security group](https://github.com/OlesYudin/Terraform/tree/main/Lesson_7-Network_Infrastructure/modules/Security-group "security group").

## Description of EC2:

1. Bastion Host](https://github.com/OlesYudin/Terraform/blob/main/Lesson_7-Network_Infrastructure/modules/ec2/main.tf "Bastion Host") in [Public Subnet](https://github.com/OlesYudin/Terraform/blob/main/Lesson_7-Network_Infrastructure/modules/vpc/main.tf "Public Subnet")
2. 2 EC2 instance in Private Subnet that created by [ASG](https://github.com/OlesYudin/Terraform/blob/main/Lesson_7-Network_Infrastructure/modules/ec2/asg.tf "ASG")

## Connection to EC2 in Private Subnet:

1. Connect to Bastion Host use your private key
2. On bastion host generate SSH-key `ssh-keygen -t ed25519 -b 512 -f ~/.ssh/key_name -C 'Comment in public key'`
3. Give public key to destination point (EC2 in private subnet) `ssh-copy-id -i ~/.ssh/key_name.pub ubuntu@private_ip`. Username of user in instance **'ubuntu'**
4. Connect to instance `ssh -i ~/.ssh/key_name ubuntu@private_ip`

## Instance settings:

| Value                  | Default                                                                                                                                                                                                                                                                  |
| ---------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Region                 | [us-east-2](https://github.com/OlesYudin/Terraform/blob/main/Lesson_7-Network_Infrastructure/modules/ec2/variables.tf#:~:text=variable%20%22default_region%22%20%7B,%7D "us-east-2")                                                                                     |
| AMI                    | [Ubuntu 16.04 Server](https://github.com/OlesYudin/Terraform/blob/main/Lesson_7-Network_Infrastructure/modules/ec2/data.tf "Ubuntu 16.04 Server")                                                                                                                        |
| Environment            | [Developer](https://github.com/OlesYudin/Terraform/blob/main/Lesson_7-Network_Infrastructure/modules/ec2/variables.tf#:~:text=variable%20%22env%22%20%7B,%7D "Developer")                                                                                                |
| Count                  | 1 instance in 1 AZ, as default [**2**](<https://github.com/OlesYudin/Terraform/blob/main/Lesson_7-Network_Infrastructure/modules/ec2/main.tf#:~:text=count%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%3D%20length(var.public_subnet)> "2")                    |
| Key for SSH connection | [your_privare_AWS_key.pem](https://github.com/OlesYudin/Terraform/blob/main/Lesson_7-Network_Infrastructure/modules/ec2/variables.tf#:~:text=variable%20%22ssh_key%22%20%7B,%7D "your_privare_AWS_key.pem")                                                              |
| Download packages      | [apache2](https://httpd.apache.org/ "apache2")                                                                                                                                                                                                                           |
| Subnet                 | Create in [VPC](https://github.com/OlesYudin/Terraform/tree/main/Lesson_7-Network_Infrastructure/modules/vpc "VPC") module                                                                                                                                               |
| Security Group         | Open [22, 80, 8080](https://github.com/OlesYudin/Terraform/tree/main/Lesson_7-Network_Infrastructure/modules/Security-group#:~:text=in%20Security%20Group)-,Protocol,Public%20IP%20of%20my%20provider,-resource%20%22aws_security_group%22%20%22sg "22, 80, 8080") ports |

ssh-keygen -t ed25519 -b 512 -f ~/.ssh/key

eval "$(ssh-agent)"
ssh-add ~/.ssh/key
ssh-copy-id -i ~/.ssh/key ubuntu@172.31.11.208
ssh -i ~/.ssh/key ubuntu@172.31.11.208

nano ~/.ssh/private_ec2

chmod 400 ~/.ssh/privare_ec2
