extends  'arbol_binario.gd'

var data
var peso
var left
var right
var padre

func buscar(data):
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
	print(self.getData())
	if(getRight()!=null):
		getRight().inorder()

func sucesor():
	if(self.getLeft() !=null):
		return self.getLeft().sucesor()
	return self

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

func getPeso():
	return peso

func getPadre():
	return padre

func setPadre(padre):
	self.padre = padre
