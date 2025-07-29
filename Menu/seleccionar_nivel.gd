extends Control


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Menu/menu.tscn")


func _on_nivel_1_pressed() -> void:
	get_tree().change_scene_to_file("res://niveles/nivel_1.tscn")
