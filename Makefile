early_dirs = adnd-adventure-game-book advanced-fighting-fantasy adventure-hero-books call-of-cthulhu comp-rpg comptiq crystania dengeki-adventures dnd-media-works dnd-shinwa dragon-fujimi dragon-shinwa el-genesis enterprise fantasy-file fighting-fantasy game-graphix gamers-field gear-antique gurps hayakawa horai-school james-bond-007 logout magius mechwarrior metalhead new-goddess-reincarnation official-dnd-magazine oka-shujin operation phantasm-adventure record-of-lodoss-war roads-to-lord rpg-dragon rpg-fantasy-encyclopedia rpg-magazine runequest seven-fortress shakaishisosha-original-gamebook star-quest super-adventure-game sword-world tactics tokyo-nova traveller tunnels-trolls tunnels-trolls-kadokawa warlock wares-blade warhammer warps wizardry ys
early_targets = $(patsubst %,%/gallery.md,$(early_dirs))

early_checklists = $(patsubst %,%/checklist.csv,$(early_dirs))

all: $(early_targets) early_checklist.csv

clean:
	rm -f $(targets) checklist.csv

%/gallery.md:
	./gallery.py \
	  --subdir $* \
	  > $@

early_checklist.csv: $(early_checklists)
	./checklist.py $^ \
	  > $@

stats.category:
	@echo "CATEGORY:"
	@csv-to-tab early_checklist.csv | awk 'BEGIN{FS="\t"} NR > 1 {print $$1}' \
	  | sort | uniq -c | sort -nr

stats.product_type:
	@echo "PRODUCT TYPE:"
	@csv-to-tab early_checklist.csv | awk 'BEGIN{FS="\t"} NR > 1 {print $$2}' \
	  | sort | uniq -c | sort -nr

stats.publisher:
	@echo "PUBLISHER:"
	@csv-to-tab early_checklist.csv | awk 'BEGIN{FS="\t"} NR > 1 {print $$5}' \
	  | sort | uniq -c | sort -nr

stats.year:
	@echo "YEAR:"
	@csv-to-tab early_checklist.csv | awk 'BEGIN{FS="\t"} NR > 1 {print $$6}' \
	  | sort | uniq -c | sort -k2,2 -n

stats: stats.category stats.product_type stats.publisher stats.year
