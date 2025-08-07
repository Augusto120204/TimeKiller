class_name Personaje
extends CharacterBody2D

signal player_hit
signal player_hp_up

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hit_sound: AudioStreamPlayer2D = $HitSound
@onready var hp_up_sound: AudioStreamPlayer2D = $HpUpSound
@onready var hit_down: AudioStreamPlayer2D = $HitDown
@export var gravity = 950
@export var jump_speed = 300
@export var speed = 150

var current_state = ''

func _physics_process(delta: float) -> void:
	# Extraer la posicion del mouse y del jugador
	var mouse_pos = get_global_mouse_position()
	var mouse_dir = (mouse_pos - $Sprite2D.global_position).normalized()
	var sprite_x = $Sprite2D.global_position.x
	# Obtener -1 en caso de que el mouse este por detras del personaje para las rotaciones
	var mouse_dir_value = -1 if mouse_pos.x < sprite_x else 1
	# Mover el brazo
	$ArmNode.rotation = mouse_dir.angle()
	$ArmNode.scale.y = mouse_dir_value
	# Mover al personaje
	$Sprite2D.scale.x = mouse_dir_value
	
	# Obtener dirección del input
	var direction = Input.get_axis("izquierda", "derecha")
	# Limitar movimiento hacia la izquierda si el personaje ya está en x <= 0
	if direction < 0 and global_position.x <= 0:
		direction = 0
	# Mover al personaje
	velocity.x = direction * speed
	
	#Gravedad
	if not is_on_floor():
		velocity.y = velocity.y + gravity * delta
	#Saltar
	var jump_pressed = Input.is_action_just_pressed("salto")
	
	# Detectar disparo y llamar a la animacion
	var shoot_pressed = Input.is_action_pressed("shoot")
	if(shoot_pressed):
		shoot()
	
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
	if $ArmNode/Rifle/AnimationPlayer:
		$ArmNode/Rifle/AnimationPlayer.play("shoot")
	if $ArmNode/Pistol/AnimationPlayer:
		$ArmNode/Pistol/AnimationPlayer.play("shoot")


func hp_up():
	print("+ 1 vida")
	hp_up_sound.play()
	player_hp_up.emit()
	

func hp_down():
	print("- 1 vida")
	hit_sound.play(0.25)
	hit_down.play(0.50)
	player_hit.emit()
