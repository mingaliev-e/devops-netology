# Домашнее задание к занятию "15.1. Организация сети"

---
## Задание 1. Яндекс.Облако (обязательное к выполнению)

1. Создать VPC.
- Создать пустую VPC. Выбрать зону.
2. Публичная подсеть.
- Создать в vpc subnet с названием public, сетью 192.168.10.0/24.
- Создать в этой подсети NAT-инстанс, присвоив ему адрес 192.168.10.254. В качестве image_id использовать fd80mrhj8fl2oe87o4e1
- Создать в этой публичной подсети виртуалку с публичным IP и подключиться к ней, убедиться что есть доступ к интернету.
3. Приватная подсеть.
- Создать в vpc subnet с названием private, сетью 192.168.20.0/24.
- Создать route table. Добавить статический маршрут, направляющий весь исходящий трафик private сети в NAT-инстанс
- Создать в этой приватной подсети виртуалку с внутренним IP, подключиться к ней через виртуалку, созданную ранее и убедиться что есть доступ к интернету

Resource terraform для ЯО
- [VPC subnet](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_subnet)
- [Route table](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_route_table)
- [Compute Instance](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/compute_instance)
---


[terraform](terraform/main.tf)

Сначала создаем nat-instance и public-vm

Далее подключаемся к public-vm, генерируем ssh ключ, добавляем его в файл keys 

После этого можно поднять private-vm

![image](https://github.com/mingaliev-e/Homework/assets/111060072/fba0b764-2f1c-4046-9504-25dee510f1e1)

![image](https://github.com/mingaliev-e/Homework/assets/111060072/4d860346-9029-4e1e-979c-66e6cc05d2e5)

![image](https://github.com/mingaliev-e/Homework/assets/111060072/b49731d2-0b2f-4297-9350-47800df6a7b5)

![image](https://github.com/mingaliev-e/Homework/assets/111060072/86ae6559-39b9-4675-9f23-1300e29c7cf7)


Трафик с private-vm идет через nat-instance


![image](https://github.com/mingaliev-e/Homework/assets/111060072/6bfe0a8e-04bf-4c8b-92ec-bedf47b4942b)

