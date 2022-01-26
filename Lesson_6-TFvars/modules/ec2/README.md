# <div align="center">Creating EC2 instance</div>

Создание AWS EC2 instance в каждой подсети, согласно [заданой сетефой инфраструктуре](https://github.com/OlesYudin/Terraform/tree/main/Lesson_6-TFvars/modules/vpc "сетефой инфраструктуре") с подключением [security group](https://github.com/OlesYudin/Terraform/tree/main/Lesson_6-TFvars/modules/Security-group "security group").

## Instance settings:

| Value                  | Default                                                                                                                                                                                     |
| ---------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Region                 | [Dev](https://github.com/OlesYudin/Terraform/blob/main/Lesson_6-TFvars/dev.auto.tfvars#:~:text=env%20%3D%20%22-,Dev,-%22 "Dev")                                                             |
| AMI                    | [Ubuntu 16.04 Server](https://github.com/OlesYudin/Terraform/blob/main/Lesson_6-TFvars/modules/ec2/data.tf "Ubuntu 16.04 Server")                                                           |
| Region                 | [us-east-1](https://github.com/OlesYudin/Terraform/blob/main/Lesson_6-TFvars/dev.auto.tfvars#:~:text=region%20%3D%20%22-,us%2Deast%2D1,-%22 "us-east-1")                                    |
| Key for SSH connection | [your_privare_AWS_key.pem](https://github.com/OlesYudin/Terraform/blob/main/Lesson_6-TFvars/modules/ec2/variables.tf#:~:text=variable%20%22ssh_key%22%20%7B,%7D "your_privare_AWS_key.pem") |
| Download packages      | [apache2](https://httpd.apache.org/ "apache2")                                                                                                                                              |
| Subnet                 | Create in [VPC](https://github.com/OlesYudin/Terraform/tree/main/Lesson_6-TFvars/modules/vpc "VPC") module                                                                                  |
