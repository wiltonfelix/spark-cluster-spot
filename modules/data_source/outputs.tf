output "vpc_id" {
  value = "${data.aws_vpc.source.id}"
}
output "subnet_ids" {
  value = ["${data.aws_subnet.get_subnets.*.id}"]
}
