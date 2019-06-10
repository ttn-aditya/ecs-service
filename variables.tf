/**
 * Required Variables.
 */

variable "name" {
  description = "The service name"
}

variable "cluster" {
  description = "The cluster name"
}

variable "vpc_id" {
  description = "The VPC ID were the ECS is running"
}

variable "zone_id" {
  description = "Zone ID where the ECS service (record) will be added"
}

variable "container_definitions" {
  description = "here you should include the full container definitions"
}

variable "iam_role" {
  description = "IAM Role ARN to use"
}

variable "alb_listener" {
  description = "Listener where the rule will be added"
}

variable "alb_dns_name" {
  description = "DNS name of the ALB where the rule will be added"
}

variable "alb_zone_id" {
  description = "Zone ID where the ALB is hosted"
}

variable "rule_priority" {
  description = "This is the priority number of the listener's rule"
}






/**
 * Optional Variables.
 */

variable "environment" {
  description = "Environment tag, e.g prod"
  default     = "default"
}

variable "container_port" {
  description = "The container port"
  default     = 8080
}

variable "healthcheck" {
  default = {
    healthy_threshold   = 2
    unhealthy_threshold = 5
    timeout             = 5
    path                = "/health"
    interval            = 30
    matcher             = 200
  }
}

variable "desired_count" {
  description = "The desired count"
  default     = 1
}

variable "policy" {
  description = "IAM custom policy to be attached to the task role"
  default     = ""
}

variable "cookie_duration" {
  description = "The time period, in seconds, during which requests from a client should be routed to the same target.The range is 1 second to 1 week (604800 seconds)"
  default     = "86400"
}

variable "stick_enabled" {
  description = "Boolen to enable / disable stickiness"
  default     = "false"
}
