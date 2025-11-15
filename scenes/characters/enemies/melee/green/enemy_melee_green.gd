extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var attack = $SwordAttack

func _ready():
	if attack.has_method("_on_atack"):
		attack._on_atack()

func _physics_process(delta: float) -> void:
	pass


func _on_sword_attack_hit(body: Variant) -> void:
	pass # Replace with function body.
