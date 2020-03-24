targets = fantasy-file/gallery.md

all: $(targets)

clean:
	rm -f $(targets)

%/gallery.md:
	./gallery.py \
	  --checklist-path $*/checklist.csv \
	  > $@
