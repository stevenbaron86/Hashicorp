locals {
  ssh_password   = vault("dso-packer-testing/data/base_credentials", "ssh_password")
}

source "vsphere-iso" "default" {
  # Build Configuration
  convert_to_template = true
  insecure_connection = true

  boot_wait       = "5s"
  boot_command = [
    // This waits for 3 seconds, sends the "c" key, and then waits for another 3 seconds. In the GRUB boot loader, this is used to enter command line mode.
    "<wait3s>c<wait3s>",
    // This types a command to load the Linux kernel from the specified path with the 'autoinstall' option and the value of the 'data_source_command' local variable. 
    // The 'autoinstall' option is used to automate the installation process. 
    // The 'data_source_command' local variable is used to specify the kickstart data source configured in the common variables. 
    "linux /casper/vmlinuz --- autoinstall ds=nocloud-net\\;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/",
    // This sends the "enter" key and then waits. This is typically used to execute the command and give the system time to process it.
    "<enter><wait>",
    // This types a command to load the initial RAM disk from the specified path.
    "initrd /casper/initrd",
    // This sends the "enter" key and then waits. This is typically used to execute the command and give the system time to process it.
    "<enter><wait>",
    // This types the "boot" command. This starts the boot process using the loaded kernel and initial RAM disk.
    "boot",
    // This sends the "enter" key. This is typically used to execute the command.
    "<enter>"
  ]
  ip_wait_timeout = "90m"
  notes = "Built by HashiCorp Packer on ${local.buildtime}."
  http_directory = "../../../config/ubuntu-cloudconfig-2204/"
  #output_directory = "../output/live-server"
  
  # ssh configuration
  ssh_username           = var.ssh_username
  ssh_password           = local.ssh_password
  ssh_port               = 22
  ssh_handshake_attempts = "100"
  ssh_timeout            = "90m"
  shutdown_command       = "echo '${local.ssh_password}' | sudo -S -E shutdown -P now"
  shutdown_timeout       = "90m"

  # vSphere
  vcenter_server = "${var.vsphere_server}"
  datacenter     = "${var.vsphere_datacenter}"
  cluster        = "${var.vsphere_cluster}"
  username       = "${var.vsphere_user}"
  password       = local.vsphere_password

  # VM Hardware 
  vm_name       = "${var.vm_name}"
  CPUs          = "${var.vm_cpu_num}"
  RAM           = "${var.vm_mem_size}"
  datastore     = "${var.vsphere_datastore}"
  folder        = "${var.vsphere_folder}"
  firmware      = "${var.vm_firmware}"
  guest_os_type = "${var.vm_os_type}"
  RAM_hot_plug  = true
  CPU_hot_plug  = true

  # Storage
  disk_controller_type = ["pvscsi"]
  storage {
      disk_size             = "${var.vm_disk_size}"
      disk_thin_provisioned = false
    }
  storage {
      disk_size             = "${var.vm_data_disk_size}"
      disk_thin_provisioned = false
    }


  floppy_files = [
  ]

  iso_paths = [
    "${var.os_iso_path}"
  ]

  network_adapters {
    network      = "${var.vsphere_network}"
    network_card = "vmxnet3"
  }
}

#source "amazon-ebs" "default" {
#  communicator    = "ssh"
#  ssh_username    = "ubuntu"
#  ami_description = "Ubuntu 20.04 LTS AMI. Built by Hashicorp Packer on ${local.buildtime}."
#  ami_name        = "${var.vm_name}"
#  instance_type   = "${var.ami_instance_type}"
#  region          = "${var.aws_region}"
#  source_ami_filter {
#    filters = {
#      name                = "${var.aws_ami_filter_name}"
#      root-device-type    = "${var.aws_ami_filter_device_type}"
#      virtualization-type = "${var.aws_ami_filter_virtualization_type}"
#    }
#    most_recent = true
#    owners      = ["${var.aws_ami_filter_owner}"]
#  }
#  user_data_file              = "../../../config/ubuntu-cloudconfig/user-data"
#  force_deregister            = true
#  subnet_id                   = "subnet-068614c18e72dab28"
#  associate_public_ip_address = true
#  security_group_id           = "sg-06835791cd49bb827"
#  skip_region_validation = true
#}