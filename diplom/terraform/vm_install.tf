### K8S master_A
resource "yandex_compute_instance" "master-node-a" {
  description = "master-k8s"
  name        = local.master_A_name
  platform_id = "standard-v3"
  zone        = local.master_A_zone
  hostname = local.master_A_name

  resources {
    cores  = local.master_cpu
    memory = local.master_ram
  }

  boot_disk {
    initialize_params {
      image_id = local.master_image
      size = local.master_A_disk_size
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.subnet-a.id}"
    nat = true
    nat_ip_address = yandex_vpc_address.static-ip-a.external_ipv4_address[0].address
  }
  scheduling_policy {
    preemptible = true
  }
  metadata = {
    user-data = "${file("/home/admincm/1234/userdata")}"
    }
}

### K8S master_B
resource "yandex_compute_instance" "master-node-b" {
  description = "master-k8s"
  name        = local.master_B_name
  platform_id = "standard-v3"
  zone        = local.master_B_zone
  hostname = local.master_B_name

  resources {
    cores  = local.master_cpu
    memory = local.master_ram
  }

  boot_disk {
    initialize_params {
      image_id = local.master_image
      size = local.master_B_disk_size
    }
  }


  network_interface {
    subnet_id = "${yandex_vpc_subnet.subnet-b.id}"
    nat = true
    nat_ip_address = yandex_vpc_address.static-ip-b.external_ipv4_address[0].address
  }
    scheduling_policy {
    preemptible = true
  }
  metadata = {
    user-data = "${file("/home/admincm/1234/userdata")}"
    }
}

### K8S worker_A
resource "yandex_compute_instance" "worker-node-a" {
  description = "worker-k8s"
  name        = local.worker_A_name
  platform_id = "standard-v3"
  zone        = local.worker_A_zone
  hostname = local.worker_A_name

  resources {
    cores  = local.worker_cpu
    memory = local.worker_ram
  }

  boot_disk {
    initialize_params {
      image_id = local.worker_image
      size = local.worker_A_disk_size
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.subnet-a.id}"
    nat       = true

  }
  scheduling_policy {
    preemptible = true
  }
  metadata = {
    user-data = "${file("/home/admincm/1234/userdata")}"
    }
}

### K8S worker_B
resource "yandex_compute_instance" "worker-node-b" {
  description = "worker-k8s"
  name        = local.worker_B_name
  platform_id = "standard-v3"
  zone        = local.worker_B_zone
  hostname = local.worker_B_name

  resources {
    cores  = local.worker_cpu
    memory = local.worker_ram
  }

  boot_disk {
    initialize_params {
      image_id = local.worker_image
      size = local.worker_B_disk_size
    }
  }


  network_interface {
    subnet_id = "${yandex_vpc_subnet.subnet-b.id}"
    nat       = true

  }
  scheduling_policy {
    preemptible = true
  }
  metadata = {
    user-data = "${file("/home/admincm/1234/userdata")}"
    }
}

### Zabbix_Server
resource "yandex_compute_instance" "zabbix-server-a" {
  description = "zabbix-server"
  name        = local.zabbix_name
  platform_id = "standard-v3"
  zone        = local.zabbix_zone
  hostname = local.zabbix_name

  resources {
    cores  = local.zabbix_cpu
    memory = local.zabbix_ram
  }

  boot_disk {
    initialize_params {
      image_id = local.zabbix_image
      size = local.zabbix_disk_size
    }
  }


  network_interface {
    subnet_id = "${yandex_vpc_subnet.subnet-a.id}"
    nat       = true

  }
  scheduling_policy {
    preemptible = true
  }
  metadata = {
    user-data = "${file("/home/admincm/1234/userdata")}"
    }
}
