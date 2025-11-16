class_name GameState
extends Node

var is_dead: bool = false
var is_paused: bool = false
var is_loading_new_map: bool = false
var current_level: int = 1
var player: Player
var current_level_scene: PackedScene
var current_level_instance: Node = null   # <--- ADICIONADO

func start():
	_load_level()
	player.connect("died", Callable(self, "_on_player_died"))
	player.connect("win", Callable(self, "_on_player_win"))

func set_paused():
	is_paused = !is_paused

func _on_player_died():
	is_dead = true

func _on_player_win():
	current_level += 1
	if !is_loading_new_map:
		is_loading_new_map = true
		_load_level()

func _load_level() -> void:
	# REMOVER MAPA ATUAL SE EXISTIR
	if current_level_instance:
		remove_child(current_level_instance)
		current_level_instance.queue_free()
		current_level_instance = null

	# CARREGAR NOVO NIVEL
	var level_path = "res://scenes/maps/level_" + str(current_level) + ".tscn"
	current_level_scene = load(level_path)
	current_level_instance = current_level_scene.instantiate()

	# Passar o Player ao mapa
	current_level_instance.player = player

	# Adicionar o mapa como filho
	add_child(current_level_instance)

	# Pode carregar próximo novamente
	is_loading_new_map = false
