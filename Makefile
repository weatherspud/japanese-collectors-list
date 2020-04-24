dirs = adnd-adventure-game-book adventure-hero-books call-of-cthulhu comp-rpg comptiq dragon-fujimi fantasy-file fighting-fantasy gurps horai-school logout magius oka-shujin operation roads-to-lord rpg-magazine runequest shakaishisosha-original-gamebook super-adventure-game sword-world tactics tokyo-nova traveller tunnels-trolls tunnels-trolls-kadokawa warlock wares-blade warps wizardry
targets = $(patsubst %,%/gallery.md,$(dirs))

all: $(targets)

clean:
	rm -f $(targets)

%/gallery.md:
	./gallery.py \
	  --subdir $* \
	  > $@
