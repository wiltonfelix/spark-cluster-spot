resource "aws_iam_role" "iam_emr_service_role" {
  name = "aws-${var.environment}-${var.app_name}-emr-service-role"

  assume_role_policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "elasticmapreduce.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "iam_emr_service_policy" {
  name = "aws-${var.environment}-${var.app_name}-emr-serive-policy"
  role = "${aws_iam_role.iam_emr_service_role.id}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [{
        "Effect": "Allow",
        "Resource": "*",
        "Action": [
          "ec2:*",
          "iam:*",
          "s3:CreateBucket",
          "s3:Get*",
          "s3:List*",
          "sdb:BatchPutAttributes",
          "sdb:Select",
          "sqs:CreateQueue",
          "sqs:Delete*",
          "sqs:GetQueue*",
          "sqs:PurgeQueue",
          "sqs:ReceiveMessage",
          "cloudwatch:*",
          "application-autoscaling:*",
          "autoscaling:*",
          "elasticmapreduce:*"
        ]
    }]
}
EOF
}

resource "aws_iam_role" "iam_emr_profile_role" {
  name = "aws-${var.environment}-${var.app_name}-emr-profile-role"

  assume_role_policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "emr_profile" {
  name = "aws-${var.environment}-${var.app_name}-emr-profile"
  role = "${aws_iam_role.iam_emr_profile_role.name}"
}

resource "aws_iam_role_policy" "iam_emr_profile_policy" {
  name = "aws-${var.environment}-${var.app_name}-emr-profile-policy"
  role = "${aws_iam_role.iam_emr_profile_role.id}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [{
        "Effect": "Allow",
        "Resource": "*",
        "Action": [
          "cloudwatch:*",
          "dynamodb:*",
          "kinesis:CreateStream",
          "kinesis:DeleteStream",
          "kinesis:DescribeStream",
          "kinesis:GetRecords",
          "kinesis:GetShardIterator",
          "kinesis:MergeShards",
          "kinesis:PutRecord",
          "kinesis:SplitShard",
          "rds:Describe*",
          "s3:*",
          "sdb:*",
          "sns:*",
          "sqs:*",
          "glue:CreateDatabase",
          "glue:UpdateDatabase",
          "glue:DeleteDatabase",
          "glue:GetDatabase",
          "glue:GetDatabases",
          "glue:CreateTable",
          "glue:UpdateTable",
          "glue:DeleteTable",
          "glue:GetTable",
          "glue:GetTables",
          "glue:GetTableVersions",
          "glue:CreatePartition",
          "glue:BatchCreatePartition",
          "glue:UpdatePartition",
          "glue:DeletePartition",
          "glue:BatchDeletePartition",
          "glue:GetPartition",
          "glue:GetPartitions",
          "glue:BatchGetPartition",
          "glue:CreateUserDefinedFunction",
          "glue:UpdateUserDefinedFunction",
          "glue:DeleteUserDefinedFunction",
          "glue:GetUserDefinedFunction",
          "glue:GetUserDefinedFunctions",
          "cloudwatch:*",
          "autoscaling:*",
          "application-autoscaling:*",
          "elasticmapreduce:*"
        ]
    }]
}
EOF
}

resource "aws_iam_role" "iam_emr_autoscaling" {
  name = "aws-${var.environment}-${var.app_name}-emr-autoscaling"

  assume_role_policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "elasticmapreduce.amazonaws.com",
          "application-autoscaling.amazonaws.com"
        ]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "iam_emr_autoscaling_policy" {
  name = "aws-${var.environment}-${var.app_name}-emr-autoscaling-policy"
  role = "${aws_iam_role.iam_emr_autoscaling.id}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [{
        "Effect": "Allow",
        "Resource": "*",
        "Action": [
          "cloudwatch:*",
          "elasticmapreduce:*"
        ]
    }]
}
EOF
}
