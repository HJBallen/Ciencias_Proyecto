extends Node2D

var nivel := 0


@onready var arbol = preload("res://scenes/sort_node.gd").new(null)
@onready var memoria = $GridContainer.get_children()
@onready var raiz = $raiz

var desactivar_agregar = false
var desactivar_eliminar = false

func _ready():
	for i in memoria:
		i.text=""

func _process(delta):
	#llenarMemoria()
	$Agregar.disabled = desactivar_agregar
	$Eliminar.disabled = desactivar_eliminar

func agregarDato(dato):
	dato = int(dato)
	var newNode = preload("res://scenes/sort_node.gd").new(dato)
	arbol.addNode(newNode)
	if arbol.getPadre()!=null:
		print(arbol.getPadre().getData())
	if(arbol.calcularNivel() == 5):
		desactivar_agregar = true
	llenarMemoria()
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
	print(arreglo)

func dibujarArbol():
	var posicion_anterior = raiz.global_position
	var nodos = arbol.to_array()
	if nodos[0] !=null:
		raiz.label = nodos[0].getData()

func _on_agregar_pressed():
	var dato = $Dato.text
	if (dato != "" ):
		agregarDato(dato)
		$Dato.text = ""
	return null	

func _on_eliminar_pressed():
	if(arbol.calcularNivel() == 0):
		return null
	else:
		desactivar_agregar = false
	pass # Replace with function body.
