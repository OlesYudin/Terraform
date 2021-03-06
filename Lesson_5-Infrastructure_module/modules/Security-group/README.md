# <div align="center">Создание динамической Security Group</div>

## Таблица открытых портов (Policy of opened ports in [Security Group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group "Security Group"))

| Protocol                                                                                                                                                                                                                                                  | Port | IP-address                                                                                                                                                                                                                                         |
| --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [SSH](https://datatracker.ietf.org/doc/html/rfc4253 "SSH")                                                                                                                                                                                                | 22   | [Public IP](https://2ip.ru/ "Public IP") of my provider, created [VPC](https://github.com/OlesYudin/Terraform/blob/main/Lesson_5-Infrastructure_module/modules/vpc/variables.tf#:~:text=default%20%20%20%20%20%3D%20%22-,172.31.0.0/16,-%22 "VPC") |
| [HTTP](https://datatracker.ietf.org/doc/html/rfc2616 "HTTP")                                                                                                                                                                                              | 80   | Allow all IPv4 (0.0.0.0/0)                                                                                                                                                                                                                         |
| [Jenkins](https://www.jenkins.io/doc/book/installing/initial-settings/#:~:text=Runs%20Jenkins%20listener%20on%20port,The%20default%20is%20port%208080.&text=This%20option%20does%20not%20impact,specified%20in%20the%20global%20configuration. "Jenkins") | 8080 | Public IP of my provider                                                                                                                                                                                                                           |

```
resource "aws_security_group" "sg" {
  name        = "Security-group"
  description = "Security group description"
  vpc_id      = var.vpc_id.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
```

`name` - Название Security Group (SG)
`description` - Описание SG
`vpc_id` - присвоение к SG VPC

**Ingress** - блок для задания правил _Inbound (Входящего)_ трафика

**Egress** - блок для задания правил _Outbound (Исходящего)_ трафика

`from_port` - номер начального порта для которого будут применяться правила

`to_port` - номер последнего порта для которого будут применяться правила

`protocol` - Тип протокола. "**-1**" означает применить для **всех** портов (в таком случае, _from_port_ и _to_port_ присвоить _0_)

`cidr_blocks` - список CIDR блоков для которых будет разрешенно подключение IPv4

`ipv6_cidr_blocks` - список CIDR блоков для которых будет разрешенно подключение IPv6

## Динамическое создание _ingress_ rules

```
  dynamic "ingress" {
    for_each = var.sg_port_cidr
    content {
      from_port   = ingress.key
      to_port     = ingress.key
      protocol    = "tcp"
      cidr_blocks = ingress.value
    }
  }
```

`for_each` - цикл перебора портов

`content` - вход в цикл, где будет определенны правила для портов

`from_port`, `to_port`, `cidr_blocks` - вызывается из переменной для определения открытых портов. В моем случае, для переменной используется [кортеж (map) ключ-значение (key-value)](https://github.com/OlesYudin/Terraform/blob/main/Lesson_5-Infrastructure_module/modules/Security-group/variables.tf#:~:text=like%20key%20%2D%2D%3E%20value-,variable%20%22sg_port_cidr%22%20%7B,%7D,-%23%20VPC%20id "кортеж (map) ключ-значение (key-value)"). В _key_ находится порт, в _value_ находится CIDR блок
