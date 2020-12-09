.PHONY: watch all html pdf

SRC:= $(wildcard *.rst)
OUT1:= $(SRC:%.rst=%.html)
OUT2:= $(SRC:%.rst=%.pdf)

watch:
	while true; do \
		inotifywait -qre close_write README.rst; \
		make html; \
	done

all: html pdf

html: $(OUT1)

pdf: $(OUT2)

%.html: %.rst
	rst2html5 --stylesheet=github-pandoc.css $< $@

%.pdf: %.rst
	rst2pdf $< $@
