resource "aws_emr_cluster" "emr-template-cluster" {
  name          = "${var.app_name}"
  release_label = "${var.release_label}"
  applications  = ["${split(",",var.applications)}"]

  termination_protection            = "${var.termination_protection}"
  keep_job_flow_alive_when_no_steps = "${var.keep_job}"
  autoscaling_role                  = "${var.aws_iam_autoscaling_role}"

  ec2_attributes {
    subnet_id                         = "${var.subnet_id}"
    emr_managed_master_security_group = "${var.security_group}"
    emr_managed_slave_security_group  = "${var.security_group}"
    service_access_security_group     = "${var.security_group_acess_security}"
    instance_profile                  = "${var.aws_iam_instance_profile}"
    key_name                          = "${var.key_name}"
  }

  instance_group = {
    name           = "MasterInstanceGroup"
    instance_role  = "MASTER"
    instance_type  = "${var.instance_type_master}"
    instance_count = "1"
  }

  instance_group = {
    name           = "CoreInstanceGroup"
    instance_role  = "CORE"
    instance_type  = "${var.instance_type_core}"
    instance_count = "${var.instance_number_cores}"
  }

  instance_group = {
    name           = "TaskInstanceGroup"
    instance_role  = "TASK"
    instance_type  = "${var.instance_type_task}"
    instance_count = "1"
    bid_price      = "${var.bid_price_instance_spot}"

    autoscaling_policy = <<EOF
    {
      "Constraints": {
        "MinCapacity": 1,
        "MaxCapacity": 5
        },
      "Rules": [
        {
          "Name": "ScaleOutMemoryPercentage",
          "Description": "Scale out if YARNMemoryAvailablePercentage is less than 15",
          "Action": {
            "SimpleScalingPolicyConfiguration": {
              "AdjustmentType": "CHANGE_IN_CAPACITY",
              "ScalingAdjustment": 1,
              "CoolDown": 60
            }
          },
          "Trigger": {
            "CloudWatchAlarmDefinition": {
              "ComparisonOperator": "LESS_THAN",
              "EvaluationPeriods": 1,
              "MetricName": "YARNMemoryAvailablePercentage",
              "Namespace": "AWS/ElasticMapReduce",
              "Period": 60,
              "Statistic": "AVERAGE",
              "Threshold": 15.0,
              "Unit": "PERCENT"
            }
          }
        },
        {
          "Name": "ScaleOutMemoryPercentageDown",
          "Description": "Down policys",
            "Action": {
              "SimpleScalingPolicyConfiguration": {
                "CoolDown": 60,
                "AdjustmentType": "CHANGE_IN_CAPACITY",
                "ScalingAdjustment": -1
          }
        },
        "Trigger": {
          "CloudWatchAlarmDefinition": {
            "ComparisonOperator": "GREATER_THAN",
            "EvaluationPeriods": 1,
            "MetricName": "YARNMemoryAvailablePercentage",
            "Namespace": "AWS/ElasticMapReduce",
            "Period": 60,
            "Statistic": "AVERAGE",
            "Threshold": 40.0,
            "Unit": "PERCENT"
          }
        }
      }
      ]
      }
EOF
  }

  ebs_root_volume_size = "${var.ebs_volume}"

  tags {
    Environment = "${var.environment}"
    Name        = "${var.app_name}"
  }

  log_uri      = "${var.bucket_s3}"
  service_role = "${var.aws_iam_role_service}"
}
