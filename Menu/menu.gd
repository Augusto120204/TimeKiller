extends CanvasLayer


func _on_jugar_pressed() -> void:
	get_tree().change_scene_to_file("res://Menu/SeleccionarNivel.tscn")
	


func _on_salir_pressed() -> void:
	get_tree().quit()


func _on_configuraciones_pressed() -> void:
	get_tree().change_scene_to_file("res://Menu/settings_menu.tscn")

var sonidoFondo = preload("res://assets/music/sb_indreams(chosic.com).mp3")

func _ready():
		BocinaPrincipal.stream = preload("res://assets/music/sb_indreams(chosic.com).mp3")
		BocinaPrincipal.play()


func _on_creditos_pressed() -> void:
	get_tree().change_scene_to_file("res://Menu/creditos.tscn")
