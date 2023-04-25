resource "aws_ecs_cluster" "this" {
  name = "${var.prefix}-${var.ecs_cluster_name}"
}

resource "aws_ecs_task_definition" "this" {
  family                   = "${var.prefix}-ssr"
  cpu                      = 256
  memory                   = 512
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  task_role_arn            = aws_iam_role.task.arn
  execution_role_arn       = aws_iam_role.task_execution.arn

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = var.ecs_cpu_architecture
  }

  container_definitions = jsonencode([
    {
      "name" : "ssr",
      "image" : var.ecs_container_image,
      "cpu" : 0,
      "memory" : 512,
      "essential" : true,
      "portMappings" : [
        {
          "protocol" : "tcp",
          "containerPort" : var.ecs_container_port,
        }
      ],
      "environment" : var.ecs_environment,
      "logConfiguration" : {
        "logDriver" : "awslogs",
        "options" : {
          "awslogs-group" : local.log_group_name,
          "awslogs-region" : "ap-northeast-1",
          "awslogs-stream-prefix" : "${var.ecs_service_name}"
        }
      },
    }
  ])
}

resource "aws_ecs_service" "this" {
  name             = var.ecs_service_name
  cluster          = aws_ecs_cluster.this.id
  task_definition  = aws_ecs_task_definition.this.arn
  desired_count    = var.ecs_desired_count
  launch_type      = "FARGATE"
  platform_version = "LATEST"

  network_configuration {
    subnets          = var.private_subnet_ids
    security_groups  = [aws_security_group.ecs.id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.this.arn
    container_name   = "ssr"
    container_port   = var.ecs_container_port
  }

  propagate_tags = "TASK_DEFINITION"

  lifecycle {
    ignore_changes = [desired_count]
  }
}

resource "aws_appautoscaling_target" "this" {
  max_capacity       = 2
  min_capacity       = 1
  resource_id        = "service/${aws_ecs_cluster.this.name}/${aws_ecs_service.this.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "this" {
  name               = "${var.prefix}-target-tracking-scaling-policy"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.this.resource_id
  scalable_dimension = aws_appautoscaling_target.this.scalable_dimension
  service_namespace  = aws_appautoscaling_target.this.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }

    target_value       = 75
    scale_out_cooldown = 180
    scale_in_cooldown  = 300
  }
}
