data "archive_file" "textcompletion" {
  type        = "zip"
  source_file = "${path.module}/../../go/post/textcompletion/build/bin/app"
  output_path = "${path.module}/../../go/post/textcompletion/build/bin/textcompletion.zip"
}

resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.textcompletion.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.api.execution_arn}/*/*"

  depends_on = [
    aws_lambda_function.textcompletion
  ]
}

resource "aws_lambda_function" "textcompletion" {
  function_name    = "textcompletion"
  filename         = data.archive_file.textcompletion.output_path
  source_code_hash = filebase64sha256(data.archive_file.textcompletion.output_path)

  handler = "app"
  runtime = "go1.x"
  timeout = 10

  role = aws_iam_role.lambda_role.arn

  tags = var.aws_common_tags

  environment {
    variables = {
      GPT_TOKEN = jsondecode(aws_secretsmanager_secret_version.chat_secret.secret_string)["GPT_TOKEN"]
    }
  }
}

resource "aws_cloudwatch_log_group" "textcompletion" {
  name              = "/aws/lambda/textcompletion"
  retention_in_days = 7

  tags = var.aws_common_tags
}
