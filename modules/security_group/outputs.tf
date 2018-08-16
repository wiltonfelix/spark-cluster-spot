output "security_group_id" {value = "${join(",", aws_security_group.elastic_map_reduce_security_group.*.id)}"}
output "security_group_id_access_id" {value = "${join(",", aws_security_group.elastic_map_reduce_security_group_access.*.id)}"}
