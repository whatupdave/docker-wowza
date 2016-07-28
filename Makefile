all: build

build:
	@docker build --tag=whatupdave/wowza .
