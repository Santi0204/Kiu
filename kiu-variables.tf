variable "aws_region" {
  default = "us-east-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "subnet_cidrs" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "eks_cluster_name" {
  default = "Kiu"
}

variable "db_instance_class" {
  default = "db.t3.medium"
}

variable "db_name" {
  default = "db-kiu"
}

variable "db_username" {
  default = "kiu_admin"
}

variable "db_password" {
  default = "g8Yfvu2fKcxXqKObpJZxj29S"
}