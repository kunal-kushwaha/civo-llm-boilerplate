resource "helm_release" "ollama-ui" {
  count            = var.deploy_ollama_ui ? 1 : 0
  name = "ollama-ui"
  chart      = "../helm/ollama-ui/"
  namespace        = "ollama-ui"
  create_namespace = true
  replace = true
  depends_on = [civo_kubernetes_cluster.cluster]
}

data "kubernetes_service" "ollama-ui" {
  metadata {
    name      = "open-webui"
    namespace = "ollama-ui"
  }

  depends_on = [helm_release.ollama-ui]
}
