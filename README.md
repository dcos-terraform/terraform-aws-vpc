DC/OS VPC
===========
This is an module to create a AWS VPC specially used for DC/OS

This modules creates a subnet for every .

EXAMPLE
-------
```hcl
module "dcos-vpc" {
  source  = "dcos-terraform/vpc/aws"
  version = "~> 0.1"

  cluster_name = "production"
  availability_zones = ["us-east-1b"]
  subnet_range = "172.12.0.0/16"
  # providers {
  # aws = "aws.my-provider"
  # }
}
```


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| availability_zones | Availability zones to be used | list | `<list>` | no |
| cluster_name | Cluster name all resources get named and tagged with | string | `dcos-example` | no |
| subnet_range | Private IP space to be used in CIDR format | string | `172.31.0.0/16` | no |
| tags | Custom tags added to the resources created by this module | map | `<map>` | no |

## Outputs

| Name | Description |
|------|-------------|
| aws_main_route_table_id | AWS Route table ID used in the Network |
| subnet_ids | List of subnet IDs created in this Network |
| subnets | List of subnet IDs created in this Network |
| vpc_id | AWS VPC ID |

