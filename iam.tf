data "aws_iam_policy_document" "ec2_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecommerce_ec2" {
  name               = "${var.project_name}-ec2-role"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json

  tags = {
    Project = var.project_name
  }
}

data "aws_iam_policy_document" "ecr_pull" {
  statement {
    sid       = "ECRAuthorization"
    effect    = "Allow"
    actions   = ["ecr:GetAuthorizationToken"]
    resources = ["*"]
  }

  statement {
    sid    = "PullProjectImages"
    effect = "Allow"

    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage"
    ]

    resources = [
      aws_ecr_repository.backend.arn,
      aws_ecr_repository.client.arn,
      aws_ecr_repository.admin.arn
    ]
  }
}

resource "aws_iam_role_policy" "ecr_pull" {
  name   = "${var.project_name}-ecr-pull"
  role   = aws_iam_role.ecommerce_ec2.id
  policy = data.aws_iam_policy_document.ecr_pull.json
}

resource "aws_iam_instance_profile" "ecommerce" {
  name = "${var.project_name}-instance-profile"
  role = aws_iam_role.ecommerce_ec2.name
}

resource "aws_iam_role_policy_attachment" "ssm_core" {
  role       = aws_iam_role.ecommerce_ec2.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}
