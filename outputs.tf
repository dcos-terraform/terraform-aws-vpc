output "cidr_block" {
  description = "AWS vpc cidr_block"
  value       = "${aws_vpc.dcos_vpc.cidr_block}"
}

output "aws_main_route_table_id" {
  description = "AWS main route table id"
  value       = "${aws_vpc.dcos_vpc.main_route_table_id}"
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
  value       = "${aws_vpc.dcos_vpc.id}"
}
