early_dirs = adnd-adventure-game-book adnd-shinwa advanced-fighting-fantasy adventure-hero-books after-school-mystery arabesque-fortuna-ventus asura beast-warrior-luna-valger belfahrs-magic-school blade-and-word blood-sword blue-forest-story call-of-cthulhu comp-rpg comptiq creguian crystania cyberpunk daikatugeki dark-conspiracy dengeki-adventures dinosaur-squadron-juuranger dnd-media-works dnd-shinwa double-moon-legend dragon-fujimi dragon-half dragon-ring dragon-shinwa el-genesis enterprise fantasy-file fighting-fantasy foreigner fortune-quest game-graphix gamers-field gary-gygax gear-antique gundam-dainihonkaiga gurps hayakawa high-school-paradise horai-school itha-wen-ua james-bond-007 kaiser-legion legends-of-skyfall logout maelstrom magical-land magius mechwarrior merp metalhead monster-maker nightmare-hunter official-dnd-magazine oka-shujin operation pearl-seed phantasm-adventure power-play primary-guild record-of-lodoss-war remurica roads-to-lord rpg-dragon rolemaster monster-horror-show multiverse ringverse rpg-fantasy-encyclopedia rpg-fortune-bag rpg-magazine runequest sengoku-reiden seven-fortress shadowrun shakaishisosha-original-gamebook shin-megami-tensei small-still-voice space-opera-heroes star-quest stormbringer super-adventure-game sword-world tactics the-fantasy-trip tokyo-nova torg traveller tunnels-trolls tunnels-trolls-kadokawa warlock wares-blade wares-1092 warhammer warps witch-quest wizardry yozakura-ninpo-jo ys
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

stats.total:
	@echo "TOTAL:"
	@tail +2 early_checklist.csv | wc -l

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

stats: stats.total stats.category stats.product_type stats.publisher stats.year
