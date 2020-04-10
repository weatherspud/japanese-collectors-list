dirs = adventure-hero-books comp-rpg comptiq fantasy-file fighting-fantasy gurps magius oka-shujin operation roads-to-lord sword-world tactics tokyo-nova traveller tunnels-trolls tunnels-trolls-kadokawa warlock warps
targets = $(patsubst %,%/gallery.md,$(dirs))

all: $(targets)

clean:
	rm -f $(targets)

%/gallery.md:
	./gallery.py \
	  --subdir $* \
	  > $@
