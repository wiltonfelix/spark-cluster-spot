data "aws_vpc" "source" {
  tags {
    Name = "${var.name_vpc}"
  }
}

data "aws_subnet_ids" "source_subnets" {
  vpc_id = "${data.aws_vpc.source.id}"
  tags {
    Name = "*${var.subnet_name}*"
  }
}

data "aws_subnet" "get_subnets" {
  count = "${length(data.aws_subnet_ids.source_subnets.ids)}"
  id = "${data.aws_subnet_ids.source_subnets.ids[count.index]}"
}
