class_name EnemyShoot
extends CharacterBody2D

@export var gravity = 100
@export var jump_speed = 90
@export var speed = 100
@export var jugador: CharacterBody2D

const ESCENA_BULLET = preload("res://weapon/enemy_bullet.tscn")

enum State {
	IDLE,
	ATTACKING,
	DEAD
}

var state = State.IDLE

func _physics_process(delta: float) -> void:
	# Dirección del sprite hacia el jugador
	var direccion = -1 if (jugador.position.x - position.x) < 0 else 1
	$Sprite.scale.x = direccion
	
	# Aplicar gravedad
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# FSM
	match state:
		State.IDLE:
			pass
		State.ATTACKING:
			pass
		State.DEAD:
			pass
	
	move_and_slide()

func shoot():
	var instancia_bullet = ESCENA_BULLET.instantiate()
	instancia_bullet.global_position = position
	
	var dir = (jugador.position - position).normalized()
	instancia_bullet.direction = dir
	instancia_bullet.margin = Vector4(
		position.x - 500,
		position.y - 500,
		position.x + 500,
		position.y + 500
	)
	get_tree().current_scene.add_child(instancia_bullet)

func hp_down():
	if state != State.DEAD:
		state = State.DEAD
		print("- 1 vida del enemigo a rango")
		queue_free()

# Cuando el jugador entra en el área de detección
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Personaje" and state != State.DEAD:
		state = State.ATTACKING

# Cuando el jugador sale del área de detección
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Personaje" and state != State.DEAD:
		state = State.IDLE

# Timer que se activa cada X segundos para disparar
func _on_timer_timeout() -> void:
	if jugador and state == State.ATTACKING:
		shoot()
