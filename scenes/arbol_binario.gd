extends Node2D

var root : Object

func addNodeAr(padre, hijo, isLeft):
	hijo.setParent(padre)
	if isLeft:
		padre.setLeft(hijo)
	else:
		padre.setRight(hijo)

func inorder():
	if(getRoot() != null):
		getRoot().inorder()

func getRoot():
	return root

func setRoot(newRoot):
	self.root = newRoot
