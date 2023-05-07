resource "aws_lb" "this" {
  name               = "${var.prefix}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = var.public_subnet_ids

  enable_deletion_protection = var.lb_delete_protection
}

resource "aws_lb_target_group" "this" {
  name        = "${var.prefix}-${var.ecs_container_port}"
  port        = var.ecs_container_port
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  health_check {
    interval            = var.lb_healthcheck_interval
    path                = var.lb_healthcheck_path
    protocol            = "HTTP"
    timeout             = var.lb_healthcheck_timeout
    healthy_threshold   = var.lb_healthcheck_healthy_threshold
    unhealthy_threshold = var.lb_healthcheck_unhealthy_threshold
    matcher             = var.lb_healthcheck_matcher
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.this.arn

  default_action {
    target_group_arn = aws_lb_target_group.this.arn
    type             = "forward"
  }

  depends_on = [aws_lb_target_group.this]
}
