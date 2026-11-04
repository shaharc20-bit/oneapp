data "aws_iam_policy_document" "ec2_assume" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "monitor_read" {
  statement {
    actions = [
      "ec2:DescribeInstances",
      "ec2:DescribeVpcs",
      "ec2:DescribeImages",
      "elasticloadbalancing:DescribeLoadBalancers",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role" "builder" {
  name               = "builder-role-${var.owner}"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume.json
}

resource "aws_iam_role_policy" "monitor_read" {
  name   = "flask-aws-monitor-read"
  role   = aws_iam_role.builder.id
  policy = data.aws_iam_policy_document.monitor_read.json
}

resource "aws_iam_instance_profile" "builder" {
  name = "builder-profile-${var.owner}"
  role = aws_iam_role.builder.name
}
