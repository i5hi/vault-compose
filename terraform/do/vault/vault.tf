variable "token"            {}
variable "region"           {}

provider "digitalocean"{
  token = var.token
}

variable "vault_image"      {}
variable "vault_admin"      {}
variable "vault_ssh_key"    {}
variable "vault_size"       {}
variable "vault_label"      {}
variable "vault_volume_id"  {}

resource "digitalocean_droplet" "tomavault" {
  name            = var.vault_label
  region          = var.region
  size            = var.vault_size
  image           = var.vault_image
  ssh_keys        = [var.vault_ssh_key]
}

resource "digitalocean_volume" "makavault-volume" {
  region                  = "sgp1"
  name                    = "s5persvault"
  size                    =  10
  initial_filesystem_type = "ext4"
  description             = "Maka Persistent Vault Data Volume"
}

resource "digitalocean_volume_attachment" "tomavault-attach" {
  droplet_id = digitalocean_droplet.makavault.id
  volume_id  = digitalocean_volume.makavault-volume.id
}

data "digitalocean_project" "makabitcoin" {
  name = "MakaBitcoin"
}

resource "digitalocean_project_resources" "makabitcoin" {
  project   = data.digitalocean_project.makabitcoin.id
  resources = [digitalocean_droplet.makavault.urn,digitalocean_volume.makavault-volume.urn]
}


output "vault_ip" {
  value           = digitalocean_droplet.makavault.ipv4_address
}

resource "digitalocean_firewall" "maka-fire" {
  name = "ssh-and-web-maka"
  droplet_ids = [digitalocean_droplet.makavault.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol	     = "tcp"
    port_range       = "22909"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }
 
  inbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "443"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "icmp"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}

variable "cf_key"           {}
variable "cf_token"         {}
variable "cf_email"         {}
variable "cf_zone_id"       {}

provider "cloudflare" {
  api_token  = var.cf_token
}

resource "cloudflare_record" "v" {
  type    = "A"
  name    = "vault"
  zone_id = var.cf_zone_id
  value   = digitalocean_droplet.makavault.ipv4_address
}

