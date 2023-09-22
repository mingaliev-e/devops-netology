# Домашнее задание к занятию «Установка Kubernetes»

### Задание 1. Установить кластер k8s с 1 master node

1. Подготовка работы кластера из 5 нод: 1 мастер и 4 рабочие ноды.
2. В качестве CRI — containerd.
3. Запуск etcd производить на мастере.
4. Способ установки выбрать самостоятельно.

## Дополнительные задания (со звёздочкой)

**Настоятельно рекомендуем выполнять все задания под звёздочкой.** Их выполнение поможет глубже разобраться в материале.   
Задания под звёздочкой необязательные к выполнению и не повлияют на получение зачёта по этому домашнему заданию. 

------
### Задание 2*. Установить HA кластер

1. Установить кластер в режиме HA.
2. Использовать нечётное количество Master-node.
3. Для cluster ip использовать keepalived или другой способ.


1) Нужно было создать папку

    admincm@kubeadm1:~$ sudo mkdir -p /etc/apt/keyrings/

2) Устанавливаем K8s

       
       sudo apt-get update \
       sudo apt-get install -y apt-transport-https ca-certificates curl \
       sudo curl -fsSL https://dl.k8s.io/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-archive-keyring.gpg \
       sudo echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list \
       sudo apt-get update \
       sudo apt-get install -y kubelet kubeadm kubectl containerd \
       sudo apt-mark hold kubelet kubeadm kubectl
       
3) Включение forwarding


    sudo -i \
    modprobe br_netfilter \
    echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf \
    echo "net.bridge.bridge-nf-call-iptables=1" >> /etc/sysctl.conf \
    echo "net.bridge.bridge-nf-call-arptables=1" >> /etc/sysctl.conf \
    echo "net.bridge.bridge-nf-call-ip6tables=1" >> /etc/sysctl.conf \
    sysctl -p /etc/sysctl.conf

4) Инициализируем кластер

    
    sudo kubeadm init \
    --apiserver-advertise-address=10.128.0.9 \
    --pod-network-cidr 10.244.0.0/16 \
    --apiserver-cert-extra-sans=51.250.95.72


      mkdir -p $HOME/.kube \
      sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config \ 
      sudo chown $(id -u):$(id -g) $HOME/.kube/config

5) На Worker nodes производим тоже самое 
6) Подклюаем worker

    
    sudo kubeadm join 10.128.0.9:6443 --token q6zdnb.6xx6fbx9993ljzmj \
    --discovery-token-ca-cert-hash sha256:faae4e424d5fa2d01bb08389597d2fb7498dbfa79df62460dc940c8305e9f2be

![image](https://github.com/mingaliev-e/devops-netology/assets/111060072/24c7ea7e-8756-4a29-a70a-ad811c886259)