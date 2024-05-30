OBJS=test_trees test_csv test_graph test_x11

all: $(OBJS)

test_trees: test_trees.nim
	nim --out=../bin/test_trees c --verbosity:1 test_trees.nim
test_csv: test_csv.nim
	nim --out=../bin/test_csv c --verbosity:1 test_csv.nim
test_graph: test_graph.nim
	nim --out=../bin/test_graph c --verbosity:1 --debugger:native test_graph.nim
test_x11: test_x11.nim
	nim --out=../bin/test_x11 c --passL:"-lX11" --verbosity:1 --debugger:native test_x11.nim

clean:
	rm ../bin/$(OBJS)