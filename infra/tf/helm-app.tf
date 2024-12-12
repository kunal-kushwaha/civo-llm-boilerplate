resource "helm_release" "app" {
  count            = var.deploy_app ? 1 : 0
  name = "app"
  chart      = "../helm/app/"
  namespace        = "apps"
  create_namespace = true
  replace = true
  depends_on = [civo_kubernetes_cluster.cluster]
}

# data "kubernetes_service" "app" {
  # metadata {
    # name      = "app"
    # namespace = "apps"
  # }
# 
  # depends_on = [helm_release.app]
# }
