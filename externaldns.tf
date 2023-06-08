resource "kubernetes_namespace" "external-dns" {
  metadata {
    name = "external-dns"
  }
  depends_on = [
    module.gke-gitlab
  ]
}

resource "helm_release" "external-dns" {
  name             = "external-dns"
  repository       = "https://charts.bitnami.com/bitnami"
  chart            = "external-dns"
  namespace        = "external-dns"

  set {
    name = "env.DO_TOKEN"
    value = var.do_token
  }
  set {
    name = "digitalocean.apiToken"
    value = var.do_token
  }
  set {
    name = "interval"
    value = "10s"
  }
  set {
    name = "policy"
    value = "upsert-only"
  }
  set {
    name = "provider"
    value = "digitalocean"
  }
  set {
    name = "sources[0]"
    value = "service"
  }
  set {
    name = "sources[1]"
    value = "ingress"
  }
  depends_on = [
    kubernetes_namespace.external-dns
  ]
}