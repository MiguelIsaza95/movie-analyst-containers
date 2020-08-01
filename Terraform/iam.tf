## ECS role to manage EC2 instance
resource "aws_iam_role" "cluster_instance_role" {
  description        = "cluster-instance-role"
  assume_role_policy = file("${path.module}/policies/cluster_instance_role.json")
}

resource "aws_iam_policy" "cluster_instance_policy" {
  description = "cluster-instance-policy"
  policy      = file("${path.module}/policies/cluster_instance_policy.json")
}

resource "aws_iam_policy_attachment" "cluster_instance_policy_attachment" {
  name       = "cluster-instance-policy-attachment"
  roles      = [aws_iam_role.cluster_instance_role.id]
  policy_arn = aws_iam_policy.cluster_instance_policy.arn
}

resource "aws_iam_instance_profile" "cluster" {
  name = "cluster-instance-profile"
  path = "/ecs/instance"
  role = aws_iam_role.cluster_instance_role.name
}

## ECS role to create services
resource "aws_iam_role" "cluster_service_role" {
  description        = "cluster-service-role"
  path               = "/ecs/service"
  assume_role_policy = file("${path.module}/policies/cluster_service_role.json")
}

resource "aws_iam_policy" "cluster_service_policy" {
  description = "cluster-service-policy"
  policy      = file("${path.module}/policies/cluster_service_policy.json")
}

resource "aws_iam_policy_attachment" "cluster_service_policy_attachment" {
  name       = "cluster-service-policy-attachment"
  roles      = [aws_iam_role.cluster_service_role.id]
  policy_arn = aws_iam_policy.cluster_service_policy.arn
}

## ECS role to manage tasks
resource "aws_iam_role" "cluster_task_role" {
  description        = "cluster-task-role"
  path               = "/ecs/task"
  assume_role_policy = file("${path.module}/policies/cluster_task_role.json")
}

resource "aws_iam_policy" "cluster_task_policy" {
  description = "cluster-task-policy"
  policy      = file("${path.module}/policies/cluster_task_policy.json")
}

resource "aws_iam_policy_attachment" "cluster_task_policy_attachment" {
  name       = "cluster-service-task-attachment"
  roles      = [aws_iam_role.cluster_task_role.id]
  policy_arn = aws_iam_policy.cluster_task_policy.arn
}


## ECS role to manage s3 buckets
resource "aws_iam_role" "ecs_task_role" {
  name               = "role-name-task"
  path               = "/ecs/s3"
  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "ecs-tasks.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "task_s3" {
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}