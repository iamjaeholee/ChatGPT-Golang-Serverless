package service

import (
	"context"
	"os"

	gogpt "github.com/sashabaranov/go-gpt3"
)

func GptCompletionCaller(req gogpt.CompletionRequest) (r gogpt.CompletionResponse, e error) {
	token := os.Getenv("GPT_TOKEN")

	c := gogpt.NewClient(token)
	ctx := context.Background()

	resp, err := c.CreateCompletion(ctx, req)

	return resp, err
}
