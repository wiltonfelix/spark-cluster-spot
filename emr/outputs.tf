output "dns_master" { value = "ssh -i ${var.key_name}.pem hadoop@${module.elastic_map_reduce.dns_master}"}
