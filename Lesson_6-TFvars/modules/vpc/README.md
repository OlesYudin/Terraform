# <div align="center">Создание сети</div>

### Переменные:

- env - окружение проекта
- cidr_vpc - CIDR блок для VPC
- public_subnet - CIDR блоки для публичных подсетей

### Что необходимо создать:

1. `aws_vpc` - Создает Virtual Private Cloud (VPC)
2. `aws_subnet` - Создает подсети в VPC
3. `aws_internet_gateway` - Нужен для того, что бы в VPC был интернет
4. `aws_route_table` - Создает таблицу маршрутизации от VPC до Internet Gateway (IGW)
5. `aws_route_table_association` - Необходим для явного представления таблицы маршрутизации с подсетью

### Схема сети

(url "Scheme of creation VPC in AWS")

### [1. Создание VPC](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc "1. Создание VPC")

```
resource "aws_vpc" "vpc" {
  cidr_block       = var.cidr_vpc
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name  = "VPC"
  }
}
```

`cidr_block` - указываем какой будет адрес VPC. В моем случае, значение берется из переменной и получает вид _172.31.0.0/16_
`instance_tenancy` - аренда инстансов в VPC, указано _default_ что бы не платить за отдельный выделенный хост
`enable_dns_hostnames` - включения/отключения DNS-имен хостов в VPC
`enable_dns_support` - включиния/отключения поддержку DNS в VPC

### [2. Создание подсетей (Subnets)](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet "2. Создание подсетей (Subnets)")

```
resource "aws_subnet" "public_subnet" {
  count                   = length(var.public_subnet)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = cidrsubnet(var.cidr_vpc, 8, count.index + 1)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name              = "Subnet"
  }

  depends_on = [aws_vpc.vpc]
}
```

`count` - подсчет количества подсетей, что бы понимать сколько подсетей создавать. Количество считается из переменной _public_subnet_
`vpc_id` - в какой VPC будут создаваться подсети
`cidr_block` - какой CIDR будет иметь подсеть. В моем случае я использую функцию [cidrsubnet](https://www.terraform.io/language/functions/cidrsubnet "cidrsubnet") в которой берется значение из переменной _public_subnet_ добавляется префикс 8 (/16 --> /24), добавляется +1 к подсети (172.31.0.0 --> 172.31.1.0)
`availability_zone` - выбор зоны доступности, для того что бы созданная инфраструктура находилась в физически разных зонах (Повышение отказоустойчивости). Для этого, необходимо создать [data_source](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones "data_source"), чтобы проверить какие есть доступные зоны в регионе. Далее присваиваем каждой подсети свою Availability Zone (AZ)
`map_public_ip_on_launch` - используется для публичных подсетей, что бы выдавать подсети внешний IP адресс
`depends_on` - указываем когда можно создавать подсеть. В моем случае, если VPC создано - начинает создаваться subnet

### [3. Создание Internet Gateway (IGW)](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway "Создание Internet Gateway (IGW)")

Необходим для того, что бы в создзанной ранее VPC был интернет

```
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "IGW"
  }
}
```

`vpc_id` - указываем для какой VPC будет подключен IGW

### [4. Создание таблицы маршрутизации (Route Table)](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table "Создание таблицы маршрутизации (Route Table)")

Необходим для маршрутизации трафик в созданной VPC

```
resource "aws_route_table" "publicroute" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"                 # Allow all to IN/OUT traffic
    gateway_id = aws_internet_gateway.igw.id # Attach to IGW and Internet will work
  }

  tags = {
    Name = "PublicRouteTable"
  }

  depends_on = [aws_internet_gateway.igw]
}
```

`vpc_id` - указываем для какой VPC будет созданно правила маршрутизации
`route` - в данном блоке указывается список обьектов маршрута. Если оставить данный блок пустым - удаляться все управляемые маршруты для VPC
`cidr_block` - указывает на то, для кого будет доступна маршрутизация на вход и выход. В моем случае указанно разрешить всем трафик на вход и выход
`gateway_id` - Идентификатор интернет-шлюза VPC или виртуального частного шлюза. Указываем созданный IGW, что бы понимать откуда ходить в интернет
`depends_on` - пока не будет создан IGW, таблица маршрутизации не запустится

### [5. Создание связи между таблицей маршрутизации и подсетями (Route Table Association)](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association "5. Создание связи между таблицей маршрутизации и подсетями (Route Table Association)")

Предоставляет ресурс для создания связи между таблицей маршрутов и подсетью или таблицей маршрутов и интернет-шлюзом или виртуальным частным шлюзом.

```
resource "aws_route_table_association" "publicrouteAssociation" {
  count          = length(var.public_subnet)
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.publicroute.id

  depends_on = [aws_subnet.public_subnet, aws_route_table.publicroute]
}
```

`count` - подсчет количества подстей для которых будет создана связь
`subnet_id` - указания ID для создания ассоциации. В моем случае 2 подсети, по этому я использую _[count.index]_ для подсчета всех подсетей
`route_table_id` - указания из какой таблицы маршрутизации будет сделана связь между подсетью и таблицей маршрутизации (ассоциация)
`depends_on` - пока не будет создано подсети и таблицу маршрутизации, Route Table Association не будет создан
