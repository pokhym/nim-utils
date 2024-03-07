import std/sets
import std/hashes

#[
  GraphNode
]#
type GraphNode[T] = ref object of RootObj
  ## A GraphNode. Node IDs are integers
  nodeID: int
  ## Integer id of node
  data: T
  ## Data stored at the node

proc hash*[T](self: GraphNode[T]): Hash {.noSideEffect.} =
  ## hash: Required for HashSet to work
  result = hash(self.nodeID)

proc `==`*[T](a, b: GraphNode[T]): bool =
  ## `==`: Required for HashSet to work
  return a == b

#[
  UndirectedGraphNode
]#
type UndirectedGraphNode[T] = ref object of GraphNode[T]
  ## UndirectedGraphNode
  targets: HashSet[UndirectedGraphNode[T]]
  ## Nodes that are connected to this Node

proc `$`*[T](self: UndirectedGraphNode[T]): string =
  ## Print UndirectedGraphNode
  result = "FROM:" & self.id & "-TO->"
  for i in self.targets:
    result &= i.id &","
  result &= "\n\t" & $self.data & "\n"
  
#[
  DirectedGraphNode
]#
type DirectedGraphNode[T] = ref object of GraphNode[T]
  ## DirectedGraphNode
  incoming: HashSet[DirectedGraphNode[T]]
  ## Nodes that point to this node
  outgoing: HashSet[DirectedGraphNode[T]]
  ## Nodes that this node point to

proc `$`*[T](self: DirectedGraphNode[T]): string =
  ## Print DirectedGraphNode
  result = "FROM:"
  for i in self.incoming:
    result &= i.id & ","
  result &= "-TO->" & self.id
  result &= "FROM:" & self.id & "-TO->"
  for i in self.outgoing:
    result &= i.id &","
  result &= "\n"
  result &= "\n\t" & $self.data & "\n"

#[
  Graph
]#
type Graph*[T] = ref object of RootObj
  ## A Graph with nodes
  nodes: HashSet[GraphNode[T]]
  ## Nodes
  directed: bool
  ## True if directed false otherwise

proc `$`*[T](self: Graph[T]): string =
  ## Print Graph
  result = ""
  if self.directed:
    result &= "DIRECTED\n"
  else:
    result &= "UNDIRECTED\n"
  for n in self.nodes.items:
    echo n[]

#[
  UndirectedGraph
]#
type UndirectedGraph[T] = ref object of Graph

proc newGraph*[T](directed: bool): Graph[T] =
  ## Creates a new Graph
  return Graph[T](directed: directed)

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

  if not self.directed:
    return self.addEdgeUndirectedGraph(nodeIDSource, nodeIDDest)
  else:
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
  
  if not self.directed:
    return self.deleteEdgeUndirectedGraph(nodeIDSource, nodeIDDest)
  else:
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
  if self.directed:
    var n = new(DirectedGraphNode[T])
    n.nodeID = nodeID
    n.data = data
    self.nodes.incl(n)
    return true
  else:
    var n = new(UndirectedGraphNode[T])
    n.nodeID = nodeID
    n.data = data
    self.nodes.incl(n)
    return true
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

  if not self.directed:
    return self.deleteNodeUndirectedGraph(nodeID)
  else:
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