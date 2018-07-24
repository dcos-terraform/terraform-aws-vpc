variable "availability_zones" {
 description = "Specify the availability zones to be used"
 type = "list"
 default = []
}

variable "cluster_name" {
 description = "Specify the cluster name all resources get named and tagged with"
 default = "dcos-example"
}

variable "subnet_range" {
 description = "Specify the private ip space to be used in a CIDR format"
 default = "172.31.0.0/16"
}

variable "tags" {
  description = "Add special tags to the resources created by this module"
  type = "map"
  default = {}
}
