variable cloud_id{
  description = "Cloud"
}
variable folder_id {
  #description = "Folder"
  default = "folder_id"
}
variable zone {
  description = "Zone"
  # Значение по умолчанию
  default = "ru-central1-a"
}
variable public_key_path {
  # Описание переменной
  description = "Path to the public key used for ssh access"
}
variable private_key_path {
  # Описание переменной
  description = "Path to the private key used for ssh access"
}
variable image_id {
  description = "Disk image"
}
variable subnet_id{
  description = "Subnet"
}
variable service_account_key_file{
  description = "key .json"
}
variable region_id{
  description = "The default is ru-central1"
}
variable iamge_name {
  default = "image name"
}

variable user_id {
  default = "user name"

variable cluster_id {
  default = "cluster_id"
}
variable "acc_service_id" {
  description = "acc_service_id"

}
