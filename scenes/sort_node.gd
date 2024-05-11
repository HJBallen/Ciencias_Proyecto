extends "nodo.gd"

func _init(data = null):
	if (data != null):
		self.setData(data)
		self.setRoot(self)
	else:
		self.setRoot(null)

func addNode(nodo):
	if(self.getData()==null):
		self.setData(nodo.getData())
		self.setRoot(nodo)
		pass
	if(self.getData() > nodo.getData()):
		if(getLeft()!=null):
			self.getLeft().addNode(nodo)
		else:
			nodo.setPadre(self)
			setLeft(nodo)
	else:
		if(getRight()!=null):
			self.getRight().addNode(nodo)
		else:
			nodo.setPadre(self)
			setRight(nodo)
func deleteNode(nodo):
	var sucesor
	if(nodo.getRight()!=null):
		sucesor = (nodo.getRight()).sucesor()
		
		
