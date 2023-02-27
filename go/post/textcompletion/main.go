package main

import (
	"context"
	"fmt"
	"os"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
	gogpt "github.com/sashabaranov/go-gpt3"

	"textcompletion/pkg/service"

	log "github.com/sirupsen/logrus"
)

func main() {
	if os.Getenv("ENV") == "DEBUG" {
		log.SetLevel(log.DebugLevel)
		req := gogpt.CompletionRequest{
			Model:       gogpt.GPT3TextDavinci003,
			MaxTokens:   50,
			Temperature: 1,
			Prompt:      "what is the korean-war?",
		}

		resp, err := service.GptCompletionCaller(req)
		if err != nil {
			return
		}
		fmt.Println(resp.Choices[0].Text)
	} else {
		lambda.Start(handler)
	}
}

func handler(ctx context.Context, req events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {
	options := gogpt.CompletionRequest{
		Model:       gogpt.GPT3TextDavinci003,
		MaxTokens:   50,
		Temperature: 1,
		Prompt:      "what is the korean-war?",
	}

	resp, err := service.GptCompletionCaller(options)

	if err != nil {
		errorMessage := err.Error()
		log.Infoln(errorMessage)
		return events.APIGatewayProxyResponse{Body: errorMessage, StatusCode: 500}, nil
	}

	responseMessage := resp.Choices[0].Text
	log.Infoln(responseMessage)
	return events.APIGatewayProxyResponse{Body: responseMessage, StatusCode: 200}, nil
}
