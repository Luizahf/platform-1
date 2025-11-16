extends Node2D

var enemy = preload("res://scenes/characters/enemies/melee/green/enemy_melee_green.tscn")

func _ready():
	create_enemy($Enemy1)
	create_enemy($Enemy2)
	
func create_enemy(place: Marker2D):
	var enemy_inst = enemy.instantiate()
	enemy_inst.player = $"../Player"
	add_child(enemy_inst)
	enemy_inst.global_position = place.global_position
	
