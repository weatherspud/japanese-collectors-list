dirs = adventure-hero-books comptiq fantasy-file fighting-fantasy magius operation roads-to-lord sword-world traveller tunnels-trolls tunnels-trolls-kadokawa warlock
targets = $(patsubst %,%/gallery.md,$(dirs))

all: $(targets)

clean:
	rm -f $(targets)

%/gallery.md:
	./gallery.py \
	  --subdir $* \
	  > $@
