terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  zone = "ru-central1-b"
}

resource "yandex_vpc_network" "netology_vpc" {
  name        = "netology-vpc"
  description = "netology-vpc>"
}

resource "yandex_vpc_subnet" "public_net" {
  name           = "public"
  description    = "public"
  v4_cidr_blocks = ["192.168.10.0/24"]
  zone           = "ru-central1-b"
  network_id     = "${yandex_vpc_network.netology_vpc.id}"
}

resource "yandex_vpc_subnet" "private_net" {
  name           = "private"
  description    = "private"
  v4_cidr_blocks = ["192.168.20.0/24"]
  zone           = "ru-central1-b"
  network_id     = "${yandex_vpc_network.netology_vpc.id}"
  route_table_id = "${yandex_vpc_route_table.route-default.id}"
}

resource "yandex_compute_instance" "nat_instance" {
  description = "nat-instance"
  name        = "nat-instance"
  platform_id = "standard-v3"
  zone        = "ru-central1-b"

  resources {
    cores  = 2 # vCPU
    memory = 4 # GB
  }

  boot_disk {
    initialize_params {
      image_id = "fd8qmbqk94q6rhb4m94t"
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.public_net.id}"
    nat       = true
    ip_address     = "192.168.10.254"

  }

  metadata = {
    user-data = "${file("/home/admincm/test/keys")}"
    }
}

resource "yandex_compute_instance" "public_vm" {
  description = "public-vm"
  name        = "public-vm"
  platform_id = "standard-v3"
  zone        = "ru-central1-b"

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd8ebb4u1u8mc6fheog1"
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.public_net.id}"
    nat       = true


  }

  metadata = {
    user-data = "${file("/home/admincm/test/keys")}"
    }
}

resource "yandex_compute_instance" "private_vm" {
description = "vm-in-priv"
name        = "private-vm"
platform_id = "standard-v3"
zone        = "ru-central1-b"


resources {
    cores  = 2
    memory = 4
}

boot_disk {
    initialize_params {
    image_id = "fd8ebb4u1u8mc6fheog1"
    }
}

network_interface {
    subnet_id = "${yandex_vpc_subnet.private_net.id}"
    nat       = false
    ip_address = "192.168.20.100"

}

metadata = {
    user-data = "${file("/home/admincm/test/keys")}"
    }
}

resource "yandex_vpc_route_table" "route-default" {
  name       = "WAN"
  network_id = "${yandex_vpc_network.netology_vpc.id}"
  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = "192.168.10.254"
  }
}
