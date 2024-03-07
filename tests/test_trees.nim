import ../data-structures/trees

proc testBinaryTree1() =
  ## Create BinaryTree with single node
  echo "Running testBinaryTree1..."
  discard newBinaryTree(1)

proc testBinaryTree2() =
  ## Create new BinaryTree and find the root
  echo "Running testBinaryTree2..."
  var t: BinaryTree[int] = newBinaryTree(1)
  let n: BinaryTreeNode[int] = t.findNodeBinaryTree(1)
  assert n.left == nil
  assert n.right == nil
  assert n.value == 1

proc testBinaryTree3() =
  ## Test insertion
  echo "Running testBinaryTree3..."
  var t: BinaryTree[int] = newBinaryTree(3)
  t.insertNodeBinaryTree(2)  
  t.insertNodeBinaryTree(3)
  t.insertNodeBinaryTree(4)
  t.insertNodeBinaryTree(5)
  t.insertNodeBinaryTree(6)
  t.insertNodeBinaryTree(7)

  #      3
  #    /   \
  #   2     4
  #  / \   /
  # 5   6 7
  # echo $t.findNodeBinaryTree(3)
  # echo $t.findNodeBinaryTree(2)
  # echo $t.findNodeBinaryTree(4)
  # echo $t.findNodeBinaryTree(5)
  # echo $t.findNodeBinaryTree(6)
  # echo $t.findNodeBinaryTree(7)
  assert t.findNodeBinaryTree(3).left.value == 2
  assert t.findNodeBinaryTree(3).right.value == 4
  assert t.findNodeBinaryTree(2).left.value == 5
  assert t.findNodeBinaryTree(5).left == nil
  assert t.findNodeBinaryTree(5).right == nil
  assert t.findNodeBinaryTree(2).right.value == 6
  assert t.findNodeBinaryTree(6).left == nil
  assert t.findNodeBinaryTree(6).right == nil
  assert t.findNodeBinaryTree(4).left.value == 7
  assert t.findNodeBinaryTree(4).right == nil
     
when isMainModule:
  testBinaryTree1()
  testBinaryTree2()
  testBinaryTree3()
