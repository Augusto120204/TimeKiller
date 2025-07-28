class_name EnemyMelee
extends CharacterBody2D

@export var gravity = 100
@export var jump_speed = 90
@export var speed = 100
@export var jugador:CharacterBody2D

var jugador_detectado = false

func _physics_process(delta: float) -> void:	
	#Direccion
	var direccion = -1 if (jugador.position.x - $".".position.x) < 0 else 1
	$Sprite.scale.x = direccion
	
	#Gravedad
	if not is_on_floor():
		velocity.y = velocity.y + gravity * delta
	
	if jugador and jugador_detectado:
		atack()
	
	move_and_slide()

func hp_down():
	print("- 1 vida del enemigo a melee")
	queue_free()

func atack():
	# Dirección hacia el jugador
	var jugador_position = jugador.position
	
	if jugador_position.x != $".".position.x:
		var dir = (jugador_position.x - $".".position.x) / abs(jugador_position.x - $".".position.x)
		velocity.x = dir * speed


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Personaje":
		jugador_detectado = true
