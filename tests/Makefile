OBJS=test_trees test_csv

all: $(OBJS)

test_trees: test_trees.nim
	nim --out=../bin/test_trees c --verbosity:1 test_trees.nim
test_csv: test_csv.nim
	nim --out=../bin/test_csv c --verbosity:1 test_csv.nim

clean:
	rm ../bin/$(OBJS)