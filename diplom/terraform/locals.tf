locals {
  folder_id = "b1gfnngmdd2hj62l7uof"
  sa_name = "netology-sa"
  backend_bucket = "netology-devops24"
  vpc = "netology-vpc"
  zone_a = "ru-central1-a"
  zone_b = "ru-central1-b"
  subnet_zone_a = "192.168.1.0/24"
  subnet_zone_b = "192.168.2.0/24"

  #### K8S nodes Masters
  master_image = "fd8bt3r9v1tq5fq7jcna"
  master_ram = 4
  master_cpu = 2
  master_A_zone = "ru-central1-a"
  master_B_zone = "ru-central1-b"
  master_A_name = "k8s-control-node-a"
  master_B_name = "k8s-control-node-b"

  #### K8S nodes Workers
  worker_image = "fd8bt3r9v1tq5fq7jcna"
  worker_ram = 4
  worker_cpu = 2
  worker_A_zone = "ru-central1-a"
  worker_B_zone = "ru-central1-b"
  worker_A_name = "k8s-worker-a"
  worker_B_name = "k8s-worker-b"

  #### Zabbix-Server
  zabbix_image = "fd8bt3r9v1tq5fq7jcna"
  zabbix_ram = 4
  zabbix_cpu = 4
  zabbix_zone = "ru-central1-a"
  zabbix_name = "zabbix-server-a"

  #### Disk ####
  master_A_disk_size = 50
  master_B_disk_size = 50
  worker_A_disk_size = 30
  worker_B_disk_size = 30
  zabbix_disk_size = 50
}
