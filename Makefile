dirs = adnd-adventure-game-book advanced-fighting-fantasy adventure-hero-books call-of-cthulhu comp-rpg comptiq crystania dengeki-adventures dnd-media-works dragon-fujimi dragon-shinwa fantasy-file fighting-fantasy gurps hayakawa horai-school logout magius mechwarrior metalhead official-dnd-magazine oka-shujin operation phantasm-adventure record-of-lodoss-war roads-to-lord rpg-magazine runequest shakaishisosha-original-gamebook super-adventure-game sword-world tactics tokyo-nova traveller tunnels-trolls tunnels-trolls-kadokawa warlock wares-blade warhammer warps wizardry
targets = $(patsubst %,%/gallery.md,$(dirs))

checklists = $(patsubst %,%/checklist.csv,$(dirs))

all: $(targets) checklist.csv

clean:
	rm -f $(targets) checklist.csv

%/gallery.md:
	./gallery.py \
	  --subdir $* \
	  > $@

checklist.csv: $(checklists)
	./checklist.py $^ \
	  > $@
