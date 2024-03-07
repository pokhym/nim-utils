import ../data-structures/graphs

proc test1() =
  ## Create Graph and return it
  echo "Running test1..."
  let udg: Graph[int] = newGraph[int](false)
  let dg: Graph[int] = newGraph[int](true)

proc test2() =
  ## Add a graph node
  echo "Running test2..."
  let udg: Graph[int] = newGraph[int](false)
  let dg: Graph[int] = newGraph[int](true)

  assert udg.insertNode(0, 1) == true
  assert dg.insertNode(0, 1) == true

  echo "Printing udg..."
  echo $udg
  echo "Printing dg..."
  echo $dg

when isMainModule:
  test1()
  test2()