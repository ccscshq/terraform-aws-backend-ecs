data "aws_ecr_repository" "this" {
  name = "spring-boot"
}

module "network" {
  source = "git@github.com:ccscshq/terraform-aws-network.git?ref=v0.1.0"

  prefix                 = local.prefix
  ipv4_cidr              = local.ipv4_cidr
  ipv4_cidr_newbits      = local.ipv4_cidr_newbits
  subnets_number         = local.subnets_number
  create_private_subnets = true
}

module "ecs" {
  source = "../../"

  prefix = local.prefix
  # acm
  hosted_zone_domain = "example.com"
  api_domain         = "api.example.com"
  # ecs
  ecs_cluster_name     = "ccscshq"
  ecs_service_name     = "api"
  ecs_container_image  = "${data.aws_ecr_repository.this.repository_url}:latest"
  ecs_container_port   = 8080
  ecs_desired_count    = 2
  ecs_environment      = []
  ecs_task_policy_arns = []
  ecs_cpu_architecture = "X86_64"
  # lb
  lb_healthcheck_interval            = 30
  lb_healthcheck_path                = "/actuator/health"
  lb_healthcheck_timeout             = 3
  lb_healthcheck_healthy_threshold   = 2
  lb_healthcheck_unhealthy_threshold = 5
  lb_healthcheck_matcher             = "200-204"
  lb_delete_protection               = false
  # network
  vpc_id             = module.network.vpc_id
  public_subnet_ids  = module.network.public_subnet_ids
  private_subnet_ids = module.network.private_subnet_ids
}
