extends CharacterBody2D

@export var hands_distance : int = 30

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var jump_number: int = 0

func _ready() -> void:
	$SwordAttack/Area2D.set_collision_mask_value(1, false)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if is_on_floor():
		jump_number = 0
	else:
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and jump_number < 2:
		jump_number = jump_number + 1
		velocity.y = JUMP_VELOCITY
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	
	if direction != 0:
		$BodySprite.flip_h = direction < 0
		
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	set_hands(direction)
	set_hand_item()
	check_attack(direction)
	
func set_hands(direction : float) -> void:
	var bodyPos = $BodySprite.position
	
	$LeftHand.position = Vector2(bodyPos.x + hands_distance, bodyPos.y)
	$RightHand.position = Vector2(bodyPos.x - hands_distance, bodyPos.y)
	
	if direction > 0:
		$LeftHand.position = $RightHand.position
	elif direction < 0:
		$RightHand.position = $LeftHand.position
		
func set_hand_item():
	$SwordAttack.rotation_degrees = deg_to_rad(45)
	
	if $BodySprite.flip_h:
		$SwordAttack.position = $RightHand.position
	else:
		$SwordAttack.position = $LeftHand.position
		
func check_attack(direction: float) -> void:
	if Input.is_key_pressed(KEY_A):		
		var attack_direction = -1 if $BodySprite.flip_h else 1 
		if direction != 0:
			attack_direction = attack_direction * -1
		
		$SwordAttack._on_atack(attack_direction)
		
func take_hit(damage: int) -> void:
	queue_free()
