extends Area2D

func _on_body_entered(body)  -> void:
	if body.name == "Player":
		body.die()
