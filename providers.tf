provider "proxmox" {
  pm_api_url          = "https://10.99.0.67:8006/api2/json"
  pm_api_token_id     = "root@pam!Terraform"
  pm_api_token_secret = "7bfab172-5a98-45e9-9195-444f902d6c7d"

  pm_tls_insecure = true
}