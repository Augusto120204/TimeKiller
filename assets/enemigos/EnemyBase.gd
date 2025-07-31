class_name EnemyBase
extends CharacterBody2D

@export var gravity: float = 100
@export var jump_speed: float = 90
@export var speed: float = 100
@export var jugador: CharacterBody2D

enum State {
	IDLE,
	ATTACKING,
	DEAD
}

var state: State = State.IDLE

func _physics_process(delta: float) -> void:
	update_direction()
	apply_gravity(delta)
	state_machine(delta)
	move_and_slide()

func update_direction():
	if jugador:
		var direccion = -1 if (jugador.position.x - position.x) < 0 else 1
		if has_node("Sprite"):
			$Sprite.scale.x = direccion

func apply_gravity(delta: float):
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0

func state_machine(delta: float):
	match state:
		State.IDLE:
			state_idle(delta)
		State.ATTACKING:
			state_attacking(delta)
		State.DEAD:
			state_dead(delta)

# Métodos virtuales para que las clases hijas los sobreescriban
func state_idle(delta: float) -> void:
	pass

func state_attacking(delta: float) -> void:
	pass

func state_dead(delta: float) -> void:
	pass

func hp_down():
	if state != State.DEAD:
		state = State.DEAD
		print("-1 vida del enemigo")
		queue_free()

# Solo cambia el estado, no maneja Timer aquí
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Personaje" and state != State.DEAD:
		print('Enemigo detectó jugador - cambiando a ATTACKING')
		state = State.ATTACKING

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Personaje" and state != State.DEAD:
		print('Enemigo perdió jugador - cambiando a IDLE')
		state = State.IDLE
