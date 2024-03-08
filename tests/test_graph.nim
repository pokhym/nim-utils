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

proc test4() =
  ## Add edges between existing nodes
  echo "Running test4..."
  let udg: Graph[int] = newGraph[int](false)
  let dg: Graph[int] = newGraph[int](true)

  assert udg.insertNode(0, 1) == true
  assert udg.insertNode(1, 2) == true
  assert dg.insertNode(0, 1) == true
  assert dg.insertNode(1, 2) == true

  assert udg.addEdge(0, 1) == true
  assert udg.addEdge(0, 1) == true
  assert udg.addEdge(0, 0) == true
  assert udg.addEdge(0, 0) == true
  assert dg.addEdge(0, 1) == true
  assert dg.addEdge(1, 0) == true
  assert dg.addEdge(0, 0) == true
  assert dg.addEdge(0, 0) == true

  echo "Printing udg..."
  echo $udg
  echo "Printing dg..."
  echo $dg

proc test5() =
  ## Delete non-existing edges from non-existing nodes
  echo "Running test5..."
  let udg: Graph[int] = newGraph[int](false)
  let dg: Graph[int] = newGraph[int](true)

  assert udg.deleteEdge(0, 1) == false
  assert udg.deleteEdge(0, 0) == false
  assert dg.deleteEdge(0, 1) == false
  assert dg.deleteEdge(1, 0) == false
  assert dg.deleteEdge(0, 0) == false

proc test6() =
  ## Delete non-existing edges from existing nodes
  echo "Running test6..."
  let udg: Graph[int] = newGraph[int](false)
  let dg: Graph[int] = newGraph[int](true)

  assert udg.insertNode(0, 1) == true
  assert udg.insertNode(1, 2) == true
  assert dg.insertNode(0, 1) == true
  assert dg.insertNode(1, 2) == true

  assert udg.addEdge(0, 1) == true
  assert udg.addEdge(0, 1) == true
  assert udg.deleteEdge(0, 0) == false
  assert udg.deleteEdge(0, 0) == false
  assert dg.addEdge(0, 1) == true
  assert dg.addEdge(1, 0) == true
  assert dg.deleteEdge(0, 0) == false
  assert dg.deleteEdge(0, 0) == false

proc test7() =
  ## Delete existing edges from existing nodes
  echo "Running test7..."
  let udg: Graph[int] = newGraph[int](false)
  let dg: Graph[int] = newGraph[int](true)

  assert udg.insertNode(0, 1) == true
  assert udg.insertNode(1, 2) == true
  assert dg.insertNode(0, 1) == true
  assert dg.insertNode(1, 2) == true

  assert udg.addEdge(0, 1) == true
  assert udg.addEdge(0, 1) == true
  assert udg.deleteEdge(0, 1) == true
  assert udg.deleteEdge(0, 1) == false
  assert dg.addEdge(0, 1) == true
  assert dg.addEdge(1, 0) == true
  assert dg.deleteEdge(0, 1) == true
  assert dg.deleteEdge(0, 1) == false
  assert dg.deleteEdge(1, 0) == true
  assert dg.deleteEdge(1, 0) == false

  echo "Printing udg..."
  echo $udg
  echo "Printing dg..."
  echo $dg

when isMainModule:
  test1()
  test2()
  test3()
  test4()
  test5()
  test6()
  test7()