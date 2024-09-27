// Variables that do not have a default value must be set from the command line, a var-file, or the environment.

# User Config
variable "vsphere_user" {
  type = string
  default = ""
}

variable "ssh_username" {
  type = string
  default = ""
}

# vSphere Config
variable "vsphere_cluster" {
  type    = string
  default = ""
}

variable "vsphere_datacenter" {
  type    = string
  default = ""
}

variable "vsphere_server" {
  type    = string
  default = ""
}

# VM Config
variable "vm_name" {
  type    = string
  default = "Ubuntu2204-Template-Base"
}

variable "os_iso_path" {
  type = string
}

variable "vm_cpu_num" {
  type    = string
  default = "4"
}

variable "vm_cpucores_num" {
  type    = string
  default = "4"
}

variable "vm_disk_size" {
  type    = string
  default = "102400"
}

variable "vm_data_disk_size" {
  type    = string
  default = "204800"
}

variable "vm_mem_size" {
  type    = string
  default = "4096"
}

variable "vsphere_folder" {
  type    = string
  default = "Templates"
}

variable "vsphere_datastore" {
  type    = string
  default = ""
}

variable "vsphere_network" {
  type    = string
  default = ""
}

variable "vm_firmware" {
  type    = string
  default = "efi"
}

variable "vm_os_type" {
  type    = string
  default = "ubuntu64Guest"
}

#Packer config
variable "packer_http_host_addr" {
  type    = string
  default = "127.0.0.1"
}

# Local config 
locals {
  buildtime = formatdate("YYYY-MM-DD hh:mm ZZZ", timestamp())
}