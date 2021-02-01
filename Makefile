game_checklists = $(shell find . -name checklist.csv -depth 2)

game_dirs = $(patsubst %/checklist.csv,%,$(game_checklists))

game_targets = $(patsubst %/checklist.csv,%/gallery.md,$(game_dirs))

all: $(game_targets) checklist.csv

clean:
	rm -f $(targets) checklist.csv

%/gallery.md:
	./gallery.py \
	  --subdir $* \
	  > $@

checklist.csv: $(game_checklists)
	./checklist.py $^ \
	  > $@

stats.total:
	@echo "TOTAL:"
	@tail +2 checklist.csv | wc -l

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
	  | sort | uniq -c | sort -k2,2 -n

stats: stats.total stats.category stats.product_type stats.publisher stats.year
