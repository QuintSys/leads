.PHONY: build
build:	
	docker build --tag leads .

.PHONY: to_heroku
to_heroku: heroku_push heroku_release

.PHONY: heroku_push
heroku_push:
	heroku container:push web

.PHONY: heroku_release
heroku_release:
	heroku container:release web
