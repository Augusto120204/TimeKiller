extends Node2D


var sonidoFondo = preload("res://assets/music/callejon.mp3")

func _ready() -> void:
	BocinaPrincipal.stream = sonidoFondo
	BocinaPrincipal.play()
