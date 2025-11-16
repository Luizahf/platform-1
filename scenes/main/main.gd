extends Node2D

var current_level: int = 1

func _ready() -> void:
	$GameState.player = $Player
	$GameState.start()
