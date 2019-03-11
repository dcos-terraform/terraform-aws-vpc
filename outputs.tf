output "cidr_block" {
  description = "Output the cidr_block used within this network"

  value = "${length(var.existing_vpc_name) == 0 ?
    join("", aws_vpc.dcos_vpc.*.cidr_block) :
    join("", data.aws_vpc.existing_vpc.*.cidr_block)
  }"
}

output "aws_main_route_table_id" {
  description = "AWS main route table id"

  value = "${length(var.existing_vpc_name) == 0 ?
    join("", aws_vpc.dcos_vpc.*.main_route_table_id) :
    join("", data.aws_vpc.existing_vpc.*.main_route_table_id)
  }"
}

output "subnet_ids" {
  description = "List of subnet IDs created in this network"

  value = "${split(",", length(var.existing_vpc_name) == 0 ?
    join(",", aws_subnet.dcos_subnet.*.id) :
    join(",", flatten(data.aws_subnet_ids.existing_subnet_ids.*.ids))
  )}"
}

output "vpc_id" {
  description = "AWS VPC ID"

  value = "${length(var.existing_vpc_name) == 0 ?
    join("", aws_vpc.dcos_vpc.*.id) :
    join("", data.aws_vpc.existing_vpc.*.id)
  }"
}
