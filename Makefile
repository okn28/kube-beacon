SHELL := /bin/bash

GOCMD=go
GOMOD=$(GOCMD) mod
GOBUILD=$(GOCMD) build
GOLINT=${GOPATH}/bin/golangci-lint
GORELEASER=/usr/local/bin/goreleaser
GOIMPI=${GOPATH}/bin/impi
GOTEST=$(GOCMD) test
GOCOPY=cp beacon ~/vagrant_file/.

all:
	$(info  "completed running make file for beacon project")
fmt:
	@go fmt ./...
lint:
	./lint.sh
tidy:
	$(GOMOD) tidy -v
test:
	#@go get github.com/golang/mock/mockgen@latest
	#@go install -v github.com/golang/mock/mockgen && export PATH=$GOPATH/bin:$PATH;
	gopherbadger -md="README.md,coverage.md" -manualcov=65
	mv coverage_badge.png ./pkg/images/coverage_badge.png
	rm coverage.md
	@go generate ./...
	$(GOTEST) ./... -coverprofile coverage.md fmt
	go tool cover -html=fmtcoverage.html -o coverage.md
build:
	go get -u github.com/gobuffalo/packr/packr
	packr
	GOOS=linux GOARCH=amd64 go build -v cmd/beacon/beacon.go;
	mv beacon ~/vagrant_file/.
build_travis:
	go get -u github.com/gobuffalo/packr/packr
	packr
	GOOS=linux GOARCH=amd64 go build -v cmd/beacon/beacon.go;
build_remote:
	go get -u github.com/gobuffalo/packr/packr
	packr
	GOOS=linux GOARCH=amd64 go build -v -gcflags='-N -l' cmd/beacon/beacon.go
	mv beacon ~/vagrant_file/.

.PHONY: install-req fmt test lint build ci build-binaries tidy imports
