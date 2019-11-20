extends KinematicBody2D

var vel = Vector2(-30, 10)
var step = 30
var gravity = 10

func _physics_process(delta):
	
	if not is_on_floor():
		vel.y += gravity
	elif vel.y > 0 and not $Sprite.is_flipped_h():
		$Sprite.set_flip_h(true)
		vel.x = step
	elif vel.y > 0 and $Sprite.is_flipped_h():
		$Sprite.set_flip_h(false)
		vel.x = -step
		
	vel = move_and_slide(vel, Vector2(0,-1))
