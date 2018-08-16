output "aws_iam_instance_profile" {
  value = "${aws_iam_instance_profile.emr_profile.arn}"
}

output "aws_iam_role_service" {
  value = "${aws_iam_role.iam_emr_service_role.arn}"
}

output "aws_iam_role_autoscaling" {
  value = "${aws_iam_role.iam_emr_autoscaling.arn}"
}
