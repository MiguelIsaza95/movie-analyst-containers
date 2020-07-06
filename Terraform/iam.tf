resource "aws_iam_role" "cluster_instance_role" {
  description        = "cluster-instance-role"
  assume_role_policy = file("${path.module}/policies/cluster-instance-role.json")
}

data "template_file" "cluster_instance_policy" {
  template = file("${path.module}/policies/cluster-instance-policy.json")
}

resource "aws_iam_policy" "cluster_instance_policy" {
  description = "cluster-instance-policy"
  policy      = data.template_file.cluster_instance_policy.rendered
}

resource "aws_iam_policy_attachment" "cluster_instance_policy_attachment" {
  name       = "cluster-instance-policy-attachment"
  roles      = [aws_iam_role.cluster_instance_role.id]
  policy_arn = aws_iam_policy.cluster_instance_policy.arn
}

resource "aws_iam_instance_profile" "cluster" {
  name = "cluster-instance-profile"
  path = "/ecs/"
  role = aws_iam_role.cluster_instance_role.name
}

resource "aws_iam_role" "cluster_service_role" {
  description        = "cluster-service-role"
  assume_role_policy = file("${path.module}/policies/cluster-service-role.json")
}

resource "aws_iam_policy" "cluster_service_policy" {
  description = "cluster-service-policy"
  policy      = file("${path.module}/policies/cluster-service-policy.json")
}