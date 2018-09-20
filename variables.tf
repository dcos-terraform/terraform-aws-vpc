variable "availability_zones" {
  description = "Availability zones to be used"
  type        = "list"
  default     = []
}

variable "cluster_name" {
  description = "Cluster name all resources get named and tagged with"
}

variable "subnet_range" {
  description = "Private IP space to be used in CIDR format"
  default     = "172.31.0.0/16"
}

variable "tags" {
  description = "Custom tags added to the resources created by this module"
  type        = "map"
  default     = {}
}
