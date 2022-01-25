# <div align="center">Creating EC2 instance</div>

Создание AWS EC2 instance в каждой подсети, согласно [заданой сетефой инфраструктуре](https://link.com "сетефой инфраструктуре") с подключением [security group](https://link.com "security group").

## Instance settings:

| Value                  | Default                                        |
| ---------------------- | ---------------------------------------------- |
| AMI                    | Ubuntu 16.04 Server                            |
| Region                 | us-east-2                                      |
| Key for SSH connection | your_privare_AWS_key.pem                       |
| Download packages      | apache2                                        |
| Subnet                 | Create in [VPC](https://link.com "VPC") module |
