import std/sets

#[
  GraphNode
]#
type GraphNode[T] = ref object of RootObj
  ## A GraphNode. Node IDs are integers
  id: int
  ## Integer id of node
  data: T
  ## Data stored at the node

#[
  UndirectedGraphNode
]#
type UndirectedGraphNode[T] = ref object of GraphNode
  ## UndirectedGraphNode
  targets: HashSet[UndirectedGraphNode[T]]
  ## Nodes that are connected to this Node
#[
  DirectedGraphNode
]#
type DirectedGraphNode[T] = ref object of GraphNode
  ## DirectedGraphNode
  incoming: HashSet[DirectedGraphNode[T]]
  ## Nodes that point to this node
  outgoing: HashSet[DirectedGraphNode[T]]
  ## Nodes that this node point to

#[
  Graph
]#
type Graph[T] = ref object of RootObj
  ## A Graph with nodes
  nodes: HashSet[GraphNode[T]]

#[
  UndirectedGraph
]#
type UndirectedGraph[T] = ref object of Graph

proc addEdgeUndirectedGraph*[T](self: Graph[T], nodeIDSource: int, nodeIDDest: int): bool =
  ## TODO:
  ## Adds an edge between two nodes
  ## 
  ## Parameters
  ##  * nodeIDSource: int
  ##  * nodeIDDest: int
  ## 
  ## Returns
  ##  * true: If successful
  ##  * false: Otherwise
  return false

proc addEdgeDirectedGraph*[T](self: Graph[T], nodeIDSource: int, nodeIDDest: int): bool =
  ## TODO:
  ## Adds an edge between two nodes
  ## 
  ## Parameters
  ##  * nodeIDSource: int
  ##  * nodeIDDest: int
  ## 
  ## Returns
  ##  * true: If successful
  ##  * false: Otherwise

proc addEdge*[T](self: Graph[T], nodeIDSource: int, nodeIDDest: int): bool =
  ## Adds an edge between two nodes
  ## 
  ## Parameters
  ##  * nodeIDSource: int
  ##  * nodeIDDest: int
  ## 
  ## Returns
  ##  * true: If successful
  ##  * false: Otherwise
  if self.nodes.len == 0:
    return false

  for n in self.nodes.items:
    if n of UndirectedGraphNode:
      return self.addEdgeUndirectedGraph(nodeIDSource, nodeIDDest)
    elif n of DirectedGraphNode:
      return self.addEdgeDirectedGraph(nodeIDSource, nodeIDDest)
  
  return false

proc deleteEdgeUndirectedGraph*[T](nodeIDSource: int, nodeIDDest: int): bool =
  ## TODO:
  ## Deletes an edge between two nodes
  ## 
  ## Parameters
  ##  * nodeIDSource: int
  ##  * nodeIDDest: int
  ## 
  ## Returns
  ##  * true: If successful
  ##  * false: Otherwise
  return false

proc deleteEdgeDirectedGraph*[T](self: Graph[T], nodeIDSource: int, nodeIDDest: int): bool =
  ## TODO:
  ## Deletes an edge between two nodes
  ##
  ## Parameters
  ##  * nodeIDSource: int
  ##  * nodeIDDest: int
  ## 
  ## Returns
  ##  * true: If successful
  ##  * false: Otherwise
  return false

proc deleteEdge*[T](self: Graph[T], nodeIDSource: int, nodeIDDest: int): bool =
  ## Deletes an edge between two nodes
  ## 
  ## Parameters
  ##  * nodeIDSource: int
  ##  * nodeIDDest: int
  ## 
  ## Returns
  ##  * true: If successful
  ##  * false: Otherwise
  if self.nodes.len == 0:
    return false
  
  for n in self.nodes.items:
    if n of UndirectedGraphNode:
      return self.deleteEdgeUndirectedGraph(nodeIDSource, nodeIDDest)
    elif n of DirectedGraphNode:
      return self.deleteEdgeDirectedGraph(nodeIDSource, nodeIDDest)
  
  return false

proc insertNode*[T](self: Graph[T], nodeID: int, data: T): bool = 
  ## TODO:
  ## Inserts a node into the graph
  ## 
  ## Parameters
  ##  * nodeID: int: Node to add
  ## 
  ## Returns
  ##  * true: If successful
  ##  * false: Otherwise
  return false

proc deleteNodeUndirectedGraph*[T](self: Graph[T], nodeID: int): bool =
  ## TODO:
  ## Deletes a node from the graph
  ## 
  ## Parameters
  ##  * nodeID: int: Node to delete
  ## 
  ## Returns
  ##  * true: If successful
  ##  * false: Otherwise
  return false

proc deleteNodeDirectedGraph*[T](self: Graph[T], nodeID: int): bool =
  ## TODO:
  ## Deletes a node from the graph
  ## 
  ## Parameters
  ##  * nodeID: int: Node to delete
  ## 
  ## Returns
  ##  * true: If successful
  ##  * false: Otherwise
  return false

proc deleteNode*[T](self: Graph[T], nodeID: int): bool =
  ## TODO:
  ## Deletes a node from the graph
  ## 
  ## Parameters
  ##  * nodeID: int: Node to delete
  ## 
  ## Returns
  ##  * true: If successful
  ##  * false: Otherwise
  if self.nodes.len == 0:
   return false

  for n in self.nodes.items:
    if n of UndirectedGraphNode:
      return self.deleteNodeUndirectedGraph(nodeID)
    elif n of DirectedGraphNode:
      return self.deleteNodeDirectedGraph(nodeID)
  return false

proc bfsSearchUndirected[T](self: Graph[T], source: UndirectedGraphNode[T], target: UndirectedGraphNode[T]): seq[UndirectedGraphNode[T]] =
  ## TODO:
  ## BFS search for shortest path in an undirected garph
  ## 
  ## Parameters
  ##  * source: UndirectedGraphNode[T]: Start node
  ##  * target: UndirectedGraphNode[T]: End node
  ## 
  ## Returns
  ##  * nil: If no path is found
  ##  * seq[UndirectedGraphNode[T]: If a path is found
  return nil

proc bfsSearch*[T](self: Graph[T], source: GraphNode[T], target: GraphNode[T]): seq[GraphNode[T]] =
  ## Searchs for a path from source to target in the graph
  ## 
  ## Parameters
  ##  * source: GraphNode[T]
  ##  * target: GraphNode[T]
  ## 
  ## Returns
  ##  * nil: If no path exists
  ##  * seq[GraphNode[T]]: Path
  if source of UndirectedGraph[T] and target of UndirectedGraphNode[T]:
    return self.bfsSearchUndirected(source, target)
  elif source of DirectedGraphNode[T] and target of DirectedGraphNode[T]:
    return nil
  else:
    echo "[bfsSearch]: Unknown node type!"
    assert false