locals {
  vsphere_password = vault("dso-packer-testing/data/base_credentials", "vsphere_password")
  scripts_path     = "../../../scripts"

  aws_access_key = vault("dso-packer-testing/data/base_credentials", "aws_access_key")
  aws_secret_key = vault("dso-packer-testing/data/base_credentials", "aws_secret_key")
}

build {
  #source "source.amazon-ebs.default" {
  #  access_key = local.aws_access_key
  #  secret_key = local.aws_secret_key
  #  ami_users  = var.aws_share_account_ids
  #}

  sources = [
    "source.vsphere-iso.default",
  #  "source.amazon-ebs.default"
  ]
  
  # Configure
  provisioner "shell" {
    inline  = [
      "echo 'hello world 1.'"
    ]
  }

  # Cleanup
  provisioner "shell" {
    inline  = [
      "echo 'hello world 2.'"
    ]
  }
}
