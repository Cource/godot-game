extends KinematicBody2D

# Variables
var velocity = Vector2()
var air_friction = 2
var ground_friction = 10
var max_velocity = 200
var step = 20
var gravity = 15
var jump_velocity = -500
var onFloor = false
var time = 0
var moving = false
var health = 1

# Functions
func Friction(type):
	if velocity.x > 0:
		velocity.x -= type
	elif velocity.x < 0:
		velocity.x += type
	
	if velocity.x > min(-ground_friction,-air_friction) and velocity.x < max(ground_friction,air_friction):
		velocity.x = 0

# Main
func _physics_process(delta):
	
	if Input.is_action_pressed('ui_right'):
		if velocity.x < max_velocity:
			velocity.x += step
		$Sprite.set_flip_h(false)
		moving = true
	else:
		moving = false
	
	if Input.is_action_pressed('ui_left'):
		if velocity.x > -max_velocity:
			velocity.x -= step
		$Sprite.set_flip_h(true)
		moving = true
	else:
		moving = false
	
	
	if Input.is_action_pressed('ui_up'):
		if is_on_floor():
			velocity.y = jump_velocity
	
	if not is_on_floor():
		velocity.y += gravity
	
	if not onFloor and not moving:
		Friction(air_friction)
	else:
		Friction(ground_friction)

	# Animation
	if velocity.x > 0 or velocity.x < 0:
		$Sprite.play('walk')
	else:
		$Sprite.play('idle')
	
	if velocity.y < 0:
		$Sprite.play('jump')
	# /Animation
	
	if is_on_floor():
		onFloor = true
		time = 0
	else:
		if time > delta:
			onFloor = false
		time += delta
		if time > 0.4 and velocity.y > 0:
			$Sprite.play('fall')
	
	if health == 1:
		$Camera2D/health.play('1')
	elif health == 0.5:
		$Camera2D/health.play('0.5')
	else:
		$Camera2D/health.play('0')
	
	
	velocity = move_and_slide(velocity, Vector2(0,-1))