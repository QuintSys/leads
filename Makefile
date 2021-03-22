.PHONY: build
build:	
	docker build -t leads -f ./docker/Dockerfile ./web
