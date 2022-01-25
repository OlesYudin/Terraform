# <div align="center">Создание модульной инфраструктуры с помощью Terraform</div>

### Структура проекта:

`[ec2](https:// "ec2")` - создание AWS EC2 instance

`[Security-group](https:// "Security-group")` - создание Security Group для Virtual Private Cloud

`[vpc](https:// "vpc")` - создание сети

### Типичная структура файлов:

`[data.tf](https://www.terraform.io/language/data-sources "data.tf")` - источник данных для Tarraform, которая может быть взята не из Terraform файлов

`main.tf` - описание ифраструктуры как кода

`[outputs.tf](https://www.terraform.io/language/values/outputs "outputs.tf")` - вывод данных

`[variables.tf](https://www.terraform.io/language/values/variables "variables.tf")` - Terraform переменные

### <div align="center">Схема сети</div>

<p align="center">
  <img src="https://" alt="Scheme of creation VPC in AWS"/>
</p>
