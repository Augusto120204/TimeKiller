extends Node2D

var sonidoFondo = preload("res://assets/music/desierto.mp3")
var escena_path := "res://niveles/nivel_2_1.tscn"

func _ready() -> void:
	BocinaPrincipal.stream = sonidoFondo
	BocinaPrincipal.play()
	GameState.nivel_actual = escena_path
