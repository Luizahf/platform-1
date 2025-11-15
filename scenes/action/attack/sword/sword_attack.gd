extends Node2D

signal hit(body)
@onready var anim = $AnimationPlayer
@export var damage: int = 1

func _on_atack(direction: float) -> void:
	if direction > 0:
		anim.play("attack")
	elif direction < 0:
		anim.play("attack_left")

func _on_area_2d_body_entered(body: Node2D) -> void:
	emit_signal("hit", body)
	if body is CharacterBody2D and body.has_method("take_hit"):
		body.take_hit(damage)
