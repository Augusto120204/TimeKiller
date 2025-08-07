extends Control

@onready var brightness_overlay := $ColorRect
@onready var brightness_slider := $ColorRect/TabContainer/Video/MarginContainer/VideoSettings/BrigthnessContainer/SliderBrightness


func _ready():
	_update_brightness(brightness_slider.value)
	
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


func _on_HSlider_value_changed(value: float) -> void:
	_update_brightness(value)

func _update_brightness(value: float) -> void:
	# Invertimos el valor para que al subir el slider haya MENOS opacidad (más luz)
	var inverted = 1.0 - value
	brightness_overlay.color.a = inverted


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Menu/menu.tscn")
