module "f5xc_namespace" {
  source              = "./modules/f5xc/namespace"
  f5xc_namespace_name = "${var.project_prefix}-${var.namespace}"
}

module "f5xc_virtual_site" {
  source                 = "./modules/f5xc/site/virtual"
  f5xc_namespace         = "shared"
  f5xc_virtual_site_name = "${var.project_prefix}-${var.virtual_site}"
  f5xc_virtual_site_type = "CUSTOMER_EDGE"
  f5xc_virtual_site_selector_expression = [ "virtualSite in (${var.project_prefix}-${var.virtual_site})" ]
}

module "vk8s" {
  depends_on = [module.f5xc_namespace]
  source            = "./modules/f5xc/v8ks"
  f5xc_tenant       = var.f5xc_tenant
  f5xc_namespace    = "${var.project_prefix}-${var.namespace}"
  f5xc_vk8s_name    = "${var.project_prefix}-${var.vk8s_name}"
  f5xc_virtual_site_refs = [ "${var.project_prefix}-${var.virtual_site}" ]
}

module "vk8s_wait_for_online" {
  depends_on = [module.vk8s]
  source         = "./modules/f5xc/status/vk8s"
  f5xc_api_url   = var.f5xc_api_url
  f5xc_api_token = var.f5xc_api_token
  f5xc_namespace = "${var.project_prefix}-${var.namespace}"
  f5xc_vk8s_name = "${var.project_prefix}-${var.vk8s_name}"
  f5xc_tenant    = var.f5xc_tenant
}

resource "volterra_api_credential" "cluster" {
  depends_on = [module.vk8s]
  name                  = "${var.project_prefix}-${var.vk8s_name}"
  api_credential_type   = "KUBE_CONFIG"           
  virtual_k8s_namespace = "${var.project_prefix}-${var.namespace}"
  virtual_k8s_name      = "${var.project_prefix}-${var.vk8s_name}"
}

resource "local_file" "kubeconfig" {            
  depends_on = [ volterra_api_credential.cluster ]
  content    = base64decode(volterra_api_credential.cluster.data)
  filename   = "./kubeconfig"
}


output "f5xc_namespace" {
  value = module.f5xc_namespace
}

output "f5xc_virtual_site" {
  value = module.f5xc_virtual_site
}

output "vk8s" {
  value = module.vk8s
}
