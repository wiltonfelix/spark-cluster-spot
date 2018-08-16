variable "app_name" {
  description = "Tag name to instances"
  default = "spark-dev-spot"
}

variable "environment" {
  description = "Tag environment to instances"
  default = "test"
}

variable "applications" {
  description = "Applications aws supported"
  default = "Spark,Hive"
}

variable "release_label" {
  default = "emr-5.12.0"
}

variable "termination_protection" {
  default = "false"
}

variable "keep_job" {
  default = "true"
}

variable "vpc_id" {
  default = "vpc-a7aaa3de"
}

variable "subnet_id" {
  default = "subnet-071e044f75e67429b"
}

variable "instance_type_core" {
  default = "m3.xlarge"
}

variable "instance_type_task" {
  default = "m3.xlarge"
}

variable "instance_number_cores" {
  default = "1"
}

variable "instance_type_master" {
  default = "m3.xlarge"
}

variable "ebs_volume" {
  default = "30"
}

variable "bucket_s3" {
  default = "s3://test-spot/"
}

variable "key_name" {
  default = "wilton"
}

variable "protocol" {
  default = "tcp"
}

variable "from_port" {
  default = "0"
}

variable "to_port" {
  default = "65535"
}

variable "range" {
  default = "172.16.0.0/12,10.8.0.0/16"
}

variable "bid_price_instance_spot" {
  default = "0.25"
}
