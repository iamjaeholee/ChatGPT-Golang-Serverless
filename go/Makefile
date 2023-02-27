build:
	GOOS=linux GOARCH=amd64 /usr/local/go/bin/go build -v -ldflags '-d -s -w' -a -tags netgo -installsuffix netgo -o ./${PATH}/build/bin/app ./${PATH}

run: build
