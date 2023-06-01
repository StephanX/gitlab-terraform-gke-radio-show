* set the local environment variables:

```
export KUBE_CONFIG_PATH=gitlab.kubeconfig.yaml
export KUBECONFIG=${KUBE_CONFIG_PATH}
touch ${KUBE_CONFIG_PATH}
```

* source the aliases i.e. `source aliases.sh`
* update the bootstrap.tf with a unique project name, update the domain and certmanager_email in gitlab.tf
* run

```
terraform init  # install the necessary terraform module dependencies
tfr -y -target=google_project.project # create the project
tfr -y -target=module.project_services # bootstrap the project api services
time tfr -y # do the actual terraform provisioning of the VPC + GKE cluster and deploy gitlab via helm
```

* get the kubeconfig creds (will be added to the `gitlab.kubeconfig.yaml` file we created in step 1): `gcloud container clusters get-credentials gitlab --region us-central1 --project gitlab-demo1`
