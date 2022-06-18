# Provider
terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  service_account_key_file = "key.json"
  cloud_id  = "${var.yandex_cloud_id}"
  folder_id = "${var.yandex_folder_id}"
  zone      = "ru-central1-a"
}

data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2004-lts"
}

resource "yandex_vpc_network" "net" {
  name = "${var.name}"
}

resource "yandex_vpc_subnet" "subnet" {
  name           = "${var.name}"
  network_id     = resource.yandex_vpc_network.net.id
  v4_cidr_blocks = ["10.2.0.0/16"]
  zone           = "ru-central1-a"
}

resource "yandex_compute_instance" "vm" {
  count = local.instance_count[terraform.workspace]
  name        = "${var.name}"
  hostname    = "${var.name}"
  platform_id = "standard-v1"

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 100
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      type     = "network-hdd"
      size     = "20"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet.id
    nat       = true
    ipv6      = false
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

locals {
  instance_count = {
    stage = 1
    prod = 2
  }
}

resource "yandex_compute_instance" "vm1" {
  name        = "${var.name}"
  hostname    = "${var.name}"
  platform_id = "standard-v1"
  for_each      = var.instances

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 100
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      type     = "network-hdd"
      size     = "20"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet.id
    nat       = true
    ipv6      = false
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}
