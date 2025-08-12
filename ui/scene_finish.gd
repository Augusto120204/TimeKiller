class_name SceneFinish
extends CanvasLayer

@export var scene_path = "res://niveles/FKennedy_Start.tscn"

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	$ColorRect.process_mode = Node.PROCESS_MODE_ALWAYS
	$ColorRect/VBoxContainer.process_mode = Node.PROCESS_MODE_ALWAYS
	$ColorRect/VBoxContainer/Label.process_mode = Node.PROCESS_MODE_ALWAYS

func set_title(title):
	$ColorRect/VBoxContainer/Label.text = title

func _on_button_button_down() -> void:
	print("Boton presionado")
	get_tree().paused = false
	GameState.vidas = 3        # Reinicia vidas aquí
	GameState.esta_muerto = false
	get_tree().change_scene_to_file(scene_path)


func _on_texture_button_button_down() -> void:
	print("Boton presionado")
	get_tree().paused = false
	GameState.vidas = 3        # Reinicia vidas aquí
	GameState.esta_muerto = false
	get_tree().change_scene_to_file(GameState.nivel_actual)


func _on_texture_button_pressed() -> void:
	print("Boton presionado")
	get_tree().paused = false
	GameState.vidas = 3        # Reinicia vidas aquí
	GameState.esta_muerto = false
	get_tree().change_scene_to_file(GameState.nivel_actual)


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Menu/menu.tscn")
