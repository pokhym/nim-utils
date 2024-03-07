#[
  BinaryTreeNode
]#
type BinaryTreeNode*[T] = ref object
  ## Node of a BinaryTree
  parent*: BinaryTreeNode[T]
  ## Parent node, nil if non-existent
  level*: int
  ## Level in tree
  left*: BinaryTreeNode[T]
  ## Left child, nil if non-existent
  right*: BinaryTreeNode[T]
  ## Right child, nil if non-existent
  value*: T
  ## Value stored at this node

proc `$`*[T](self: BinaryTreeNode[T]): string =
  ## Pretty print BinaryTreeNode
  result = ""
  if self.parent != nil:
    result &= "p:" & $self.parent.value
  else:
    result &= "p:nil"
  if self.left != nil:
    result &= ",l:" & $self.left.value
  else:
    result &= ",l:nil"
  if self.right != nil:
    result &= ",r:" & $self.right.value
  else:
    result &= ",r:nil"
  result &= ",v:" & $self.value
  result &= ",lv:" & $self.level

#[
  Binary Trees
]#
type BinaryTree*[T] = ref object of RootObj
  ## BinaryTree Implementation
  ## The basic BinaryTree does not care for sorting keys
  ## or anything and simply fills out the tree in a
  ## balanced way

  root*: BinaryTreeNode[T]
  ## Root node of the tree

proc newBinaryTree*[T](value: T): BinaryTree[T] =
  ## Creates a new BinaryTree with a root node
  ## containing value, value : T
  ## 
  ## Parameters
  ## * value: T: Value for the root node
  ## 
  ## Returns
  ## * new BinaryTree[T]
  var node = new(BinaryTreeNode[T])
  node.parent = nil
  node.left = nil
  node.right = nil
  node.value = value
  node.level = 1
  return BinaryTree[T](root: node)

proc findNodeBinaryTreeHelper[T](self: BinaryTree[T], currNode: BinaryTreeNode[T], value: T): BinaryTreeNode[T] =
  var res : BinaryTreeNode[T] = nil
  # echo $currNode, ",find:", $value
  if currNode.value == value:
    return currNode
  if currNode.left != nil:
    res = self.findNodeBinaryTreeHelper(currNode.left, value)
  if currNode.right != nil and res == nil:
    res = self.findNodeBinaryTreeHelper(currNode.right, value)
  return res

proc findNodeBinaryTree*[T](self: BinaryTree[T], value: T): BinaryTreeNode[T] =
  ## Finds a node in a given BinaryTree
  ## 
  ## Parameters
  ## * self: BinaryTree[T]
  ## * value: T: The key to search for
  ## 
  ## Returns
  ## * BinaryTreeNode[T]: The found node if it exists
  ## * nil: If the node does not exist
  return self.findNodeBinaryTreeHelper(self.root, value)

proc binaryTreeHeight[T](self: BinaryTree[T], currNode: BinaryTreeNode[T]): int =
  ## Returns the height of the BinaryTree
  ## 
  ## Parameters
  ## * self: BinaryTree[T]
  ## * currNode: BinaryTreeNode[T]
  ## 
  ## Returns
  ## int: Height of BinaryTree[T]
  if currNode == nil:
    return 0
  var lheight: int = self.binaryTreeHeight(currNode.left)
  var rheight: int = self.binaryTreeHeight(currNode.right)
  if lheight > rheight:
    return lheight + 1
  else:
    return rheight + 1

proc findFirstFreeNode[T](self: BinaryTree[T], node: BinaryTreeNode[T], height: int): BinaryTreeNode[T] =
  ## Returns the first node with free child spots at the
  ## lowest level (closest to root).
  ## 
  ## Parameters
  ## * self: BinaryTree[T]
  ## * node: BinaryTreeNode[T]: Current node being operated on
  ## * height: int: Current height we are operating on
  if node == nil:
    return nil
  if height == 1:
    if node.left == nil or node.right == nil:
      return node
    else:
      return nil
  else:
    # Check both sides and choose the one with the smaller height
    var res_l: BinaryTreeNode[T] = nil
    var res_r: BinaryTreeNode[T] = nil
    res_l = self.findFirstFreeNode(node.left, height - 1)
    res_r = self.findFirstFreeNode(node.right, height - 1)
    # If both are have space choose the left side
    if res_l != nil and res_r != nil:
      if res_l.level <= res_r.level:
        return res_l
      else:
        return res_r
    # Else only one of them has space and prioritize left
    elif res_l != nil:
      return res_l
    elif res_r != nil:
      return res_r
    return nil

proc insertNodeBinaryTree*[T](self: BinaryTree[T], value: T) =
  ## Inserts a node into the tree given a parent
  ##
  ## Parameters
  ## ## * self: BinaryTree[T]
  ## * value: T: The key to search for
  ## 
  ## Returnes
  ## * Nothing
  assert self.root != nil
  # If node with a value exists exit
  if self.findNodeBinaryTree(value) != nil:
    return

  # Get max height
  let height: int = self.binaryTreeHeight(self.root)

  # Find the first available level and node and insert
  for i in 1..height:
    # First node location free
    let res: BinaryTreeNode[T] = self.findFirstFreeNode(self.root, i)
    # If the result is not nil then we can add
    if res != nil:
      var n: BinaryTreeNode[T] = new(BinaryTreeNode[T])
      n.parent = res
      n.left = nil
      n.right = nil
      n.value = value
      n.level = res.level + 1
      if res.left == nil:
        res.left = n
      elif res.right == nil:
        res.right = n
      else:
        assert false
      break


