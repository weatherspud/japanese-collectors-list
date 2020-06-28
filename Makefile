dirs = adnd-adventure-game-book advanced-fighting-fantasy adventure-hero-books call-of-cthulhu comp-rpg comptiq crystania dengeki-adventures dnd-media-works dragon-fujimi dragon-shinwa el-genesis fantasy-file fighting-fantasy gamers-field gear-antique gurps hayakawa horai-school logout magius mechwarrior metalhead new-goddess-reincarnation official-dnd-magazine oka-shujin operation phantasm-adventure record-of-lodoss-war roads-to-lord rpg-magazine runequest seven-fortress shakaishisosha-original-gamebook super-adventure-game sword-world tactics tokyo-nova traveller tunnels-trolls tunnels-trolls-kadokawa warlock wares-blade warhammer warps wizardry ys
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

stats.category:
	@echo "CATEGORY:"
	@csv-to-tab checklist.csv | awk 'BEGIN{FS="\t"} NR > 1 {print $$1}' \
	  | sort | uniq -c | sort -nr

stats.product_type:
	@echo "PRODUCT TYPE:"
	@csv-to-tab checklist.csv | awk 'BEGIN{FS="\t"} NR > 1 {print $$2}' \
	  | sort | uniq -c | sort -nr

stats.publisher:
	@echo "PUBLISHER:"
	@csv-to-tab checklist.csv | awk 'BEGIN{FS="\t"} NR > 1 {print $$5}' \
	  | sort | uniq -c | sort -nr

stats.year:
	@echo "YEAR:"
	@csv-to-tab checklist.csv | awk 'BEGIN{FS="\t"} NR > 1 {print $$6}' \
	  | sort | uniq -c | sort -nr

stats: stats.category stats.product_type stats.publisher stats.year
