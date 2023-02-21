variable "region" {
  default = "eu-central-1"
}

variable "app" {
  default = "gitea"
}

variable "env" {
  default = "dev"
}

variable "public_subnet_cidrs" {
  description = "Public Networks for each AZ"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_subnet_cidrs" {
  description = "Private Networks for each AZ"
  type        = list(string)
  default     = []
}

variable "isolated_subnet_cidrs" {
  description = "Isolated Networks for each AZ"
  type        = list(string)
  default     = ["10.0.21.0/24", "10.0.22.0/24", "10.0.23.0/24"]
}
