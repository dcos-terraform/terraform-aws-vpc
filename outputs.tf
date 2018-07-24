output "aws_main_route_table_id" {
  description = "AWS Route table ID used in the Network"
  value = "${aws_vpc.dcos_vpc.main_route_table_id}"
}

output "subnet_ids" {
  description = "List of subnet IDs created in this Network"
  value = ["${aws_subnet.dcos_subnet.*.id}"]
}

output "subnets" {
  description = "List of subnet IDs created in this Network"
  value = ["${aws_subnet.dcos_subnet.*.id}"]
}

output "network_id" {
  description = "Network ID - AWS vPC ID"
  value = "${aws_vpc.dcos_vpc.id}"
}
