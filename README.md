# terraform-aws-backend-ecs

The module provides the infrastructure for the backend application on the ECS.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate_validation.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate_validation) | resource |
| [aws_appautoscaling_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_target.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target) | resource |
| [aws_cloudwatch_log_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_ecs_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster) | resource |
| [aws_ecs_service.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_iam_role.task](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.task_execution](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.task](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.task_execution](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lb.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_route53_record.acm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_security_group.alb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.ecs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.alb_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.alb_ingress_443](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.alb_ingress_80](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ecs_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ecs_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_route53_zone.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_domain"></a> [api\_domain](#input\_api\_domain) | Domain name to use for the web API. | `string` | n/a | yes |
| <a name="input_ecs_cluster_name"></a> [ecs\_cluster\_name](#input\_ecs\_cluster\_name) | Name of ECS cluster. | `string` | n/a | yes |
| <a name="input_ecs_container_image"></a> [ecs\_container\_image](#input\_ecs\_container\_image) | URL of container image. | `string` | n/a | yes |
| <a name="input_ecs_container_port"></a> [ecs\_container\_port](#input\_ecs\_container\_port) | Port number of container. | `number` | n/a | yes |
| <a name="input_ecs_cpu_architecture"></a> [ecs\_cpu\_architecture](#input\_ecs\_cpu\_architecture) | CPU archtecture of ECS. | `string` | `"X86_64"` | no |
| <a name="input_ecs_desired_count"></a> [ecs\_desired\_count](#input\_ecs\_desired\_count) | Disired count. | `number` | `1` | no |
| <a name="input_ecs_environment"></a> [ecs\_environment](#input\_ecs\_environment) | Environment variables. | `set(map(string))` | `[]` | no |
| <a name="input_ecs_service_name"></a> [ecs\_service\_name](#input\_ecs\_service\_name) | Name of ECS service. | `string` | n/a | yes |
| <a name="input_ecs_task_policy_arns"></a> [ecs\_task\_policy\_arns](#input\_ecs\_task\_policy\_arns) | IAM policy arns for ecs task role. | `set(string)` | `[]` | no |
| <a name="input_hosted_zone_domain"></a> [hosted\_zone\_domain](#input\_hosted\_zone\_domain) | Domain name to use for the Route53 hosted zone. | `string` | n/a | yes |
| <a name="input_lb_delete_protection"></a> [lb\_delete\_protection](#input\_lb\_delete\_protection) | ALB delete protection. | `bool` | `true` | no |
| <a name="input_lb_healthcheck_healthy_threshold"></a> [lb\_healthcheck\_healthy\_threshold](#input\_lb\_healthcheck\_healthy\_threshold) | Number of consecutive health check successes required before considering a target healthy. The range is 2-10. | `number` | `2` | no |
| <a name="input_lb_healthcheck_interval"></a> [lb\_healthcheck\_interval](#input\_lb\_healthcheck\_interval) | Approximate amount of time, in seconds, between health checks of an individual target. The range is 5-300. | `number` | `30` | no |
| <a name="input_lb_healthcheck_matcher"></a> [lb\_healthcheck\_matcher](#input\_lb\_healthcheck\_matcher) | Response codes to use when checking for a healthy responses from a target. You can specify multiple values (for example, "200,202") or a range of values (for example, "200-299"). | `string` | `"200-204"` | no |
| <a name="input_lb_healthcheck_path"></a> [lb\_healthcheck\_path](#input\_lb\_healthcheck\_path) | Path for ALB health check. | `string` | `"/"` | no |
| <a name="input_lb_healthcheck_timeout"></a> [lb\_healthcheck\_timeout](#input\_lb\_healthcheck\_timeout) | Amount of time, in seconds, during which no response from a target means a failed health check. The range is 2–120 seconds. | `number` | `3` | no |
| <a name="input_lb_healthcheck_unhealthy_threshold"></a> [lb\_healthcheck\_unhealthy\_threshold](#input\_lb\_healthcheck\_unhealthy\_threshold) | Number of consecutive health check failures required before considering a target unhealthy. The range is 2-10. | `number` | `5` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Name prefix for resources. | `string` | n/a | yes |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | IDs of the private subnet. | `set(string)` | n/a | yes |
| <a name="input_public_subnet_ids"></a> [public\_subnet\_ids](#input\_public\_subnet\_ids) | IDs of the public subnet. | `set(string)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of the VPC. | `string` | n/a | yes |

## Outputs

No outputs.
