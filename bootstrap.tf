resource "google_project" "project" {
  name            = "radioshow-demo2" # must be at least six characters long
  project_id      = "radioshow-demo2"
  org_id          = "" # your org_id
  billing_account = "" # your billing_account
}


provider "google" {
  project = "radioshow-demo2"
  region  = "us-central1"
  zone    = "us-central1-c"
}

variable "domain" {
  type    = string
}

resource "google_service_account" "project" {
  account_id   = google_project.project.name
  display_name = "Service Account"
}

// Services
module "project_services" {
  source  = "terraform-google-modules/project-factory/google//modules/project_services"
  version = "~> 14.0"

  project_id                  = google_project.project.project_id
  disable_services_on_destroy = false

  activate_apis = [
    "compute.googleapis.com",
    "container.googleapis.com",
    "servicenetworking.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "redis.googleapis.com"
  ]
}

// Providers

terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = ">= 2.28.1"
    }
  }
}