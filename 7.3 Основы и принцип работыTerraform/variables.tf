# Заменить на ID своего облака
# https://console.cloud.yandex.ru/cloud?section=overview
variable "yandex_cloud_id" {
  default = "b1g3va6uroak1bss6lnp"
}

# Заменить на Folder своего облака
# https://console.cloud.yandex.ru/cloud?section=overview
variable "yandex_folder_id" {
  default = "b1ge911130k5mdbil616"
}

# Заменить на ID своего образа
# ID можно узнать с помощью команды yc compute image list
variable "centos-7-base" {
  default = "fd8jvafqbrslq4pa1tje"
}

variable name { default = ""}
variable count_offset { default = 0 } #start numbering from X+1 (e.g. name-1 if '0', name-3 if '2', etc.)
variable count_format { default = "%01d" } #server number format (-1, -2, etc.)
variable instance_count { default = 1 }

variable "instances" {
  description = "Map of project names to configuration."
  type        = map
  default     = {
    node_1 = {
      instance_type           = "standard-v1",
      name                    = "node_1"
    },
    node_2 = {
      instance_type           = "standard-v2",
      name                    = "node_2"
    }
  }
}
