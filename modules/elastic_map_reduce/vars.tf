variable "app_name" {
  default = ""
}

variable "environment" {
  default = ""
}

variable "applications" {
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
  default = ""
}

variable "subnet_id" {
  default = ""
}

variable "instance_type_core" {
  default = ""
}

variable "instance_number_cores" {
  default = "1"
}

variable "instance_type_master" {
  default = "m4.xlarge"
}

variable "ebs_volume" {
  default = "30"
}

variable "bucket_s3" {
  default = ""
}

variable "key_name" {
  default = ""
}

variable "security_group" {
  default = ""
}

variable "security_group_acess_security" {
  default = ""
}

variable "aws_iam_instance_profile" {
  default = ""
}

variable "aws_iam_role_service" {
  default = ""
}

variable "bid_price_instance_spot" {
  default = ""
}

variable "aws_iam_autoscaling_role" {
  default = ""
}

variable "instance_type_task" {
  default = ""
}

variable "min_scaling" {
  default = ""
}

variable "max_scaling" {
  default = ""
}
