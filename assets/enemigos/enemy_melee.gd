class_name EnemyMelee
extends CharacterBody2D

@export var gravity = 100
@export var jump_speed = 90
@export var speed = 100
@export var jugador: CharacterBody2D

var jugador_detectado = false
var puede_danar = true
@export var tiempo_entre_danos = 1.0  # cooldown segundos
@export var damage_range = 20.0       # distancia para hacer daño

func _physics_process(delta: float) -> void:
	if jugador:
		# Actualizar dirección y escala del sprite
		var direccion = -1 if (jugador.position.x - global_position.x) < 0 else 1
		$Sprite.scale.x = direccion

		if jugador_detectado:
			var dist = global_position.distance_to(jugador.position)
			if dist <= damage_range and puede_danar:
				jugador.hp_down()
				puede_danar = false
				# Esperar cooldown sin bloquear
				await get_tree().create_timer(tiempo_entre_danos).timeout
				puede_danar = true

	if not is_on_floor():
		velocity.y += gravity * delta

	if jugador and jugador_detectado:
		atacar()

	move_and_slide()

func hp_down():
	print("- 1 vida del enemigo a melee")
	queue_free()

func atacar():
	var dir = sign(jugador.position.x - global_position.x)
	velocity.x = dir * speed

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Personaje:
		jugador_detectado = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Personaje:
		jugador_detectado = false
