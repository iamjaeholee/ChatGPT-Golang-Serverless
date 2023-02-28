resource "aws_secretsmanager_secret" "chatgpt" {
  name = "chatgpt"
}

resource "aws_secretsmanager_secret_version" "chat_secret" {
  secret_id     = aws_secretsmanager_secret.chatgpt.id
  secret_string = jsonencode(var.chat_secret)
}
