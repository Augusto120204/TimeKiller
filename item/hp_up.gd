class_name HpUp
extends RigidBody2D

@export var texture_path:String

func _physics_process(delta: float) -> void:
	if (!texture_path):
		texture_path = "res://assets/items/healt/86_roastedchicken_dish.png"
	var texture = load(texture_path)  # Carga la textura desde la ruta
	if texture:
		$Item.texture = texture

func _on_body_entered(body: Node) -> void:
	if body is Personaje:
		if body.has_method("hp_up"):
			body.hp_up()
			queue_free()
