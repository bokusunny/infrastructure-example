variable "aws_access_key" {
  type = string
  validation {
    condition     = length(var.aws_access_key) > 0
    error_message = "You have to set your aws access key to terrafom.tfvars."
  }
}

variable "aws_secret_key" {
  type = string
  validation {
    condition     = length(var.aws_secret_key) > 0
    error_message = "You have to set your aws secret key to terrafom.tfvars."
  }
}

variable "default_availability_zone" {
  type    = string
  default = "ap-northeast-1"
}

variable "default_availability_zone_names" {
  type    = list(string)
  default = ["ap-northeast-1"]
}
