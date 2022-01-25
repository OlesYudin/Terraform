# <div align="center">Creating EC2 instance</div>

Создание AWS EC2 instance в каждой подсети, согласно [заданой сетефой инфраструктуре](https://github.com/OlesYudin/Terraform/tree/main/Lesson_5-Infrastructure_module/modules/vpc "сетефой инфраструктуре") с подключением [security group](https://github.com/OlesYudin/Terraform/tree/main/Lesson_5-Infrastructure_module/modules/Security-group "security group").

## Instance settings:

| Value                  | Default                                                                                                                                                                                                    |
| ---------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| AMI                    | [Ubuntu 16.04 Server](https://github.com/OlesYudin/Terraform/blob/main/Lesson_5-Infrastructure_module/modules/ec2/data.tf "Ubuntu 16.04 Server")                                                           |
| Region                 | [us-east-2](https://github.com/OlesYudin/Terraform/blob/main/Lesson_5-Infrastructure_module/modules/ec2/variables.tf#:~:text=variable%20%22default_region%22%20%7B,%7D "us-east-2")                        |
| Key for SSH connection | [your_privare_AWS_key.pem](https://github.com/OlesYudin/Terraform/blob/main/Lesson_5-Infrastructure_module/modules/ec2/variables.tf#:~:text=variable%20%22ssh_key%22%20%7B,%7D "your_privare_AWS_key.pem") |
| Download packages      | [apache2](https://httpd.apache.org/ "apache2")                                                                                                                                                             |
| Subnet                 | Create in [VPC](https://github.com/OlesYudin/Terraform/tree/main/Lesson_5-Infrastructure_module/modules/vpc "VPC") module                                                                                  |
