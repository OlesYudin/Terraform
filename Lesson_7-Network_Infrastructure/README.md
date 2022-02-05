# <div align="center">Создание модульной инфраструктуры с помощью Terraform</div>

### Структура проекта:

[`ec2`](https://github.com/OlesYudin/Terraform/tree/main/Lesson_7-Network_Infrastructure/modules/ec2 "ec2") - создание AWS EC2 instance

[`Security-group`](https://github.com/OlesYudin/Terraform/tree/main/Lesson_7-Network_Infrastructure/modules/Security-group "Security-group") - создание Security Group для Virtual Private Cloud

[`vpc`](https://github.com/OlesYudin/Terraform/tree/main/Lesson_7-Network_Infrastructure/modules/vpc "vpc") - создание сети

### Типичная структура файлов:

[`data.tf`](https://www.terraform.io/language/data-sources "data.tf") - источник данных для Tarraform, которая может быть взята не из Terraform файлов

`main.tf` - описание ифраструктуры как кода

[`outputs.tf`](https://www.terraform.io/language/values/outputs "outputs.tf") - вывод данных

[`variables.tf`](https://www.terraform.io/language/values/variables "variables.tf") - Terraform переменные

### <div align="center">Схема сети</div>

<p align="center">
  <img src="https://github.com/OlesYudin/Terraform/blob/main/Lesson_7-Network_Infrastructure/images/Network%20infrastructure%20DEMO_2.png" alt="Scheme of creation VPC in AWS"/>
</p>
