
/* * Resources.
 */

// Task Role could be useful to grant special permissions 
// conveniently to the containers running into
resource "aws_iam_role" "main" {
  name = "${var.name}-${var.environment}"

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

resource "aws_iam_role_policy" "main" {
  count = "${var.policy == "" ? 0 : 1}"

  name   = "${var.name}-${var.environment}"
  role   = "${aws_iam_role.main.id}"
  policy = "${var.policy}"
}

resource "aws_alb_target_group" "main" {
  name         = "${var.name}-${var.environment}"
  port         = "${var.container_port}"
  protocol     = "HTTP"
  vpc_id       = "${var.vpc_id}"
  health_check = ["${var.healthcheck}"]
  stickiness {
    type            = "lb_cookie"
    cookie_duration = "${var.cookie_duration}"
    enabled         = "${var.stick_enabled}"
  }
}

resource "aws_alb_listener_rule" "main" {
  listener_arn = "${var.alb_listener}"
  priority     = "${var.rule_priority}"

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.main.arn}"
  }

  condition {
    field  = "host-header"
    values = ["${var.name}.*"]
  }
}

resource "aws_ecs_service" "main" {
  name            = "${var.name}"
  cluster         = "${var.cluster}"
  task_definition = "${module.task.arn}"
  desired_count   = "${var.desired_count}"
  iam_role        = "${var.iam_role}"

  ordered_placement_strategy {
    type  = "spread"
    field = "attribute:ecs.availability-zone"
  }

  ordered_placement_strategy {
    type  = "binpack"
    field = "cpu"
  }

  ordered_placement_strategy {
    type  = "binpack"
    field = "memory"
  }

  load_balancer {
    target_group_arn = "${aws_alb_target_group.main.arn}"
    container_name   = "${var.name}_app"
    container_port   = "${var.container_port}"
  }
}

module "task" {
  source                = "egarbi/task-definition/aws"
  version               = "1.0.0"
  name                  = "${var.name}-${var.environment}"
  task_role             = "${aws_iam_role.main.arn}"
  container_definitions = "${var.container_definitions}"
}

// Add ALB record on DNS
resource "aws_route53_record" "main" {
  depends_on = ["aws_ecs_service.main"]

  zone_id = "${var.zone_id}"
  name    = "${var.name}"
  type    = "A"

  alias {
    name                   = "${var.alb_dns_name}"
    zone_id                = "${var.alb_zone_id}"
    evaluate_target_health = false
  }
}
