class_name Pistol
extends Sprite2D

const ESCENA_BULLET = preload("res://weapon/player_bullet.tscn")

@onready var gun_sound: AudioStreamPlayer2D = $GunSound

func shoot():
	var instancia_bullet = ESCENA_BULLET.instantiate()
	
	# Posición inicial de la bala = posición global del sprite
	instancia_bullet.global_position = $".".global_position
	
	# Dirección hacia el mouse
	var mouse_pos = get_global_mouse_position()
	var mouse_dir = (mouse_pos - $".".global_position).normalized()
	instancia_bullet.direction = mouse_dir
	instancia_bullet.margin = Vector4(
		$".".global_position.x - 500,
		$".".global_position.y - 500,
		$".".global_position.x + 500,
		$".".global_position.y + 500
	)
	get_tree().current_scene.add_child(instancia_bullet)
	gun_sound.play(0.2)
