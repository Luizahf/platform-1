extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var attack = $SwordAttack

func _ready():
	if attack.has_method("_on_atack"):
		attack._on_atack()
	move_and_slide()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
