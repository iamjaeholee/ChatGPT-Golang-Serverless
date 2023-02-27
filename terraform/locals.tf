locals {
  service_name = "chatGPT_serverless"
  developer    = "leejaeho"

  # AWS Common tags to be assigned to all resources
  aws_common_tags = {
    Service   = local.service_name
    Developer = local.developer
    Terraform = true
  }
}
