DC/OS VPC
===========
This is an module to create a AWS VPC specially used for DC/OS

This modules creates a subnet for every .

EXAMPLE
-------
```hcl
module "dcos-vpc" {
  source  = "dcos-terraform/vpc/aws"
  version = "~> 0.1.0"

  cluster_name = "production"
  availability_zones = ["us-east-1b"]
  subnet_range = "172.12.0.0/16"
  # providers {
  # aws = "aws.my-provider"
  # }
  existing_vpc_name = "my-vpc-name"
  existing_subnet_prefix = "my-subnet-prefix"
}
```


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| availability_zones | Availability zones to be used | list | `<list>` | no |
| cluster_name | Name of the DC/OS cluster | string | - | yes |
| subnet_range | Private IP space to be used in CIDR format | string | `172.31.0.0/16` | no |
| tags | Add custom tags to all resources | map | `<map>` | no |
| existing_vpc_name | An existing VPC to deploy into | string | - | no (if unset, new VPC will be created) |
| existing_subnet_prefix | A prefix of existing subnets to deploy into. | string | - | no (if unset when `existing_vpc_name`, all subnets in VPC will be selected, so use with caution)

Note: if deploying into existing subnets, be sure to correctly set all `*_associate_public_ip_address` addresses consistently with whether the subnet is public or private, otherwise you may not be able to reach your cluster.
## Outputs

| Name | Description |
|------|-------------|
| aws_main_route_table_id | AWS main route table id |
| cidr_block | Output the cidr_block used within this network |
| subnet_ids | List of subnet IDs created in this network |
| subnets | List of subnet IDs created in this Network |
| vpc_id | AWS VPC ID |
