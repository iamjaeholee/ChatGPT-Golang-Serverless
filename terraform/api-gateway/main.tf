resource "aws_api_gateway_rest_api" "api" {
  name        = "${var.service_name}_api"
  description = "api gateway"

  tags = var.aws_common_tags
}

# root methods
resource "aws_api_gateway_method" "proxy_root" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_rest_api.api.root_resource_id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_root" {

  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_method.proxy_root.resource_id
  http_method = aws_api_gateway_method.proxy_root.http_method

  connection_type = "INTERNET"
  type            = "MOCK"
}

# textcompletion resourcd and methods
resource "aws_api_gateway_resource" "textcompletion" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "textcompletion"
}

resource "aws_api_gateway_method" "textcompletion" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.textcompletion.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "textcompletion" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_method.textcompletion.resource_id
  http_method = aws_api_gateway_method.textcompletion.http_method

  connection_type         = "INTERNET"
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.textcompletion.invoke_arn

  depends_on = [
    aws_lambda_function.textcompletion
  ]
}

resource "aws_api_gateway_method_response" "response_200" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.textcompletion.id
  http_method = aws_api_gateway_method.textcompletion.http_method
  status_code = "200"
}


resource "aws_api_gateway_deployment" "deployment" {
  depends_on = [
    aws_api_gateway_integration.textcompletion,
    aws_api_gateway_integration.lambda_root,
  ]

  rest_api_id = aws_api_gateway_rest_api.api.id
  stage_name  = "dev1"
}
