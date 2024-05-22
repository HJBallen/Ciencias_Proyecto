extends Area2D

@onready var label = $CenterContainer/Label.text

var hijo_izq:=false
var hijo_der:=false


		
func moverSubArbol():
	if (hijo_izq):
		global_position.x-=2
	if(hijo_der):
		global_position.x+=2
	pass
