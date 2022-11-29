module {
  source             = "app.terraform.io/lbg-cloud-platform/gcp-project/google"
  version            = "4.0.0"
  project_name       = var.project_kube_03_svc_name
  billing_account_id = var.billing_account_id
  parent_folder      = var.parent_folder
  project_id         = var.project_kube_03_svc_name
}
module {
  source             = "app.terraform.io/lbg-cloud-platform/gcp-project/google"
  version            = "4.0.0"
  project_name       = var.project_atch_03_svc_name
  billing_account_id = var.billing_account_id
  parent_folder      = var.parent_folder
  project_id         = var.project_atch_03_svc_name
}
module {
  source             = "app.terraform.io/lbg-cloud-platform/gcp-project/google"
  version            = "4.0.0"
  project_name       = var.project_kube_03_svc_name
  billing_account_id = var.billing_account_id
  parent_folder      = var.parent_folder
  project_id         = var.project_kube_03_svc_name
}
module {
  source             = "app.terraform.io/lbg-cloud-platform/gcp-project/google"
  version            = "4.0.0"
  project_name       = var.project_atch_03_svc_name
  billing_account_id = var.billing_account_id
  parent_folder      = var.parent_folder
  project_id         = var.project_atch_03_svc_name
}
