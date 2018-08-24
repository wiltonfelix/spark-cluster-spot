provider "aws" {
  region     = "${var.region}"
}

terraform {
  backend "s3" {
    bucket = "infra-as-code-git"
    key    = "data/emr"
    region = "us-east-1"
  }
}

module "data_source" {
  source       = "../modules/data_source"
  name_vpc     = "${var.name_vpc}"
  subnet_name  = "${var.subnet_name}"
}

module "security_group" {
  source      = "../modules/security_group"
  environment = "${var.environment}"
  app_name    = "${var.app_name}"
  vpc_id      = "${module.data_source.vpc_id}"
  protocol    = "${var.protocol}"
  from_port   = "${var.from_port}"
  to_port     = "${var.to_port}"
  range       = "${var.range}"
}

module "roles" {
  source      = "../modules/iam_role"
  app_name    = "${var.app_name}"
  environment = "${var.environment}"
}

module "elastic_map_reduce" {
  source                        = "../modules/elastic_map_reduce"
  app_name                      = "${var.app_name}"
  environment                   = "${var.environment}"
  applications                  = "${var.applications}"
  release_label                 = "${var.release_label}"
  termination_protection        = "${var.termination_protection}"
  keep_job                      = "${var.keep_job}"
  vpc_id                        = "${module.data_source.vpc_id}"
  subnet_id                     = "${module.data_source.subnet_ids[0]}"
  instance_type_core            = "${var.instance_type_core}"
  instance_number_cores         = "${var.instance_number_cores}"
  instance_type_master          = "${var.instance_type_master}"
  ebs_volume                    = "${var.ebs_volume}"
  bucket_s3                     = "${var.bucket_s3}"
  key_name                      = "${var.key_name}"
  bid_price_instance_spot       = "${var.bid_price_instance_spot}"
  aws_iam_instance_profile      = "${module.roles.aws_iam_instance_profile}"
  aws_iam_role_service          = "${module.roles.aws_iam_role_service}"
  aws_iam_autoscaling_role      = "${module.roles.aws_iam_role_autoscaling}"
  security_group                = "${module.security_group.security_group_id}"
  security_group_acess_security = "${module.security_group.security_group_id_access_id}"
  instance_type_task            = "${var.instance_type_task}"
}
