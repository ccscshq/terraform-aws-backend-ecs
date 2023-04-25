variable "prefix" {
  description = "Name prefix for resources."
  type        = string
}

# acm
variable "hosted_zone_domain" {
  description = "Domain name to use for the Route53 hosted zone."
  type        = string
}
variable "api_domain" {
  description = "Domain name to use for the web API."
  type        = string
}

# ecs
variable "ecs_cluster_name" {
  description = "Name of ECS cluster."
  type        = string
}
variable "ecs_service_name" {
  description = "Name of ECS service."
  type        = string
}
variable "ecs_container_image" {
  description = "URL of container image."
  type        = string
}
variable "ecs_container_port" {
  description = "Port number of container."
  type        = number
}
variable "ecs_desired_count" {
  description = "Disired count."
  type        = number
  default     = 1
}
variable "ecs_environment" {
  description = "Environment variables."
  type        = set(map(string))
  default     = []
}
variable "ecs_task_policy_arns" {
  description = "IAM policy arns for ecs task role."
  type        = set(string)
  default     = []
}
variable "ecs_cpu_architecture" {
  description = "CPU archtecture of ECS."
  type        = string
  default     = "X86_64"

  validation {
    condition     = contains(["X86_64", "ARM64"], var.ecs_cpu_architecture)
    error_message = "The only possible value for ECS CPU Archtecture is X86_64 or ARM64."
  }
}

# lb
variable "lb_healthcheck_path" {
  description = "Path for ALB health check."
  type        = string
  default     = "/"
}
variable "lb_delete_protection" {
  description = "ALB delete protection."
  type        = bool
  default     = true
}

# network
variable "vpc_id" {
  description = "ID of the VPC."
  type        = string
}
variable "public_subnet_ids" {
  description = "IDs of the public subnet."
  type        = set(string)
}
variable "private_subnet_ids" {
  description = "IDs of the private subnet."
  type        = set(string)
}
