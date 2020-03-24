all: fantasy-file/gallery.html

%/gallery.html:
	./gallery.py \
	  --checklist-path $*/checklist.csv \
	  > $@
