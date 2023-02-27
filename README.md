# ChatGPT AWS Golang Serverless Implementation

## Prerequisuites

### AWS credentials

First of all need AWS credentials in ~/.aws/credentials specified as `dev` profile.

### Terraform

Install terraform `brew install terraform`

### Golang

Install Golang

## ChatGPT Token

### generate ChatGPT Token

go get some ChatGPT Token

### update environment variables

change `terraform/api-gateway/lambda.tf` `aws_lambda_function.textcompletion ` environment variables **GPT_TOKEN** or you can add kind of secret manager resource for managing the token.

## Build

build golang source code.

```
make build PATH=post/textcompletion
```

## Test

test golang package using `vscode debug mode`

## Apply

```
terraform init
terraform apply
```

good luck
