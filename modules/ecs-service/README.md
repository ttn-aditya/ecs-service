##ECS SERVICE
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

## Outputs

| Name | Description |
|------|-------------|
| target\_group | The target group name created by this module |
| target\_group\_arn\_suffix | The target group suffix to use as input on alarms |
| task\_role | The task role name used by the task definition |
| task\_role\_arn | The task role arn used by the task definition |
