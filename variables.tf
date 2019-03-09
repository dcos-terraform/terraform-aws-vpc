variable "availability_zones" {
  description = "Availability zones to be used"
  type        = "list"
  default     = []
}

variable "cluster_name" {
  description = "Name of the DC/OS cluster"
}

variable "subnet_range" {
  description = "Private IP space to be used in CIDR format"
  default     = "172.31.0.0/16"
}

variable "tags" {
  description = "Add custom tags to all resources"
  type        = "map"
  default     = {}
}

variable "existing_vpc_name" {
  description = "Name of an existing VPC to deploy into"
  default     = ""
}

variable "existing_subnet_prefix" {
  description = "Prefix of existing VPC subnets to use"
  default     = ""
}
