class_name EnemyShoot
extends CharacterBody2D

@export var gravity = 100
@export var jump_speed = 90
@export var speed = 100
@export var jugador:CharacterBody2D

const ESCENA_BULLET = preload("res://personaje/bullet.tscn")

var jugador_detectado = false

func _physics_process(delta: float) -> void:
	#Direccion
	var direccion = -1 if (jugador.position.x - $".".position.x) < 0 else 1
	$Sprite.scale.x = direccion
	
	#Gravedad
	if not is_on_floor():
		velocity.y = velocity.y + gravity * delta
	
	move_and_slide()

func shoot():
	var instancia_bullet = ESCENA_BULLET.instantiate()
	
	# Posición inicial de la bala = posición global del sprite
	instancia_bullet.global_position = $".".position
	
	# Dirección hacia el jugador
	var jugador_position = jugador.position
	var dir = (jugador_position - instancia_bullet.global_position).normalized()
	instancia_bullet.direction = dir
	instancia_bullet.margin = Vector4(
		$Sprite.global_position.x - 500,
		$Sprite.global_position.y - 500,
		$Sprite.global_position.x + 500,
		$Sprite.global_position.y + 500
	)
	get_tree().current_scene.add_child(instancia_bullet)


func _on_timer_timeout() -> void:
	if jugador and jugador_detectado:
		shoot()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Personaje":
		jugador_detectado = true
