class_name Camera2_4
extends Camera2D

@export var object_to_follow:Node2D

var follow_character = true

func _process(_delta: float) -> void:
	if follow_character:
		# Calcula la posición deseada basada en el personaje
		var target_x = object_to_follow.position.x + 50
		
		# Limita la posición de la cámara entre 194 y 408
		position.x = clamp(target_x, 194, 380)

		# Posición fija en Y
		position.y = 162
