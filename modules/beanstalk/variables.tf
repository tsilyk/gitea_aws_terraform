variable "elasticapp" {
}

variable "beanstalkappenv" {
}

variable "solution_stack_name" {
  default = "64bit Amazon Linux 2 v3.6.4 running Go 1"
}

variable "tier" {
  default = "WebServer"
}

variable "vpc_id" {
}

variable "public_subnets" {
}

variable "keypair" {
  default = "MainFrankfurt"
}

variable "instance" {
}

variable "autoscaling_min" {
}

variable "autoscaling_max" {
}
