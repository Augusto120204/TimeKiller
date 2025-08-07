class_name CameraInterior
extends Camera2D

@export var object_to_follow: Node2D

var follow_character = true

func _process(_delta: float) -> void:
	if follow_character:
		# Posición objetivo basada en el personaje
		var target_x = object_to_follow.position.x + 50
		var target_y = object_to_follow.position.y

		# Limites más estrictos en X, más amplios en Y
		position.x = clamp(target_x, 194, 208)  # Ajusta 408 si era un error tipográfico en tu código
		position.y = clamp(target_y, 180, 360)  # Ejemplo de límites verticales más amplios
