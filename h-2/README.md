# Домашнее задание к занятию "Вычислительные мощности. Балансировщики нагрузки"

## Задание 1. Yandex Cloud 

**Что нужно сделать**

1. Создать бакет Object Storage и разместить в нём файл с картинкой:

 - Создать бакет в Object Storage с произвольным именем (например, _имя_студента_дата_).
 - Положить в бакет файл с картинкой.
 - Сделать файл доступным из интернета.
 
2. Создать группу ВМ в public подсети фиксированного размера с шаблоном LAMP и веб-страницей, содержащей ссылку на картинку из бакета:

 - Создать Instance Group с тремя ВМ и шаблоном LAMP. Для LAMP рекомендуется использовать `image_id = fd827b91d99psvq5fjit`.
 - Для создания стартовой веб-страницы рекомендуется использовать раздел `user_data` в [meta_data](https://cloud.yandex.ru/docs/compute/concepts/vm-metadata).
 - Разместить в стартовой веб-странице шаблонной ВМ ссылку на картинку из бакета.
 - Настроить проверку состояния ВМ.
 
3. Подключить группу к сетевому балансировщику:

 - Создать сетевой балансировщик.
 - Проверить работоспособность, удалив одну или несколько ВМ.
4. (дополнительно)* Создать Application Load Balancer с использованием Instance group и проверкой состояния.Создать в этой приватной подсети виртуалку с внутренним IP, подключиться к ней через виртуалку, созданную ранее, и убедиться, что есть доступ к интернету.

 ---

 ### Ответ 

Для деплоя инфраструктуры, в зависимости от целей, небходимо выбрать тип балансировщика NLB или ALB и закоментировать небходимые конфиги.

Манифесты по подпунктам представлены по ссылкам:

[S3 Манифест](https://github.com/loginochka/cloud-project/blob/main/h-2/s3.tf)

[LAMP Манифест](https://github.com/loginochka/cloud-project/blob/main/h-2/instance-gr.tf)

[NLB Манифест](https://github.com/loginochka/cloud-project/blob/main/h-2/load-balancer.tf)

[ALB Манифест](https://github.com/loginochka/cloud-project/blob/main/h-2/alb.tf)

[Переменны используемые в проекте](https://github.com/loginochka/cloud-project/blob/main/h-2/var.tf)

Остальные манифесты: 

[Сеть](https://github.com/loginochka/cloud-project/blob/main/h-2/network.tf)

[Сервисный аккаунт](https://github.com/loginochka/cloud-project/blob/main/h-2/service-acc.tf)

[Группы безопасности](https://github.com/loginochka/cloud-project/blob/main/h-2/sec-gr.tf)


![Результат работы](https://github.com/loginochka/cloud-project/blob/main/media/)