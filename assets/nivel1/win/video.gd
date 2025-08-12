extends Control

@onready var video_player = $VideoStreamPlayer
@onready var label_ganaste = $Win
@onready var button_inicio = $Button

func _ready():
	label_ganaste.visible = false
	button_inicio.visible = false
	video_player.play()
	video_player.connect("finished", Callable(self, "_on_video_finished"))

func _on_video_stream_player_finished() -> void: 
	label_ganaste.visible = true
	start_blinking()
	
func start_blinking():
	var blink_timer = Timer.new()
	blink_timer.wait_time = 0.5
	blink_timer.one_shot = false
	add_child(blink_timer)
	blink_timer.start()
	blink_timer.connect("timeout", Callable(self, "_on_blink_timeout"))

	await get_tree().create_timer(5.0).timeout
	blink_timer.stop()
	label_ganaste.visible = true
	button_inicio.visible = true

func _on_blink_timeout():
	label_ganaste.visible = not label_ganaste.visible

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Menu/menu.tscn")
