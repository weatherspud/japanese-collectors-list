dirs = comptiq fantasy-file fighting-fantasy magius operation roads-to-lord traveller warlock
targets = $(patsubst %,%/gallery.md,$(dirs))

all: $(targets)

clean:
	rm -f $(targets)

%/gallery.md:
	./gallery.py \
	  --subdir $* \
	  > $@
