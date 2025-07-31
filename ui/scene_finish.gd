class_name SceneFinish
extends CanvasLayer

@export var scene_path = "res://niveles/nivel_1.tscn"

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	$ColorRect.process_mode = Node.PROCESS_MODE_ALWAYS
	$ColorRect/VBoxContainer.process_mode = Node.PROCESS_MODE_ALWAYS
	$ColorRect/VBoxContainer/Label.process_mode = Node.PROCESS_MODE_ALWAYS
	$ColorRect/VBoxContainer/Button.process_mode = Node.PROCESS_MODE_ALWAYS

func set_title(title):
	$ColorRect/VBoxContainer/Label.text = title

func _on_button_button_down() -> void:
	print("Boton presionado")
	get_tree().paused = false
	get_tree().change_scene_to_file(scene_path)


func _on_texture_button_button_down() -> void:
	print("Boton presionado")
	get_tree().paused = false
	get_tree().change_scene_to_file(scene_path)


func _on_texture_button_pressed() -> void:
	print("Boton presionado")
	get_tree().paused = false
	get_tree().change_scene_to_file(scene_path)
