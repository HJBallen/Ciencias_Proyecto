extends Area2D

@onready var label = $CenterContainer/Label

var hijoIzq := Vector2(0,0)
var hijoDer := Vector2(0,0)

func _process(delta):
	queue_redraw()

func _draw():
	# Dibujar flechas desde el nodo padre a cada uno de los nodos hijos
	if hijoDer != Vector2.ZERO:
		draw_arrow(Vector2(0,0), hijoDer, Color(1, 0, 0), 5)
	if hijoIzq != Vector2.ZERO:
		draw_arrow(Vector2(0,0), hijoIzq, Color(1, 0, 0), 5)

func draw_arrow(from: Vector2, to: Vector2, color: Color, width: float):
	# Dibujar la línea de la flecha
	draw_line(from, to, color, width)
	# Calcular la dirección y el ángulo de la punta de la flecha
	var direction = (to - from).normalized()
	var arrow_size = 10
	var angle = PI / 6
	var left_wing = direction.rotated(angle) * arrow_size
	var right_wing = direction.rotated(-angle) * arrow_size
	# Dibujar las puntas de la flecha
	draw_line(to, to - left_wing, color, width)
	draw_line(to, to - right_wing, color, width)
