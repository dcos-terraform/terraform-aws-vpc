output "cidr_block" {
  description = "Output the cidr_block used within this network"
  value       = "${coalesce(aws_vpc.dcos_vpc.cidr_block, "")}"

  # TODO(mbernadin): remove coalesce when nil on destroy is fixed: https://github.com/hashicorp/terraform/issues/17862
}

output "aws_main_route_table_id" {
  description = "AWS main route table id"
  value       = "${coalesce(aws_vpc.dcos_vpc.main_route_table_id, "")}"

  # TODO(mbernadin): remove coalesce when nil on destroy is fixed: https://github.com/hashicorp/terraform/issues/17862
}

output "subnet_ids" {
  description = "List of subnet IDs created in this network"
  value       = ["${aws_subnet.dcos_subnet.*.id}"]
}

output "subnets" {
  description = "List of subnet IDs created in this Network"
  value       = ["${aws_subnet.dcos_subnet.*.id}"]
}

output "vpc_id" {
  description = "AWS VPC ID"
  value       = "${coalesce(aws_vpc.dcos_vpc.id, "")}"

  # TODO(mbernadin): remove coalesce when nil on destroy is fixed: https://github.com/hashicorp/terraform/issues/17862
}
