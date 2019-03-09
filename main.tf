/**
 * DC/OS VPC
 * ===========
 * This is an module to create a AWS VPC specially used for DC/OS
 *
 * This modules creates a subnet for every .
 *
 * EXAMPLE
 * -------
 *```hcl
 * module "dcos-vpc" {
 *   source  = "dcos-terraform/vpc/aws"
 *   version = "~> 0.1.0"
 *
 *   cluster_name = "production"
 *   availability_zones = ["us-east-1b"]
 *   subnet_range = "172.12.0.0/16"
 *   # providers {
 *   # aws = "aws.my-provider"
 *   # }
 *   existing_vpc_name = "my-vpc-name"
 *   existing_subnet_prefix = "my-subnet-prefix"
 * }
 *```
 */
provider "aws" {}

// if availability zones is not set request the available in this region
data "aws_availability_zones" "available" {}

data "aws_vpc" "existing_vpc" {
  count = "${var.existing_vpc_name == "" ? 0 : 1}"

  filter {
    "name"   = "tag:Name"
    "values" = ["${var.existing_vpc_name}"]
  }
}

data "aws_subnet_ids" "existing_subnet_ids" {
  count  = "${var.existing_vpc_name == "" ? 0 : 1}"
  vpc_id = "${join("", data.aws_vpc.existing_vpc.*.id)}"

  tags {
    "Name" = "${var.existing_subnet_prefix}*"
  }
}

data "aws_subnet" "existing_subnets" {
  count = "${var.existing_vpc_name == "" ? 0 : length(data.aws_subnet_ids.existing_subnet_ids.*.ids)}"
  id    = "${data.aws_subnet_ids.existing_subnet_ids.ids[count.index]}"
}

# Create a VPC to launch our instances into, if existing vpc not set
resource "aws_vpc" "dcos_vpc" {
  count = "${var.existing_vpc_name == "" ? 1 : 0}"
  tags  = "${merge(var.tags, map("Name", var.cluster_name,
                                "Cluster", var.cluster_name))}"

  cidr_block           = "${var.subnet_range}"
  enable_dns_support   = true
  enable_dns_hostnames = true
}

# Create a subnet to launch our instances into
resource "aws_subnet" "dcos_subnet" {
  # Only create new subnets if not using an existing VPC
  count  = "${var.existing_vpc_name == "" ? length(var.availability_zones) : 0}"
  vpc_id = "${join("", aws_vpc.dcos_vpc.*.id)}"

  cidr_block = "${cidrsubnet(join("", aws_vpc.dcos_vpc.*.cidr_block), 4, count.index)}"

  availability_zone = "${element(coalescelist(var.availability_zones, data.aws_availability_zones.available.names), count.index)}"

  map_public_ip_on_launch = true

  tags = "${merge(var.tags, map("Name", var.cluster_name,
                                "Cluster", var.cluster_name))}"
}

# Only create an internet gateway if creating a new VPC
resource "aws_internet_gateway" "default" {
  count  = "${var.existing_vpc_name == "" ? 1 : 0}"
  vpc_id = "${join("", aws_vpc.dcos_vpc.*.id)}"

  tags = "${merge(var.tags, map("Name", var.cluster_name,
                                "Cluster", var.cluster_name))}"
}

# Grant the VPC internet access on its main route table
resource "aws_route" "internet_access" {
  count = "${var.existing_vpc_name == "" ? 1 : 0}"

  route_table_id = "${join("", aws_vpc.dcos_vpc.*.main_route_table_id)}"

  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.default.id}"
}
