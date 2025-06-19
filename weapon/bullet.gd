class_name Bullet
extends Area2D

@export var speed: float = 300
var direction: Vector2 = Vector2.ZERO
var margin: Vector4 = Vector4.ZERO

func _process(delta: float) -> void:
	if direction != Vector2.ZERO:
		position += direction.normalized() * speed * delta
		$Bullet.rotation = direction.angle()
		
	# Comprobar si está fuera del margen
	if position.x < margin.x or position.x > margin.z or position.y < margin.y or position.y > margin.w:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("hp_down"):
		body.hp_down()
		queue_free()
