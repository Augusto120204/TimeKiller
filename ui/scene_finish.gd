class_name SceneFinish
extends CanvasLayer

@export var scene_path = "res://niveles/nivel_1.tscn"

func set_title(title):
	$ColorRect/VBoxContainer/Label.text = title

func _on_button_button_down() -> void:
	print("Boton presionado")
	get_tree().change_scene_to_file(scene_path)


func _on_texture_button_button_down() -> void:
	print("Boton presionado")
	get_tree().change_scene_to_file(scene_path)


func _on_texture_button_pressed() -> void:
	print("Boton presionado")
	get_tree().change_scene_to_file(scene_path)
