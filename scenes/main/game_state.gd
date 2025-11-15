class_name GameState
extends Node

var is_dead: bool = false
var is_paused: bool = false
var current_level: int = 1

func _ready():
	var player = get_node("/root/Main/Player")
	player.connect("died", Callable(self, "_on_player_died"))

func set_paused():
	is_paused = !is_paused
	
func _on_player_died():
	is_dead = true
