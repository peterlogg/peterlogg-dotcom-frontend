include .env
export $(shell sed 's/=.*//' .env)

.PHONY: build start_dev start clean

build:
	elm-app build
	touch $@

start_dev: src/Main.elm
	elm-live $<

start:
	elm-app start

image:
	docker build -t peterlogg-dotcom-frontend --build-arg ELM_APP_BACKEND_URL=${ELM_APP_BACKEND_URL} .

clean:
	rm -rf build
	rm -rf public
