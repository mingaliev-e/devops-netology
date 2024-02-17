resource "yandex_vpc_network" "netology-vpc" {
  name = local.vpc
}

resource "yandex_vpc_subnet" "subnet-a" {
  name = "subnet-a"
  v4_cidr_blocks = [local.subnet_zone_a]
  zone           = local.zone_a
  network_id     = "${yandex_vpc_network.netology-vpc.id}"
}

resource "yandex_vpc_subnet" "subnet-b" {
  name = "subnet-b"
  v4_cidr_blocks = [local.subnet_zone_b]
  zone           = local.zone_b
  network_id     = "${yandex_vpc_network.netology-vpc.id}"
}

resource "yandex_vpc_address" "static-ip-a" {
  name = "static-ip-a"
  deletion_protection = "false"
  external_ipv4_address {
    zone_id = local.zone_a
  }
}

resource "yandex_vpc_address" "static-ip-b" {
  name = "static-ip-b"
  deletion_protection = "false"
  external_ipv4_address {
    zone_id = local.zone_b
  }
}
