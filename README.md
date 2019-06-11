AWS ECS Service Terraform module
========================

Terraform module which create an ECS service into an ECS cluster passed as an argument

Usage
-----
```
module "ecs-service" {
  source = "git::https://github.com/adi/terraform-aws-ecs-service"

  name                  = "example"
  environment           = "testing"
  desired_count         = "1"
  cluster               = "example-cluster"
  vpc_id                = "vpc-XXXXXXX"
  zone_id               = "Z4KAPRWWNC7JR"
  iam_role              = "arn:aws:iam::12345678910:role/ec2_role"
  rule_priority         = "10"
  alb_listener          = "arn:aws:elasticloadbalancing:eu-west-1:12345678910:listener/app/example/1e590za2072344a6nc01fh545fb2301d1"
  alb_zone_id           = "Z4KAPRXXXC7JR"
  alb_dns_name          = "example"
  container_definitions = "${file("container_definitions.json")}"
}
```

The referenced `container_definitions.json` file contains a valid JSON document, which is shown below, and its content is going to be passed directly into the container_definitions attribute as a string. Please note that this example contains only a small subset of the available parameters.
```
[
  {
    "name": "first",
    "image": "service-first",
    "cpu": 10,
    "memory": 512,
    "essential": true,
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 80
      }
    ]
  },
  {
    "name": "second",
    "image": "service-second",
    "cpu": 10,
    "memory": 256,
    "essential": true,
    "portMappings": [
      {
        "containerPort": 443,
        "hostPort": 443
      }
    ]
  }
]

```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| alb\_dns\_name | DNS name of the ALB where the rule will be added | string | n/a | yes |
| alb\_listener | Listener where the rule will be added | string | n/a | yes |
| alb\_zone\_id | Zone ID where the ALB is hosted | string | n/a | yes |
| cluster | The cluster name | string | n/a | yes |
| container\_definitions | here you should include the full container definitions | string | n/a | yes |
| container\_port | The container port | string | `"8080"` | no |
| cookie\_duration | The time period, in seconds, during which requests from a client should be routed to the same target.The range is 1 second to 1 week (604800 seconds) | string | `"86400"` | no |
| desired\_count | The desired count | string | `"1"` | no |
| environment | Environment tag, e.g prod | string | `"default"` | no |
| healthcheck |  | map | `<map>` | no |
| iam\_role | IAM Role ARN to use | string | n/a | yes |
| name | The service name | string | n/a | yes |
| policy | IAM custom policy to be attached to the task role | string | `""` | no |
| rule\_priority | This is the priority number of the listener's rule | string | n/a | yes |
| stick\_enabled | Boolen to enable / disable stickiness | string | `"false"` | no |
| vpc\_id | The VPC ID were the ECS is running | string | n/a | yes |
| zone\_id | Zone ID where the ECS service (record) will be added | string | n/a | yes |


