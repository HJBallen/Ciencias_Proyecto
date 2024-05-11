extends  'arbol_binario.gd'

var data
var left
var right
var padre


func search(data):
	var node
	if self.data == data:
		return self
	node = left.search(data)
	if node == null:
		node.right.search(data)
	return node

func inorder():
	if getLeft() !=null:
		getLeft().inorder()
	if(getRight()!=null):
		getRight().inorder()

func getData():
	return data

func setData(data):
	self.data = data

func getLeft():
	return left

func setLeft(nodo):
	self.left = nodo

func getRight():
	return right

func setRight(nodo):
	self.right = nodo

func getParent():
	return padre

func setPadre(padre):
	self.padre = padre
