# nim-utils

Stuff useful for Nim.
Mainly coding practice in Nim.

## Directories

* `data-structrues`: Various data structures coded in nim
  * `trees.nim`
    * `BinaryTree`: Balanced unsorted binary tree implementation
  * `graphs.nim`
    * `Graph`: Supports directed and undirected graphs
* `csv`: CSV Utilities
  * `csv.nim`: CSVHandler implementation for reading/modifying and saving CSVs.
* `tests`: Tests for the various utilities

## Data Structures

### Trees

#### BinaryTree

Balanced unsorted binary tree.

Supports

* Inserting nodes

TODO:

* Deleting nodes

### Graph

Supports directed and undirected graphs.

Supports

* Inserting nodes
* Deleting nodes
* Inserting edges
* Deleting edges

TODO:

* Dijkstra shortest path

## CSV

Supports parsing, modifying and saving CSVs

Supports

* Loading a CSV file
* Deleting rows
* Adding rows
* Saving result to a CSV file

TODO:

* Add columns

## x11

X11 wrappers for C equivalent C functions.
Automation of actions.

Requires
* `sudo apt-get install libx11-dev`

Compilation requires the flag `--passL:"-lX11"`