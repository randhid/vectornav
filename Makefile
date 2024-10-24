
BIN_OUTPUT_PATH = bin
TOOL_BIN = bin/gotools/$(shell uname -s)-$(shell uname -m)
UNAME_S ?= $(shell uname -s)

build:
	rm -f $(BIN_OUTPUT_PATH)/vectornav
	go build -o $(BIN_OUTPUT_PATH)/vectornav main.go

module.tar.gz: build
	rm -f $(BIN_OUTPUT_PATH)/module.tar.gz
	tar czf module.tar.gz $(BIN_OUTPUT_PATH)/vectornav meta.json

vectornav: *.go 
	go build -o vectornav *.go

clean:
	rm -rf $(BIN_OUTPUT_PATH)/vectornav module.tar.gz vectornav

gofmt:
	gofmt -w -s .

lint: gofmt
	go mod tidy

update-rdk:
	go get go.viam.com/rdk@latest
	go mod tidy
