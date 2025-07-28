extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Menu/menu.tscn")


func _on_h_slider_value_changed(value: float) -> void:
	var db_value: float

	if value <= 50:
		db_value = lerp(-80.0, 0.0, value / 50.0)
	else:
		db_value = lerp(0.0, 6.0, (value - 50.0) / 50.0)

	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("musicaFondo"), db_value)


	
func volume(bus_index, value):
	AudioServer.set_bus_volume_db(bus_index, value)


func _on_check_box_toggled(toggled_on: bool) -> void:
	print("Checkbox toggled:", toggled_on)
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
