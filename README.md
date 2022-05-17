# PROJECT OTUS-DEV-O1
____
# Код предоставлен express42
#https://github.com/express42/search_engine_ui

#https://github.com/express42/search_engine_crawler
____

:white_check_mark: Cделано

# I. Подготовка к развертыванию архитектуры:

## 1. Сборка Docker (необходима, если хотите реализовать собственную сборку):

**Переходим в соответствующие каталоги:**

cd ~./logging
cd ~./monitoring

**Запускаем все контейнеры, видим stdout всех контейнеров для остановки используем Ctrl+C**

docker-compose up

*или*

docker-compose -f docker-compose-logging.yml

**запуск в режиме демона**

docker-compose up -d

*или*

docker-compose -f docker-compose-logging.yml up -d

*для остановки используем*

docker-compose stop

*для остановки с удалением контейнеров*

docker-compose down

*или*

docker-compose -f docker-compose-logging.yml down-

**Точно также соберем и ui/crawler Образы:**

cd ~./prog/ui

cd ~./prog/crawler

**Сборка проектов представлена в соответвующих каталогах**

## 2. Билдинг проекта

**Сборка проекта осуществляется с помощь Makefile файла. Переходим в каталог builder:**

cd ~./builder

*Запускае:*

make build

**Результат - собранный проект: ui, crawler, logging, monitoring**

*В каталоге builder/readme.md опредставлены ключи для управления сборкой образов*
____

:white_check_mark: Cделано

# II. Развертывание инфраструктуры k8s

## 1 Развертывание архитектуры k8s c помощью Terraform

**Необходимое условие - установленный Terraform (инструкция по установке и настройке Terraform в Яндекс):**

*https://cloud.yandex.ru/docs/tutorials/infrastructure-management/terraform-quickstart#install-terraform*

**Установим k8s в Яндекс**

*Переходим в каталог:*

cd ~./k8s/terraform

*Выполняем команды инициализации и проверки конфигурации:*

terraform init

terraform validate

terraform plan

*Запускаем установку кластера*

terraform apply

**Добавим учетные данные кластера Kubernetes в конфигурационный файл kubectl**

yc managed-kubernetes cluster get-credentials --id <id вашего кластера> --internal

## 2 Ingress Controller

*Для удобного управления входящим снаружи трафиком будем использовать Ingress*

**Установим Ingress**

kubectl apply -f /
https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.34.1/deploy/static/provider/cloud/deploy.yaml

*ingress устновлен в namespace ingress-nginx*
____

:white_check_mark: Cделано

# III. Диплой приложения

## 1 Создаем четыре namespaces: monitoring, dev, prod, cicd:

cd ~.k8s/deployments

kubectl apply -f namespaces.yml

## 2 Установим наши приложения UI, CRAWLER, DB в namespace dev:

**IU**

kubectl apply -f ui-deployment.yml -n dev

kubectl apply -f ui-service.yml -n dev

kubectl apply -f ui-ingress.yml -n dev

**CRAWLER**

kubectl apply -f crawler-deployment.yml -n dev

kubectl apply -f crawler-service.yml -n dev

**DB**

kubectl apply -f mongodb-deployment.yml -n dev

kubectl apply -f mongodb-service.yml -n dev

kubectl apply -f rabbitmq-deployment.yml -n dev

kubectl apply -f rabbitmq-service.yml -n dev

## 3 Запуск диплоя проложений для мониторинга и логирования:

*Запуск в namespace monitoring*

cd ~./log_monitor

kubectl apply -f flu-role.yml -n monitoring
kubectl apply -f flu-rb.yml -n monitoring
kubectl apply -f flu-dep.yml -n monitoring
kubectl apply -f flu-sa.yml -n monitoring
kubectl apply -f el-dep.yml -n monitoring
kubectl apply -f el-srv.yml -n monitoring
kubectl apply -f kin-dep.yml -n monitoring
kubectl apply -f prometheus-deployment.yml -n monitoring
kubectl apply -f prometheus-service.yml -n monitoring

*Далее вы можете начать работать с сервисом.*

**руководство по эксплуатации сервиса в prog/search_engine_crawler и prog/search_engine_ui**
____
:white_check_mark: Cделано

# IV CI/CD

**Установим Helm**:

curl https://baltocdn.com/helm/signing.asc | sudo apt-key add -

sudo apt-get install apt-transport-https --yes

echo "deb https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list

sudo apt-get update

sudo apt-get install helm

## 1. Установим Gitlab

:black_square_button: Тестируем...

**Добавим необходимый репозиторий**

helm repo add gitlab https://charts.gitlab.io

**Установим Gitlab в namespace cicd**

helm install --name gitlab -f ~./cicd/values.yaml stable/gitlab-ce -n cicd

*Gitlab устновлен и готов к работе*

## 2. Настройка Gitlab для проекта

:black_square_button: Тестируем...
