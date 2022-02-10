# <div align="center">Создание ECR с помощью Terraform</div>

### Структура проекта:

- [`data.tf`](https://github.com/OlesYudin/Terraform/tree/main/Lesson_9-ECR/data.tf "data.tf") - сбор данных ecr_reposiroty

- [`ecr.tf`](https://github.com/OlesYudin/Terraform/tree/main/Lesson_9-ECR/ecr.tf "ecr.tf") - создание ECR и политик для репозитория

- [`init_build.tf`](https://github.com/OlesYudin/Terraform/tree/main/Lesson_9-ECR/init_build.tf "init_build.tf") - ресурс для выгрузки контейнера в AWS

- [`main.tf`](https://github.com/OlesYudin/Terraform/tree/main/Lesson_9-ECR/main.tf "main.tf") - объявление провайдера

- [`output.tf`](https://github.com/OlesYudin/Terraform/tree/main/Lesson_9-ECR/output.tf "output.tf") - выходные данные проекта

- [`variables.tf`](https://github.com/OlesYudin/Terraform/tree/main/Lesson_9-ECR/variables.tf "variables.tf") - переменные использованные в проекте

### [Elastic Container Registry](https://aws.amazon.com/ru/ecr/ "Глобальные переменные")

ECR это аналог Docker Hub, то есть это место, где можно хранить docker-образы. Изначально создается репозиторий в котором можно настроить различные политики, такие как **life cycle police** и **security policy**. Далее можно загружать образы в необходимый репозиторий.

#### Структура файла [ecr.tf](https://github.com/OlesYudin/Terraform/tree/main/Lesson_9-ECR/ecr.tf "ecr.tf")

```
resource "aws_ecr_repository" "ecr_repository" {
  name                 = var.app_name
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
}
```

Данный блок кода создает репозиторий в AWS Cloud Provider. (["aws_ecr_repository"](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository "aws_ecr_repository"))

- `name` - имя репозитория
- `image_tag_mutability` - Настройка изменчивости тегов для репозитория
- `image_scanning_configuration` - Блок конфигурации, определяющий конфигурацию сканирования изображений для репозитория

```
resource "aws_ecr_lifecycle_policy" "test_lifecycle_policy" {
  repository = aws_ecr_repository.ecr_repository.name

  policy = <<EOF
    {
        "rules": [
            {
                "rulePriority": 1,
                "description": "Keep only 3 images",
                "selection": {
                    "tagStatus": "any",
                    "countType": "imageCountMoreThan",
                    "countNumber": 3
                },
                "action": {
                    "type": "expire"
                }
            }
        ]
    }
    EOF
}
```

Данный блок кода создает жизненный цикл репозитория, в нем можно указать такие важные характеристики например, количество сохраняемых образов, составить график удаления образов и тд.

- `repository` - имя репозитория к котрому будет применена политика
- `policy` - политика применяемая к репозиторию в формате JSON (["подробнее на AWS"](https://docs.aws.amazon.com/AmazonECR/latest/userguide/LifecyclePolicies.html#lifecycle_policy_parameters "подробнее на AWS"))

#### Структура файла [init_build.tf](https://github.com/OlesYudin/Terraform/tree/main/Lesson_9-ECR/init_build.tf "init_build.tf")

```
resource "null_resource" "init_build_container" {
  provisioner "local-exec" {
    command     = "sh file_to_execute.sh"
    working_dir = "./app_dir"
    environment = {
      region      = var.region
      app_name    = var.app_name
      image_tag   = var.image_tag
    }
  }
}
```

В данном файле есть блок ["null_resource"](https://github.com/OlesYudin/Terraform/tree/main/Lesson_9-ECR/init_build.tf "null_resource") который выполняет shell команды на локальном компьютере.

- ["`provisioner local-exec`"](https://www.terraform.io/language/resources/provisioners/local-exec "local-exec") - это блок, который вызывает локальный исполняемый файл после создания ресурса. Вызывается процесс на машине, на которой работает Terraform (не на ресурсе).
- `command` - команда для выполнения на локальной машине
- `working_dir` - указывает рабочую дирикторию в которой будет выполнятся команда
- `environment` - блок для задания переменных окружения (ключ --> значение)

#### Структура файла [docker.sh](https://github.com/OlesYudin/Terraform/tree/main/Lesson_9-ECR/docker.sh "docker.sh")

```
aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin `id_of-you_account`.dkr.ecr.us-east-2.amazonaws.com
docker build -t `id_of-you_account`.dkr.ecr.`us-east-2`.amazonaws.com/`app_name`:v1 .
docker push `id_of-you_account`.dkr.ecr.`us-east-2`.amazonaws.com/`app_name`:v1
```

**Выполнение скрипта:**

1. Аутентификация в AWS ECR;
2. Локальная сборка docker-образа;
3. Выгрузка docker-образа в AWS.
