dirs = adnd-adventure-game-book advanced-fighting-fantasy adventure-hero-books call-of-cthulhu comp-rpg comptiq crystania dragon-fujimi dragon-shinwa fantasy-file fighting-fantasy gurps hayakawa horai-school logout magius mechwarrior metalhead oka-shujin operation record-of-lodoss-war roads-to-lord rpg-magazine runequest shakaishisosha-original-gamebook super-adventure-game sword-world tactics tokyo-nova traveller tunnels-trolls tunnels-trolls-kadokawa warlock wares-blade warhammer warps wizardry
targets = $(patsubst %,%/gallery.md,$(dirs))

all: $(targets)

clean:
	rm -f $(targets)

%/gallery.md:
	./gallery.py \
	  --subdir $* \
	  > $@
