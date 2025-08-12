class_name GameController
extends Node2D

# Vida máxima constante para evitar hardcodear 3 en varios lados
const VIDA_MAXIMA := 3

func _ready():
	# Reiniciamos el estado global al comenzar la escena
	GameState.vidas = VIDA_MAXIMA
	GameState.esta_muerto = false

	# Intentamos obtener el nodo Personaje (con búsqueda recursiva por seguridad)
	var personaje = get_parent().get_node_or_null("Personaje")
	if personaje == null:
		personaje = get_tree().get_root().find_child("Personaje", true, false)

	if personaje:
		personaje.connect("player_hit", Callable(self, "_on_personaje_player_hit"))
		personaje.connect("player_hp_up", Callable(self, "_on_personaje_player_hp_up"))
	else:
		print("No se encontró el nodo Personaje para conectar señales")

func _on_personaje_player_hit() -> void:
	if GameState.esta_muerto:
		return

	GameState.vidas -= 1
	if GameState.vidas < 0:
		GameState.vidas = 0

	print("Vidas restantes: ", GameState.vidas)

	if GameState.vidas == 0:
		GameState.esta_muerto = true
		print("Has perdido")
		var scene_finish_instance = preload("res://ui/scene_finish.tscn").instantiate()
		scene_finish_instance.set_title("HAS PERDIDO")
		add_child(scene_finish_instance)
		get_tree().paused = true

func _on_personaje_player_hp_up() -> void:
	if GameState.vidas < VIDA_MAXIMA:
		GameState.vidas += 1
		print("Vida aumentada: ", GameState.vidas)
