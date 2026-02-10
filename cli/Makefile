.PHONY: build run clean test

build:
	go build -o dotfiles .

run: build
	./dotfiles

clean:
	rm -f dotfiles

test:
	go test ./...
