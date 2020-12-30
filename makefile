.PHONY: build

public/index.html: src/Main.elm
	elm-app make $< --output $@ --optimize

build/.build: public/index.html
	elm-app build
	touch $@

start_dev: src/Main.elm
	elm-live $< --open

start: build/.build
	elm-app start

clean:
	rm -rf build
	rm -rf public
