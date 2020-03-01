variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "default_availability_zone" {
  default = "ap-northeast-1"
}

variable "default_availability_zone_names" {
  type    = list(string)
  default = ["ap-northeast-1"]
}
