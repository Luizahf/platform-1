extends CharacterBody2D


var SPEED = 100.0
const JUMP_VELOCITY = -400.0

@onready var sword = $SwordAttack
@onready var sprite = $Sprite2D
@export var player: CharacterBody2D = null
var hands_distance : int = 30
@onready var floor_check: RayCast2D = $FloorDetector

func _ready():	
	$SwordAttack/Area2D.set_collision_mask_value(6, false)

func _physics_process(delta: float) -> void:
	if player != null:
		if is_instance_valid(player):
			var _dist := player.global_position - global_position
			var width = ($Sprite2D.texture.get_size().x * abs($Sprite2D.scale.x)) + 10

			if _dist.length() > width:
				if floor_check.is_colliding() && _dist.length() < 110:
					move(_dist, delta)
			else:
				attack()

func move(_dist: Vector2, delta: float):
	var dir_x := Vector2(_dist.x, 0).normalized()
	global_position += dir_x * SPEED * delta
	if player.global_position.x > global_position.x:
		$Sprite2D.scale.x = 1
	else:
		$Sprite2D.scale.x = -1
	set_hands(_dist.x)
		
func set_hands(dist_x: int) -> void:
	var bodyPos = $Sprite2D.position
	
	$LeftHand.position = Vector2(bodyPos.x + hands_distance, bodyPos.y)
	$RightHand.position = Vector2(bodyPos.x - hands_distance, bodyPos.y)
	
	if dist_x < 0:
		floor_check.position = $RightHand.position
		$LeftHand.position = $RightHand.position
		$SwordAttack.position = $RightHand.position
	elif dist_x > 0:
		floor_check.position = $LeftHand.position
		$RightHand.position = $LeftHand.position
		$SwordAttack.position = $LeftHand.position
 
func attack():
	if sword.has_method("_on_atack"):
		sword._on_atack($Sprite2D.scale.x)
		
func take_hit(damage: int):
	queue_free()
