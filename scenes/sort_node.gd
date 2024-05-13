extends "nodo.gd"

func _init(data):
	if (data != null):
		self.setData(data)
		self.setRoot(self)
	else:
		self.setRoot(null)

func addNode(nodo):
	if(self.getData()==null):
		self.setData(nodo.getData())
		self.setRoot(nodo)
		return null
	if(self.getData() > nodo.getData()):
		if(getLeft()!=null):
			self.getLeft().addNode(nodo)
		else:
			nodo.setPadre(self)
			nodo.setRoot(self.getRoot())
			setLeft(nodo)
	else:
		if(getRight()!=null):
			self.getRight().addNode(nodo)
		else:
			nodo.setPadre(self)
			nodo.setRoot(self.getRoot())
			setRight(nodo)
	#estaBalanceado()

func deleteNode(nodo):
	var sucesor
	if(nodo.getRight()!=null):
		sucesor = (nodo.getRight()).sucesor()
		if(!sucesor.getPadre() == nodo):
			sucesor.getPadre().setLeft(sucesor.getRight())
		else:
			nodo.setRight(sucesor.getRight())
		nodo.setData(sucesor.getData())
		if(nodo.getRoot() == self.getRoot()):
			nodo.setRoot(sucesor)
	else:
		if(nodo.getPadre().getLeft() == nodo):
			nodo.getPadre().setLeft(nodo.getLeft())
		elif (nodo.getPadre().getRight() == nodo):
			nodo.getPadre().setRight(nodo.getLeft())
		estaBalanceado()
		return null
	estaBalanceado()

func buscar(data):
	if(self.getData() == data):
		return self;
	if(self.getData() > data):
		return self.getLeft().buscar(data);
	else:
		return self.getRight().buscar(data);
	pass

func alturaIzquierda():
	var altura
	if(self.getLeft()!=null):
		altura = 1+self.getLeft().alturaIzquierda()
	else:
		altura = 0
	return altura

func alturaDerecha():
	var altura
	if(self.getRight()!=null):
		altura = 1+self.getRight().alturaDerecha()
	else:
		altura = 0
	return altura

func calcularPeso():
	self.peso =  self.alturaDerecha()-self.alturaIzquierda()
	return self.getPeso()

func rotacionIzquierda(nodo):
	print("Rotacion Izquierda")
	print("Nodo con dato: ",nodo.getData())
	var suc = nodo.getRight()
	print("El sucesor es: ",suc.getData())
	var left = suc.getLeft()
	print("La raiz de ese nodo es:", nodo.getRoot().getData())
	if nodo != nodo.getRoot():
		print("No es raiz")
		var padre = nodo.getPadre()
		if(nodo == padre.getLeft()):
			padre.setLeft(suc)
		else:
			padre.setRight(suc)
	else:
		self.setRoot(suc)
	nodo.setRight(left)
	suc.setLeft(nodo)
	return null

func rotacionDerecha(nodo):
	print("Rotacion Izquierda")
	print("Nodo con dato: ",nodo.getData())
	var suc = nodo.getLeft()
	print("El sucesor es: ",suc.getData())
	var right = suc.getRight()
	print("La raiz de ese nodo es:", nodo.getRoot().getData())
	if !nodo == nodo.getRoot():
		var padre = nodo.getPadre()
		if(nodo == padre.getLeft()):
			padre.setLeft(suc)
		else:
			padre.setRight(suc)
	else:
		self.setRoot(suc)
	nodo.setLeft(right)
	suc.setRight(nodo)
	pass

func estaBalanceado():
	self.calcularPeso()
	if(self.peso == 2 || self.peso ==-2 ):
		balancear()
	else:
		return null

func balancear():
	match self.calcularPeso():
		2:
			match self.getRight().calcularPeso():
				1:
					rotacionIzquierda(self.getRight())
					return null
				-1:
					rotacionDerecha(self.getRight())
					rotacionIzquierda(self.getRight())
					return null
			match self.getLeft().calcularPeso():
				1:
					rotacionIzquierda(self.getLeft())
					return null
				-1:
					rotacionIzquierda(self.getLeft())
					rotacionDerecha(self.getLeft())
					return null
			
		-2:
			match self.getLeft().calcularPeso():
				1:
					rotacionIzquierda(self.getLeft())
					rotacionDerecha(self.getLeft())
					return null
				-1:
					rotacionDerecha(self.getLeft())
					return null
			
			match self.getRight().calcularPeso():
				1:
					rotacionIzquierda(self.getRight())
					return null
				-1:
					rotacionDerecha(self.getRight())
					rotacionIzquierda(self.getRight())
					return null

func moverNodo():
	pass
