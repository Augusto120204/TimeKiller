extends Node2D

@onready var sprite: Sprite2D = $StaticBody2D/Background3
@onready var flash: ColorRect = $FlashRect
@onready var cam: Camera2D = $Camera2D
@onready var drop_bomb_sound: AudioStreamPlayer2D = $StaticBody2D/DropBombSound
@onready var explosion_sound: AudioStreamPlayer2D = $StaticBody2D/ExplosionSound

var shake_intensity: float = 0.0

func _ready():
	drop_bomb_sound.play()
	await get_tree().create_timer(2.0).timeout  # Espera 2 seg antes del cambio
	cambiar_imagen_con_efecto("res://assets/nivel2/background/background_5.jpg")

func cambiar_imagen_con_efecto(nueva_ruta: String) -> void:
	# 1. Flash
	flash.color = Color(1, 1, 1, 1) # Blanco opaco
	flash.visible = true
	flash.modulate.a = 1.0

	# 2. Shake
	shake_intensity = 9
	start_shake()

	# 3. Espera un instante y cambia la imagen
	await get_tree().create_timer(0.1).timeout
	sprite.texture = load(nueva_ruta)

	# 4. Fade del flash
	var tween = create_tween()
	explosion_sound.play()
	tween.tween_property(flash, "modulate:a", 0.0, 2)
	tween.tween_callback(Callable(self, "_ocultar_flash"))

func _ocultar_flash():
	flash.visible = false

func start_shake():
	var shake_timer = Timer.new()
	shake_timer.wait_time = 0.05
	shake_timer.one_shot = false
	add_child(shake_timer)
	shake_timer.timeout.connect(_on_shake_timer_timeout)
	shake_timer.start()
	await get_tree().create_timer(3).timeout  # Duración total del shake
	shake_timer.stop()
	cam.offset = Vector2.ZERO
	shake_timer.queue_free()

func _on_shake_timer_timeout():
	cam.offset = Vector2(
		randf_range(-shake_intensity, shake_intensity),
		randf_range(-shake_intensity, shake_intensity)
	)
