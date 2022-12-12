FROM hello-world


kind: Role
apiVersion: rbac.authorization.k8s.io/v1beta1
metadata:
  name: test-rbac
rules:
- apiGroups: ["extensions", "apps"]
  resources: ["deployments"]
  verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
---
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1beta1
metadata:
  name: test-rbac-binding
subjects:
- kind: Group
  name: MOG_PLATFORM_workspace_cnu9qx_gcp@pdev.lloydsbanking.dev
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: Role
  name: test-rbac
  apiGroup: rbac.authorization.k8s.io
