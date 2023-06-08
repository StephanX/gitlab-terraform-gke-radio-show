variable "do_token" {
  type        = string
  description = "Digital Ocean Token for interacting with the DO api"
}

provider "digitalocean" {
  token = var.do_token
}
