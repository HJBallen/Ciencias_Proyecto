extends  'arbol_binario.gd'

var data
var peso
var left = null
var right = null
var padre

func buscar(dato):
	var node
	if self.data == dato:
		return self
	node = left.search(dato)
	if node == null:
		node.right.search(dato)
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

func setData(dato):
	self.data = dato

func getLeft():
	return left

func setLeft(nodo):
	if nodo !=null:
		nodo.setPadre(self)
	self.left = nodo

func getRight():
	return right

func setRight(nodo):
	if nodo !=null:
		nodo.setPadre(self)
	self.right = nodo

func getPeso():
	return peso

func getPadre():
	return padre

func setPadre(parent):
	self.padre = parent
