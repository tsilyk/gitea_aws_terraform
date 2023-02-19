variable "elasticapp" {
  default = "gitea-app"
}
variable "beanstalkappenv" {
  default = "gitea-env"
}
variable "solution_stack_name" {
  default = "64bit Amazon Linux 2 v3.6.4 running Go 1"
}
variable "tier" {
  default = "WebServer"
}

variable "vpc_id" {
  default = "vpc-0fe836a90fa0a7a24"
}
variable "public_subnets" {
  default = ["subnet-0778284862fbb3cb6", "subnet-0a04e797e28e9449c", "subnet-05f8be8c7a226b883"]
}
variable "keypair" {
  default = "MainFrankfurt"
}
