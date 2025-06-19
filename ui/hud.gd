class_name Hud
extends CanvasLayer

@onready var vidas = [
	$Node2D/Hp1,
	$Node2D/Hp2,
	$Node2D/Hp3,
]

var vidas_jugador := 3
const VIDA_MAXIMA := 3
const FRAME_LLENO := Vector2(1, 1)
const FRAME_VACIO := Vector2(4, 1)

func _on_personaje_player_hit() -> void:
	if vidas_jugador > 0:
		vidas_jugador -= 1
		actualizar_vidas()


func _on_personaje_player_hp_up() -> void:
	if vidas_jugador < VIDA_MAXIMA:
		vidas_jugador += 1
		actualizar_vidas()

func actualizar_vidas() -> void:
	for i in range(3):
		if i < vidas_jugador:
			vidas[i].frame_coords = FRAME_LLENO
		else:
			vidas[i].frame_coords = FRAME_VACIO
