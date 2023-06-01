resource "google_project" "project" {
  name            = "gitlab-demo2" # must be at least six characters long
  project_id      = "gitlab-demo2"
  org_id          = "" # your org_id
  billing_account = "" # your billing_account
}

provider "google" {
  project = "gitlab-demo2"
  region  = "us-central1"
  zone    = "us-central1-c"
}

// Services
module "project_services" {
  source  = "terraform-google-modules/project-factory/google/modules/project_services"
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