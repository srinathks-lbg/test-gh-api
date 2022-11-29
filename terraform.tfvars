cluster_name = "euwe1-mngd-02-kube-02-kcl"
project_id   = "shared-svc1-project"
roles        = ["roles/storage.admin", "roles/compute.admin", "roles/iam.workloadIdentityUser"]
k8s_sa_name  = "svc-mngd-02-kube-02-ksa"
gcp_sa_name  = "svc-mngd-02-kube-02-gsa"
location     = "europe-west1"
namespace    = "ns-mngd-02-kube-02"
role_name    = "rbac-ns-mngd-02-kube-02"
rules = [
  {

    "api_groups" : ["apps"]
    "resources" : ["deployments"]
    # "resource_names" : ["nginx-deployment-01"],
    "verbs" : ["get", "list", "watch", "create", "update", "patch", "delete"]
  },
  {
    "api_groups" : [""]
    "resources" : ["pods"]
    # "resource_names" : ["nginx-deployment-02"],
    "verbs" : ["get", "list", "watch"]
  }
]
subjects = [
  {
    "kind" : "Group",
    "name" : "MANUAL_GSG_PDEV_VDC_DEVELOPER@pdev.lloydsbanking.dev",
    "api_group" : "rbac.authorization.k8s.io"
    namespace = "ns-mngd-02-kube-02"
  }
]
