packer {
  required_plugins {
    vsphere = {
      version = ">= 1.0.2"
      source  = "github.com/hashicorp/vsphere"
    }
    #amazon = {
    # version = ">= 1.0.9"
    #  source  = "github.com/hashicorp/amazon"
    #}
  }
}
