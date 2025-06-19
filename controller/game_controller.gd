class_name GameController
extends Node2D

var vidas = 3

func _on_personaje_player_hit() -> void:
	vidas = vidas - 1
	if vidas <= 0:
		print("Has perdido")
		var scene_finish_instance = preload("res://ui/scene_finish.tscn").instantiate()
		scene_finish_instance.set_title("HAS PERDIDO")
		add_child(scene_finish_instance)
		get_tree().paused = true


func _on_personaje_player_hp_up() -> void:
	if vidas < 3:
		vidas = vidas + 1
