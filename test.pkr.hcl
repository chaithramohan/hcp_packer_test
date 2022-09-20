packer {
  required_plugins {
    googlecompute = {
      version = ">= 0.0.1"
      source  = "github.com/hashicorp/googlecompute"
    }
  }
}
data "hcp-packer-iteration" "hardened-source" {
  bucket_name = "learn-packer-ubuntu"
  channel     = "packertestchannel"
}

data "hcp-packer-image" "basic-example" {
  bucket_name    = "learn-packer-ubuntu"
  iteration_id   = "${data.hcp-packer-iteration.hardened-source.id}"
  cloud_provider = "gce"
  region         = "us-central1-a"
}
source "googlecompute" "basic-example" {
  project_id   = "burner-chamohan3"
  source_image = "debian-9-stretch-v20200805"
  image_name   = "packercm-{{timestamp}}"
  ssh_username = "cm"
  zone         = "us-central1-a"
  #account_file = "/home/chaithra/service_account.json"
  tags         = ["packer", "packer-allow-ssh"]
}
build {
  hcp_packer_registry {
    bucket_name = "learn-packer-ubuntu"
    description = <<EOT
Some nice description about the image being published to HCP Packer Registry.
    EOT
    bucket_labels = {
      "owner"          = "platform-team"
      "os"             = "deb",
      "ubuntu-version" = "deb-9",
    }

    build_labels = {
    }
  }
  sources = ["sources.googlecompute.basic-example"]
}
