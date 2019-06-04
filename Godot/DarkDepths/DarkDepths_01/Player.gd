extends KinematicBody2D

const UP = Vector2(0, -1)
const SLOPE_STOP = 64

var velocity = Vector2()
var move_speed = 5 * 96
var gravity = 1200
var jump_velocity = -600
var is_grounded
var is_jumping = false

onready var raycasts = $RayCasts

func _physics_process(delta):
	_get_input()
	
	if is_jumping && velocity.y >= 0:
		is_jumping = false
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, UP, SLOPE_STOP) #kinematic動かすのになんかこれ必要
	
	is_grounded = _check_is_grounded()
	
	_assign_animation()
	
func _input(event):
	if event.is_action_pressed("jump") && is_grounded:
		velocity.y = jump_velocity
		print(event.as_text())
	
func _get_input():
	var move_direction = -int(Input.is_action_pressed("move_left")) + int(Input.is_action_pressed("move_right"))
	velocity.x = lerp(velocity.x, move_speed * move_direction, _get_h_weight())
	if move_direction != 0:
		$Body.scale.x = move_direction
		
func _get_h_weight():
	return 0.2 if is_grounded else 0.1
	
func _check_is_grounded():
	for raycast in raycasts.get_children():
		if raycast.is_colliding():
			return true
	#もしレイキャストになにも反応がなかったらfalse
	return false
	

func _assign_animation():
	var anim = "idle"

	if !is_grounded:
		anim = "jump"
	elif velocity.x != 0:
		anim = "run"

	$Body/AnimatedSprite.play(anim)
	
	