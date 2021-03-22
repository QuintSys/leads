.PHONY: build
build:	
	docker build \
		--tag leads \
		--file ./docker/Dockerfile \
		./web
