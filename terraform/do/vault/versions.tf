terraform {
    required_providers {
      digitalocean = {
        source = "digitalocean/digitalocean"
        version = "2.5.1"
      }
    
      cloudflare = {
        source = "cloudflare/cloudflare"
        version = "2.18.0"
      }
      
    }
  
    required_version = ">= 1.3.0"
  }