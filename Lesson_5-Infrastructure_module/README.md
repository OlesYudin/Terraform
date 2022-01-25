# <div align="center">Создание модульной инфраструктуры с помощью Terraform</div>

### Структура проекта:

- [`ec2`](https://github.com/OlesYudin/Terraform/tree/main/Lesson_5-Infrastructure_module/modules/ec2 "ec2") - создание AWS EC2 instance

- [`Security-group`](https://github.com/OlesYudin/Terraform/tree/main/Lesson_5-Infrastructure_module/modules/Security-group "Security-group") - создание Security Group для Virtual Private Cloud

- [`vpc`](https://github.com/OlesYudin/Terraform/tree/main/Lesson_5-Infrastructure_module/modules/vpc "vpc") - создание сети

### Типичная структура файлов:

- [`data.tf`](https://www.terraform.io/language/data-sources "data.tf") - источник данных для Tarraform, которая может быть взята не из Terraform файлов

- `main.tf` - описание ифраструктуры как кода ([IaC](https://learn.hashicorp.com/tutorials/terraform/infrastructure-as-code "IaC"))

- [`outputs.tf`](https://www.terraform.io/language/values/outputs "outputs.tf") - вывод данных

- [`variables.tf`](https://www.terraform.io/language/values/variables "variables.tf") - Terraform переменные

### <div align="center">Схема сети</div>

<p align="center">
  <img src="https://github.com/OlesYudin/Terraform/blob/main/Lesson_5-Infrastructure_module/images/Network%20scheme.png" alt="Scheme of creation VPC in AWS"/>
</p>
