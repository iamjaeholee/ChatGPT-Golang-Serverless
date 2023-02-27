module "api-gateway" {
  source = "./api-gateway"

  providers = {
    aws = aws
  }

  service_name    = local.service_name
  aws_common_tags = local.aws_common_tags
}
