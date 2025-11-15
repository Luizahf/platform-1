extends Node2D

var player: Player

func _ready() -> void:
	player.position = $PlayerStartPosition.position
	
	
