extends CharacterBody2D


var SPEED = 120.0
const JUMP_VELOCITY = -400.0

@onready var attack = $SwordAttack
@onready var sprite = $Sprite2D
@export var player: CharacterBody2D = null
var hands_distance : int = 30

func _ready():
	if attack.has_method("_on_atack"):
		attack._on_atack()

func _physics_process(delta: float) -> void:
	if player != null:
		if is_instance_valid(player):
			var _dist := player.global_position - global_position
			var distance := _dist.length()
			var width = ($Sprite2D.texture.get_size().x * abs($Sprite2D.scale.x)) + 10

			if distance > width:
				global_position += _dist.normalized() * delta * SPEED
				if player.global_position.x > global_position.x:
					scale.x = 1
				else:
					scale.x = -1
	set_hands()
	
func set_hands() -> void:
	var bodyPos = position
	
	$LeftHand.position = Vector2(bodyPos.x + hands_distance, bodyPos.y)
	$RightHand.position = Vector2(bodyPos.x - hands_distance, bodyPos.y)
	
	if scale.x > 0:
		$LeftHand.position = $RightHand.position
	elif scale.x < 0:
		$RightHand.position = $LeftHand.position

#func take_hit(damage: int):
#	queue_free()

func _on_sword_attack_hit(body: Variant) -> void:
	pass # Replace with function body.


func _on_attack_timer_timeout() -> void:
	if attack.has_method("_on_atack"):
		attack._on_atack()
