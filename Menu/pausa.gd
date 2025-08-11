extends CanvasLayer

@onready var overlay := $ColorRect
@onready var menu_buttons := $VBoxContainer
@onready var settings_container := $SettingsContainer

func _ready():
	overlay.visible = false
	menu_buttons.visible = false
	settings_container.visible = false

	# Conectar la señal 'back_pressed' del SettingsContainer a una función local
	settings_container.connect("back_pressed", Callable(self, "_on_settings_back"))

func _on_settings_back():
	settings_container.visible = false
	menu_buttons.visible = true
	# Mostrar overlay solo si el juego está pausado y no estamos en configuraciones
	overlay.visible = get_tree().paused

func _input(event):
	if event.is_action_pressed("pausa"):
		var paused = not get_tree().paused
		get_tree().paused = paused
		# Mostrar overlay solo si está pausado y no en configuraciones
		overlay.visible = paused and not settings_container.visible
		menu_buttons.visible = paused
		if not paused:
			settings_container.visible = false

func _on_jugar_pressed():
	get_tree().paused = false
	overlay.visible = false
	menu_buttons.visible = false
	settings_container.visible = false

func _on_salir_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Menu/menu.tscn")

func _on_configuraciones_pressed():
	settings_container.visible = true
	menu_buttons.visible = false
	overlay.visible = false  # Ocultar overlay porque estamos en configuraciones
