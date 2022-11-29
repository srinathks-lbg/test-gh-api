cluster_name = "euwe2-mngd-03-kube-03-kcl"
project_id   = "shared-svc1-project"
roles        = ["roles/storage.admin", "roles/compute.admin", "roles/iam.workloadIdentityUser"]
k8s_sa_name  = "svc-mngd-03-kube-03-ksa"
gcp_sa_name  = "svc-mngd-03-kube-03-gsa"
location     = "europe-west2"
namespace    = "ns-mngd-03-kube-03"
role_name    = "rbac-ns-mngd-03-kube-03"
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
    namespace = "ns-mngd-03-kube-03"
  }
]
