extends "nodo.gd"

var data_arbol = []

func _init(dato):
	if (dato != null):
		self.setData(dato)
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
			setLeft(nodo)
	else:
		if(getRight()!=null):
			self.getRight().addNode(nodo)
		else:
			nodo.setPadre(self)
			setRight(nodo)

func deleteNode(nodo):
	var suc
	if(nodo.getRight()!=null):
		suc = (nodo.getRight()).sucesor()
		if(!suc.getPadre() == nodo):
			suc.getPadre().setLeft(suc.getRight())
		else:
			nodo.setRight(suc.getRight())
		nodo.setData(suc.getData())
		if(nodo.getRoot() == self.getRoot()):
			nodo.setRoot(suc)
	else:
		if(nodo.getPadre().getLeft() == nodo):
			nodo.getPadre().setLeft(nodo.getLeft())
		elif (nodo.getPadre().getRight() == nodo):
			nodo.getPadre().setRight(nodo.getLeft())
		return null


func buscar(dato):
	if(self.getData() == dato):
		return self;
	if(self.getData() > dato):
		return self.getLeft().buscar(dato);
	else:
		return self.getRight().buscar(dato);

func altura():
	var alt
	if(self.getLeft()!=null and self.getRight() !=null):
		alt = 1 + max(self.getLeft().altura(),self.getRight().altura())
	elif self.getLeft() != null:
		alt= 1+self.getLeft().altura()
	elif self.getRight() != null:
		alt= 1+self.getRight().altura()
	else:
		alt = 1
	return alt

func alturaIzq():
	if self.getLeft() == null:
		return 0
	else:
		return self.getLeft().altura()

func alturaDer():
	if(self.getRight()==null):
		return 0
	else:
		return self.getRight().altura()

func calcularPeso():
	self.peso = self.alturaDer() - self.alturaIzq()
	return self.getPeso()

func rotacionIzquierda(nodo):
	print("Rotacion Izquierda")
	print("Nodo con dato: ",nodo.getData())
	var suc = nodo.getRight()
	print("El sucesor es: ",suc.getData())
	var left = suc.getLeft()
	if left!=null:
		print(left.getData())
	print("La raiz de ese nodo es:", nodo.getRoot().getData())
	if (nodo.getPadre() != null):
		print("No es raiz")
		var pa = nodo.getPadre()
		if nodo.getData() == 4:
			if pa.getLeft() !=null:
				print(pa.getLeft().getData())
		if nodo == pa.getLeft():
			pa.setLeft(suc)
		if nodo == pa.getRight():
			pa.setRight(suc)
		nodo.setRight(left)
		if(left!=null):
			left.setPadre(nodo)
		suc.setLeft(nodo)
		suc.setPadre(pa)
		nodo.setPadre(suc)
	else:
		print("Es raiz")
		var aux1 = suc.getData()
		var aux2 = nodo.getLeft()
		suc.setData(nodo.getData())
		nodo.setData(aux1)
		suc.setLeft(aux2)
		if aux2 != null:
			aux2.setPadre(suc)
		nodo.setLeft(suc)
		nodo.setRight(suc.getRight())
		if(suc.getRight()!=null):
			suc.getRight().setPadre(nodo)
		suc.setRight(left)
		if left != null:
			left.setPadre(suc)
		nodo.getRoot().setData(nodo.getData())
	return null

func rotacionDerecha(nodo):
	print("Rotacion Derecha Sobre el nodo", nodo.getData())
	var suc = nodo.getLeft()
	var right = suc.getRight()
	if (nodo.getPadre() != null):
		print("No es raiz")
		var pa = nodo.getPadre()
		print(pa.getData())
		if nodo == pa.getLeft():
			pa.setLeft(suc)
		if nodo == pa.getRight():
			pa.setRight(suc)
		nodo.setLeft(right)
		if right != null:
			right.setPadre(nodo)
		suc.setRight(nodo)
		suc.setPadre(pa)
		nodo.setPadre(suc)
	else:
		print("Es raiz")
		var aux1 = suc.getData()
		var aux2 = nodo.getRight()
		suc.setData(nodo.getData())
		nodo.setData(aux1)
		suc.setRight(aux2)
		if aux2 != null:
			aux2.setPadre(suc)
		nodo.setRight(suc)
		nodo.setLeft(suc.getLeft())
		if(suc.getLeft()!=null):
			suc.getLeft().setPadre(nodo)
		suc.setLeft(right)
		if right != null:
			right.setPadre(suc)
		nodo.getRoot().setData(nodo.getData())
	suc.getPadre().estaBalanceado()
	
	return null

func estaBalanceado():
	if(self.calcularPeso() ==2 or self.calcularPeso() == -2):
		balancear()
	else:
		return null

func balancear():
	print(self.getData())
	match self.calcularPeso():
		2:
			match self.getRight().calcularPeso():
				1:
					rotacionIzquierda(self)
				-1:
					rotacionDerecha(self)
					rotacionIzquierda(self)
				0:
					rotacionIzquierda(self)
			return null
			if(self.getLeft() == null):
				return null
		-2:
			match self.getLeft().calcularPeso():
				1:
					rotacionIzquierda(self)
					rotacionDerecha(self)
				-1:
					rotacionDerecha(self)
				0:
					rotacionDerecha(self)
			if(self.getRight() == null):
				return null
			return null

func to_array() -> Array:
	var result = Array()
	var queue = []
	var raiz
	if(getPadre() == null):
		raiz = self
	else:
		raiz = getRoot()
	if raiz != null:
		queue.append(raiz)
	while result.size() < 64:
		if queue.size() == 0:
			result.append(null)
		else:
			var current = queue.pop_front()
			if current != null:
				result.append(current)
				queue.append(current.getLeft())
				queue.append(current.getRight())
			else:
				result.append(null)
				queue.append(null)
				queue.append(null)
	return result
