all: fantasy-file/gallery.md

%/gallery.md:
	./gallery.py \
	  --checklist-path $*/checklist.csv \
	  > $@
