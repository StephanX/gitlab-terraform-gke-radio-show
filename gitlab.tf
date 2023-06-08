module "gke-gitlab" {
  source                      = "git::https://github.com/StephanX/terraform-google-gke-gitlab"
  allow_force_destroy         = true
  certmanager_email           = "stephan@stephanx.net"
  domain                      = var.domain # the _root_ domain; gitlab will create 'gitlab' and 'registry' subdomains
  gitlab_deletion_protection  = false
  gitlab_runner_install       = false
  # gke_version                 = "1.25"
  helm_chart_version          = "6.11.6" # https://gitlab.com/gitlab-org/charts/gitlab
  project_id                  = google_project.project.name
  region                      = "us-central1"
}

# # needs to be configured after the server has been initially created
# # https://github.com/DeimosCloud/terraform-kubernetes-gitlab-runner
# module "gitlab_runner" {
#   source                    = "DeimosCloud/gitlab-runner/kubernetes"
#   release_name              = "${google_project.project.name}-runner"
#   runner_name               = "${google_project.project.name}-runner"
#   runner_tags               = "ragnar,default"
#   runner_registration_token = "" # determined after the gitlab server has been bootstrapped
#   # runner_image              = var.runner_image
#   create_namespace          = true
#   namespace                 = "gitlab-runner"
#   gitlab_url                = "https://gitlab.${var.domain}/"

#   # Pass annotations to service account. This can be for workload/pod/ identity
#   service_account_annotations = {
#     "iam.gke.io/gcp-service-account" = google_service_account.project.email
#   }

#   # Mount docker socket instead of using docker-in-docker
#   build_job_mount_docker_socket = true

#   depends_on = [module.gke-gitlab]
# }