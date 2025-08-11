extends CanvasLayer

@onready var brightness_overlay := $ColorRect


signal back_pressed  # Declaramos una señal

func _on_h_slider_value_changed(value: float) -> void:
	var db_value: float
	if value <= 50:
		db_value = lerp(-80.0, 0.0, value / 50.0)
	else:
		db_value = lerp(0.0, 6.0, (value - 50.0) / 50.0)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("musicaFondo"), db_value)

func _on_option_button_item_selected(index: int) -> void:
	if index == 0:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func _on_back_pressed() -> void:
	emit_signal("back_pressed")  # Emitimos la señal en vez de cambiar escena
