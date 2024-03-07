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

proc test3() =
  ## Add edges beteen non-existing nodes
  echo "Running test3..."
  let udg: Graph[int] = newGraph[int](false)
  let dg: Graph[int] = newGraph[int](true)

  assert udg.insertNode(0, 1) == true
  assert dg.insertNode(0, 1) == true

  assert udg.addEdge(0, 2) == false
  assert udg.addEdge(2, 2) == false
  assert dg.addEdge(0, 2) == false
  assert dg.addEdge(2, 2) == false

when isMainModule:
  test1()
  test2()
  test3()