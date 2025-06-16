class_name Player
extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var gravity = 115
@export var jump_speed = 100
@export var speed = 150

const ESCENA_BULLET = preload("res://personaje/bullet.tscn")

var current_state = ''

func _physics_process(delta: float) -> void:
	# Obtener dirección del input
	var direction = Input.get_axis("izquierda", "derecha")
	
	# Limitar movimiento hacia la izquierda si el personaje ya está en x <= 0
	if direction < 0 and global_position.x <= 0:
		direction = 0
	
	velocity.x = direction * speed
	
	var shoot_pressed = Input.is_action_just_pressed("shoot")
	if(shoot_pressed):
		shoot()
	
	#Gravedad
	if not is_on_floor():
		velocity.y = velocity.y + gravity * delta
	#Saltar
	var jump_pressed = Input.is_action_just_pressed("salto")
	
	#Manejar animaciones
	if jump_pressed and is_on_floor():
		velocity.y = velocity.y - jump_speed
		set_animation("jump")
	elif not is_on_floor():
		if animation_player.current_animation != "jump" or not animation_player.is_playing():
			animation_player.play("falling")
	elif (direction != 0):
		set_animation("run")
	else:
		set_animation("idle")
	
	move_and_slide()

func set_animation(action: String) -> void:
	if(action != current_state):
		current_state = action
		animation_player.play(action)

func shoot():
	var instancia_bullet = ESCENA_BULLET.instantiate()
	
	# Posición inicial de la bala = posición global del sprite
	instancia_bullet.global_position = $Sprite2D.global_position
	
	# Dirección hacia el mouse
	var mouse_pos = get_global_mouse_position()
	var dir = (mouse_pos - instancia_bullet.global_position).normalized()
	instancia_bullet.direction = dir
	instancia_bullet.margin = Vector4(
		$Sprite2D.global_position.x - 500,
		$Sprite2D.global_position.y - 500,
		$Sprite2D.global_position.x + 500,
		$Sprite2D.global_position.y + 500
	)
	get_tree().current_scene.add_child(instancia_bullet)
