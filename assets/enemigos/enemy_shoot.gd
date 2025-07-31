extends EnemyBase

const ESCENA_BULLET = preload("res://weapon/enemy_bullet.tscn")

@onready var timer = $Timer

func _ready():
	jugador = get_tree().current_scene.get_node("Personaje")
	timer.timeout.connect(_on_timer_timeout)

# Sobrescribimos detección para controlar Timer también
func _on_area_2d_body_entered(body: Node2D) -> void:
	# Llama al padre para cambiar estado
	super._on_area_2d_body_entered(body)
	if body.name == "Personaje" and state == State.ATTACKING:
		timer.start()

func _on_area_2d_body_exited(body: Node2D) -> void:
	super._on_area_2d_body_exited(body)
	if body.name == "Personaje" and state == State.IDLE:
		timer.stop()

func _on_timer_timeout() -> void:
	if jugador and state == State.ATTACKING:
		shoot()
		
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
