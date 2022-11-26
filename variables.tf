# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# These parameters must be supplied when consuming this module.
# ---------------------------------------------------------------------------------------------------------------------

variable "module_version" {
  description = "The Module version of GKE to use "
  type        = string
}

variable "project_id" {
  description = "The project ID to host the cluster in"
  type        = string
}

variable "location" {
  description = "The location (region or zone) to host the cluster in. Recommendation is Region."
  type        = string
}

variable "name" {
  description = "The name of the cluster"
  type        = string
}

variable "network" {
  description = "A reference to the VPC network to host the cluster in"
  type        = string
}

variable "subnetwork" {
  description = "A reference to the subnetwork to host the cluster in"
  type        = string
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# Generally, these values won't need to be changed.
# ---------------------------------------------------------------------------------------------------------------------

variable "cluster_secondary_range_name" {
  description = "The name of the secondary range within the subnetwork for the cluster to use"
  type        = string
  default     = null
}

variable "services_secondary_range_name" {
  description = "The name of the secondary range within the subnetwork for the services to use"
  type        = string
  default     = null
}

variable "master_ipv4_cidr_block" {
  description = <<-HEREDOC
                  "The IP range in CIDR notation to use for the hosted master network.
                  This range will be used for assigning internal IP addresses to the master or set of masters,
                  as well as the ILB VIP. This range must not overlap with any other ranges in use within the cluster's network."
                HEREDOC
  type        = string
  default     = null
}

# default_max_pods_per_node - https://ltmhedge.atlassian.net/browse/GPE-11340
variable "default_max_pods_per_node" {
  description = "The maximum number of pods to schedule per node"
  type        = string
  default     = "110"
}

variable "description" {
  description = "The description of the cluster"
  type        = string
  default     = ""
}

variable "kubernetes_version" {
  description = "The Kubernetes version of the masters. If set to 'default' it will pull default available version in the selected region."
  type        = string
}

variable "kubernetes_node_pool_version" {
  description = "The Kubernetes version of the nodes in node pool. If set to 'default' it will pull default available version in the selected region."
  type        = string
  default     = ""
}

variable "logging_service" {
  description = <<-HEREDOC
                  "The logging service that the cluster should write logs to.
                  Available options include logging.googleapis.com/kubernetes, logging.googleapis.com (legacy), and none"
                HEREDOC
  type        = string
  default     = "logging.googleapis.com/kubernetes"
}

variable "monitoring_service" {
  description = <<-HEREDOC
                  "The monitoring service that the cluster should write metrics to.
                  Automatically send metrics from pods in the cluster to the Stackdriver Monitoring API.
                  VM metrics will be collected by Google Compute Engine regardless of this setting.
                  Available options include monitoring.googleapis.com/kubernetes, monitoring.googleapis.com (legacy),
                  and none"
                HEREDOC
  type        = string
  default     = "monitoring.googleapis.com/kubernetes"
}

variable "horizontal_pod_autoscaling" {
  description = "Whether to enable the horizontal pod autoscaling addon"
  type        = bool
  default     = true
}

variable "http_load_balancing" {
  description = "Whether to enable the http (L7) load balancing addon"
  type        = bool
  default     = false
}

variable "enable_istio" {
  description = "Whether to enable the istio addon"
  type        = bool
  default     = false
}

variable "enable_dns_cache" {
  description = "Whether to enable the dns_cache addon"
  type        = bool
  default     = null
}

variable "enable_private_nodes" {
  description = <<-HEREDOC
                  "Control whether nodes have internal IP addresses only. If enabled, all nodes are given only RFC 1918 private
                  addresses and communicate with the master via private networking."
                HEREDOC
  type        = bool
  default     = true
}

variable "disable_public_endpoint" {
  description = <<-HEREDOC
                  "Control whether the master's internal IP address is used as the cluster endpoint.
                  If set to 'true', the master can only be accessed from internal IP addresses."
                HEREDOC
  type        = bool
  default     = true
}

variable "network_project_id" {
  description = "The project ID of the shared VPC's host (for shared vpc support)"
  type        = string
  default     = ""
}

variable "master_authorized_networks_config" {
  type        = list(any)
  default     = [{}]
  description = <<EOF
  The desired configuration options for master authorized networks.
  Omit the nested cidr_blocks attribute to disallow external access (except the cluster node IPs, which
  GKE automatically whitelists)
  ### example format ###
  master_authorized_networks_config = [{
    cidr_blocks = [{
      cidr_block   = "10.0.0.0/8"
      display_name = "example_network"
    },
    {
      cidr_block   = "10.0.0.0/8"
      display_name = "example_network"
    }],
  }]
EOF
}

variable "maintenance_daily_start_time" {
  description = <<-HEREDOC
                  "Time window specified for daily maintenance operations in RFC3339 format - HH:MM, where HH :
                  [00-23] and MM : [00-59] GMT. For example: 03:00"
                HEREDOC
  type        = string
  default     = "03:00"
}

variable "maintenance_recurring_window" {
  type = map(string)
  default = {
    start_time = "2020-07-01T02:00:00Z"
    end_time   = "2020-07-01T17:00:00Z"
    recurrence = "FREQ=WEEKLY;BYDAY=MO"
  }
  description = <<EOF
  Specify start_time and end_time in RFC3339 date format. The start time's date is the initial date that the window starts,
  and the end time is used for calculating duration. Specify recurrence in RFC5545 RRULE format, to specify when this recurs.
  EOF
}

variable "maintenance_mode" {
  description = "maintenance to happen on daily basis at given start time or by a recurring window based on settings. value can be daily or recurring"
  type        = string
  default     = "daily"
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS - RECOMMENDED DEFAULTS
# These values shouldn't be changed; they're following the best practices defined at
# https://cloud.google.com/kubernetes-engine/docs/how-to/hardening-your-cluster
# ---------------------------------------------------------------------------------------------------------------------

variable "config_connector_config" {
  description = <<-HEREDOC
                  "Whether to enable Addon OCnfig Connector. This feature is required if you need to deploy
                  anything on GKE cluster using Config Connector"
                HEREDOC
  type        = bool
  default     = true
}

variable "enable_network_policy" {
  description = <<-HEREDOC
                  "Whether to enable Kubernetes NetworkPolicy on the master, which is required to be enabled to be used on Nodes.
                  To enable this, you must also define a network_policy block, otherwise nothing will happen"
                HEREDOC
  type        = bool
  default     = true
}

variable "enable_pod_security_policy" {
  description = "Flag to enable pod security policy"
  type        = bool
  default     = true
}

variable "network_policy_provider" {
  description = "Kubernetes NetworkPolicy provider."
  type        = string
  default     = "PROVIDER_UNSPECIFIED"
}

variable "valid_regions" {
  description = "Valid and supported regions"
  type        = list(string)
  default     = ["europe-west2", "europe-west4"]
}

variable "enable_csi_driver" {
  description = <<-HEREDOC
                  "Whether this cluster should enable the Google Compute Engine Persistent Disk Container Storage Interface (CSI) Driver.
                  Defaults to disabled; set true to enable."
                HEREDOC
  type        = bool
  default     = null
}

variable "vertical_pod_autoscaling" {
  description = "Vertical Pod Autoscaling automatically adjusts the resources of pods controlled by it."
  type        = bool
  default     = null
}

variable "enable_intranode_visibility" {
  description = "Whether Intra-node visibility is enabled for this cluster. This makes same node pod to pod traffic visible for VPC network"
  type        = bool
  default     = null
}

# ---------------------------------------------------------------------------------------------------------------------
# Node pool PARAMETERS
# ---------------------------------------------------------------------------------------------------------------------


variable "node_pool_name" {
  description = "Name of the node pool"
  type        = string
  default     = "node-pool"
}

variable "initial_node_count" {
  type        = number
  description = "The number of nodes to create in this cluster's default node pool per zone."
  default     = 1
}

variable "image_type" {
  description = "operating system on the node"
  type        = string
  default     = "COS_CONTAINERD"
}

variable "disk_size_gb" {
  type        = number
  description = "The size of disk for a node in the pool."
  default     = 100
}

variable "machine_type" {
  type        = string
  description = "Machine type."
  default     = "n1-standard-1"
}

variable "disk_type" {
  type        = string
  description = "Disk type."
  default     = "pd-standard"
}

variable "min_node_count" {
  type        = number
  description = "Minimum number of nodes in the NodePool. Must be >=0 and <= max_node_count."
  default     = 1
}

variable "max_node_count" {
  type        = number
  description = "Maximum number of nodes in the NodePool. Must be >= min_node_count."
  default     = 4
}

variable "auto_repair" {
  type        = bool
  description = "Whether the nodes will be automatically repaired. Possible values are true or false"
  default     = true
}

variable "auto_upgrade" {
  type        = bool
  description = "Whether the nodes will be automatically upgraded. Possible values are true or false"
  default     = false
}

variable "preemptible" {
  type        = bool
  description = "A boolean that represents whether or not the underlying node VMs are preemptible."
  default     = false
}

variable "tags" {
  description = "tags on the node pool"
  type        = list(string)
  default = [
    "private",
    "private-pool",
  ]
}

variable "oauth_scopes" {
  description = "oauth scopes"
  type        = list(string)
  default = [
    "https://www.googleapis.com/auth/cloud-platform",
  ]
}

variable "service_account_email" {
  description = "The service account email to run nodes."
  type        = string
}

variable "svc_acc_roles" {
  description = "Roles needs for workload identity service account"
  type        = list(string)
  default     = ["roles/logging.logWriter", "roles/monitoring.metricWriter", "roles/monitoring.viewer"]
}

variable "resource_labels" {
  description = <<-HEREDOC
                  "resource_labels on the cluster should contain map of key value pairs.
                  Ensure there are labels for owner, cost_centre and dataclassification"
                HEREDOC
  type        = map(string)
}

variable "valid_resource_labels" {
  description = "Valid and supported resource_labels"
  type        = list(string)
  default = ["owner", "cost_centre", "dataclassification", "spi_onboarding",
  "valuestream", "workstream", "cluster_group", "region", "environment", "app_onboarding_repo"]
}

variable "gke_rbac_sec_group" {
  description = "Google group with the org tld to be used for GKE RBAC"
  type        = string
  default     = "gke-security-groups@e.lloydsbanking.com"
}

variable "release_channel" {
  type        = string
  default     = ""
  description = <<EOF
  The selected release channel. Accepted values are:
  UNSPECIFIED: Not set.
  RAPID: Weekly upgrade cadence; Early testers and developers who requires new features.
  REGULAR: Multiple per month upgrade cadence; Production users who need features not yet offered in the Stable channel.
  STABLE: Every few months upgrade cadence; Production users who need stability above all else, and for whom frequent upgrades are too risky.
  EOF
}

variable "resource_usage_export_config" {
  type = object({ enable_network_egress_metering = bool,
    enable_resource_consumption_metering = bool,
  bigquery_destination = object({ dataset_id = string }) })
  default     = { enable_network_egress_metering : false, enable_resource_consumption_metering : false, bigquery_destination : { dataset_id = "" } }
  description = <<EOF
  If enabled, a daemonset will be created in the cluster to meter network egress traffic.
  * enable_resource_consumption_metering (Optional) - Whether to enable resource consumption metering on this cluster.
    When enabled, a table will be created in the resource export BigQuery dataset to store resource consumption data.
    The resulting table can be joined with the resource usage table or with BigQuery billing export. Defaults to true.
  * bigquery_destination (Required) - Parameters for using BigQuery as the destination of resource usage export.
  * bigquery_destination.dataset_id (Required) - The ID of a BigQuery Dataset. For Example:
  resource_usage_export_config = {
    enable_network_egress_metering = false
    enable_resource_consumption_metering = true

    bigquery_destination = {
      dataset_id = "cluster_resource_usage"
    }
  }
  EOF
}

variable "database_encryption" {
  type        = object({ state = string, key_name = string, key_project_id = string, location = string, ring_name = string })
  default     = { state : "ENCRYPTED", key_name : "", key_project_id : "", location : "", ring_name : "" }
  description = <<EOF
  By default, GKE encrypts customer content stored at rest, including Secrets.
  GKE handles and manages this default encryption for you without any additional action.
  Settings provides an additional layer of security for sensitive data, such as Secrets, stored in etcd.
  state - (Required) ENCRYPTED or DECRYPTED
  key_name - (Required) the key to use to encrypt/decrypt secrets. See the DatabaseEncryption definition for more information.
  EOF
}

variable "volume_encryption" {
  type        = object({ state = string, key_name = string, key_project_id = string, location = string, ring_name = string })
  default     = { state : "ENCRYPTED", key_name : "", key_project_id : "", location : "", ring_name : "" }
  description = <<EOF
  The Customer Managed Encryption Key used to encrypt the boot disk attached to each node in the node pool.
  This should be of the form projects/[KEY_PROJECT_ID]/locations/[LOCATION]/keyRings/[RING_NAME]/cryptoKeys/[KEY_NAME].
  For more information about protecting resources with Cloud KMS Keys please
  see: https://cloud.google.com/compute/docs/disks/customer-managed-encryption
  EOF
}

variable "enable_shielded_nodes" {
  type        = bool
  description = "Enable Shielded Nodes features on all nodes in this cluster. Defaults to true."
  default     = true
}

variable "enable_shielded_nodes" {
  type        = bool
  description = "Enable Shielded Nodes features on all nodes in this cluster. Defaults to true."
  default     = true
}
variable "enable_shielded_nodes" {
  type        = bool
  description = "Enable Shielded Nodes features on all nodes in this cluster. Defaults to true."
  default     = true
}

variable "additional_node_pools" {
  type        = list(map(string))
  description = "List of maps containing additional node pools"
  default     = []
}

variable "enable_secure_boot" {
  type        = bool
  description = "Defines if the node instance has Secure Boot enabled."
  default     = true
}

variable "enable_master_global_access" {
  type        = bool
  description = "Whether the cluster master is accessible globally or not. Note that once enabled it cannot be disabled"
  default     = true
}

variable "taint" {
  type        = list(object({ key = string, value = string, effect = string }))
  default     = [{ "key" : "", "value" : "", "effect" : "" }]
  description = <<EOF
  A list of Kubernetes taints to apply to nodes in nodepool. GKE's API can only set this field on cluster creation.
  However, GKE will add taints to your nodes if you enable certain features such as GPUs.
  any update to this field after nodeool creation will be ignored. Structure is documented below.
  key - Key for taint.
  value - Value for taint.
  effect - Effect for taint. Accepted values are NO_SCHEDULE, PREFER_NO_SCHEDULE, and NO_EXECUTE.
  EOF
}

variable "upgrade_settings" {
  type        = object({ max_surge = number, max_unavailable = number })
  default     = { max_surge : 1, max_unavailable : 0 }
  description = <<-HEREDOC
  Specify node upgrade settings to change how many nodes GKE attempts to upgrade at once.
  The number of nodes upgraded simultaneously is the sum of max_surge and max_unavailable.
  The maximum number of nodes upgraded simultaneously is limited to 20
  max_surge - The number of additional nodes that can be added to the node pool during an upgrade.
  Increasing max_surge raises the number of nodes that can be upgraded simultaneously. Can be set to 0 or greater.
  max_unavailable - The number of nodes that can be simultaneously unavailable during an upgrade.
  Increasing max_unavailable raises the number of nodes that can be upgraded in parallel. Can be set to 0 or greater.
  see https://cloud.google.com/kubernetes-engine/docs/concepts/cluster-upgrades?&_ga=2.214574228.-2045790325.1584615127#surge
  HEREDOC
}
