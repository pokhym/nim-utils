OBJS=test_trees test_csv

all: $(OBJS)

test_trees: test_trees.nim
	nim c --verbosity:1 test_trees.nim
test_csv: test_csv.nim
	nim c --verbosity:1 test_csv.nim

clean:
	rm $(OBJS)