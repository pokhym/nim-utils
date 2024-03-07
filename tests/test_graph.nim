import ../data-structures/graphs

proc test1() =
  ## Create Graph and return it
  echo "Running test1..."
  let g: Graph[int] = newGraph[int]()

proc test2() =
  ## Add a graph node
  echo "Running test2..."
  return

when isMainModule:
  test1()
  test2()