.PHONY: build start_dev start clean

build:
	elm-app build
	touch $@

start_dev: src/Main.elm
	elm-live $<

start: build/.build
	elm-app start

clean:
	rm -rf build
	rm -rf public
