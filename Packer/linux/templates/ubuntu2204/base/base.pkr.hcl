locals {
  vsphere_password = vault("", "")
  scripts_path     = "../../../scripts"

  aws_access_key = vault("", "")
  aws_secret_key = vault("", "")
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
