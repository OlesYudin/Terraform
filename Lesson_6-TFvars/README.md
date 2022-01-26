# <div align="center">Создание модульной инфраструктуры с помощью Terraform</div>

### Структура проекта:

- [`ec2`](https://github.com/OlesYudin/Terraform/tree/main/Lesson_6-TFvars/modules/ec2 "ec2") - создание AWS EC2 instance

- [`Security-group`](https://github.com/OlesYudin/Terraform/tree/main/Lesson_6-TFvars/modules/Security-group "Security-group") - создание Security Group для Virtual Private Cloud

- [`vpc`](https://github.com/OlesYudin/Terraform/tree/main/Lesson_6-TFvars/modules/vpc "vpc") - создание сети

### Типичная структура файлов:

- [`data.tf`](https://www.terraform.io/language/data-sources "data.tf") - источник данных для Tarraform, которая может быть взята не из Terraform файлов

- `main.tf` - описание ифраструктуры как кода

- [`outputs.tf`](https://www.terraform.io/language/values/outputs "outputs.tf")` - вывод данных

- [`variables.tf`](https://www.terraform.io/language/values/variables "variables.tf")` - Terraform переменные

- [`*.auto.tfvars`](https://github.com/OlesYudin/Terraform/blob/main/Lesson_6-TFvars/dev.auto.tfvars "*.auto.tfvars") - Глобальные переменные

### [Глобальные переменные](https://www.terraform.io/cloud-docs/workspaces/variables "Глобальные переменные")

Глобальные переменные задаются в файле **_terraform.tfvars_** или если их несколько **_name.auto.tfvars_**. При использовании глобальных перменных, локальные переменные будут полностью **игнорироваться**, приоритет всегда у глобальных переменных.

#### Структура файла [name.auto.tfvars](https://github.com/OlesYudin/Terraform/blob/main/Lesson_6-TFvars/dev.auto.tfvars "*.auto.tfvars")

```
region = "us-east-1"
env = "Dev"
instance_type = "t2.micro"
```

Файл состоит из набора _ключ_ --> _значение_. Для того что бы переменные были инициализированы в корневом модуле (root module) создается файл [`variables.tf`](https://github.com/OlesYudin/Terraform/blob/main/Lesson_6-TFvars/variables.tf "variables.tf") в котором обьявляються перменные из глобальных перемен, выглядите это следующим образом

```
variable "region" {}
variable "env" {}
variable "instance_type" {}
```

В [`variables.tf`](https://github.com/OlesYudin/Terraform/blob/main/Lesson_6-TFvars/variables.tf "variables.tf") в переменные ничего не записывается, именно сюда будет ссылаться модуль и искать переменные, а уже этот файл будет ссылаться на файл **_name.auto.tfvars_**.

```
terraform init
terraform apply -var-file="название_файла_c_глобальными_переменными.auto.tfvars"
terraform apply -var-file="dev.auto.tfvars"
terraform apply -var-file="prod.auto.tfvars"
```

При использовании [`dev.auto.tfvars`](https://github.com/OlesYudin/Terraform/blob/main/Lesson_6-TFvars/dev.auto.tfvars "dev.auto.tfvars") инфраструктура создасться для Developer окружения

При использовании [`prod.auto.tfvars`](https://github.com/OlesYudin/Terraform/blob/main/Lesson_6-TFvars/prod.auto.tfvars "dev.auto.tfvars") инфраструктура создасться для Production окружения

### <div align="center">Схема сети</div>

<p align="center">
  <img src="https://github.com/OlesYudin/Terraform/blob/main/Lesson_6-TFvars/images/Network%20scheme.png" alt="Scheme of creation VPC in AWS"/>
</p>
