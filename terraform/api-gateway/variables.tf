variable "service_name" {
  type = string
}

variable "aws_common_tags" {
  type = map(any)

  default = {
    Terraform = true
    Developer = "tester"
    Service   = "test"
  }
}

variable "chat_secret" {
  type      = map(string)
  sensitive = true
}
