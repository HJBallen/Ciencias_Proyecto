extends Node2D

var nivel := 0


@onready var arbol = preload("res://scenes/sort_node.gd").new(null)
@onready var memoria = $GridContainer.get_children()
@onready var raiz = $raiz

var arbol_gui = []

var desactivar_agregar = false
var desactivar_eliminar = false


func _ready():
	for nodo in get_children():
		if nodo.is_in_group("nodo"):
			nodo.visible=false
			arbol_gui.append(nodo)
	raiz.visible = true
	var contador :=0
	for i in memoria:
		i.text=""

func _process(delta):
	llenarMemoria()
	if memoria[0].text == "":
		desactivar_eliminar=true
	else:
		desactivar_eliminar=false
	$Agregar.disabled = desactivar_agregar
	$Eliminar.disabled = desactivar_eliminar

func agregarDato(dato):
	dato = int(dato)
	var newNode = preload("res://scenes/sort_node.gd").new(dato)
	arbol.addNode(newNode)
	dibujarArbol()

func eliminarDato(dato):
	var nodo_e = arbol.buscar(int(dato))
	if(nodo_e !=null):
		arbol.deleteNode(nodo_e)
		dibujarArbol()

func llenarMemoria():
	var arreglo = []
	if arbol.getData() != null:
		arreglo = arbol.to_array()
	if arreglo.size()>0:
		var contador=0
		for i in arreglo:
			if i!=null:
				memoria[contador].text =str(i.getData())
			else:
				memoria[contador].text =""
			contador+=1

func dibujarArbol():
	var nodos = arbol.to_array()
	var contador := 0

	for nodo in arbol_gui:
		if contador > 30:
			continue
		var hijoIzq = (2 * contador) + 1
		var hijoDer = (2 * contador) + 2
		
		if contador == 0:
			nodo.label.text = str(nodos[0].getData())
			
		
		if nodos[hijoIzq] !=null:
			arbol_gui[hijoIzq].visible = true
			arbol_gui[hijoIzq].label.text = str(nodos[hijoIzq].getData())
			nodo.hijoIzq = arbol_gui[hijoIzq].global_position - nodo.global_position
		else:
			arbol_gui[hijoIzq].visible = false
			nodo.hijoIzq = Vector2(0,0)
		if nodos[hijoDer] !=null:
			arbol_gui[hijoDer].visible = true
			arbol_gui[hijoDer].label.text = str(nodos[hijoDer].getData())
			nodo.hijoDer = arbol_gui[hijoDer].global_position - nodo.global_position
		else:
			arbol_gui[hijoDer].visible = false
			nodo.hijoDer = Vector2(0,0)
		contador += 1

func calcularPosicionNodo(padre_gui, esIzquierdo):
	var desplazamiento_horizontal = 40
	var desplazamiento_vertical = 50
	if esIzquierdo:
		return padre_gui.global_position + Vector2(-desplazamiento_horizontal, desplazamiento_vertical)
	else:
		return padre_gui.global_position + Vector2(desplazamiento_horizontal, desplazamiento_vertical)

func _on_agregar_pressed():
	var dato = $Dato.text
	if (dato != "" ):
		agregarDato(dato)
		$Dato.text = ""
	return null	

func _on_eliminar_pressed():
	var dato =$Dato_E.text
	if (dato!=""):
		eliminarDato(dato)
		$Dato_E.text = ""
	return null

func _on_area_collision(area):
	area.get_parent().moverSubArbol()
