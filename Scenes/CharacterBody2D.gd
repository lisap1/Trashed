extends CharacterBody2D

const SPEED = 15000
var input = Vector2.ZERO
@onready var anim = get_node("Player Sprite")

# getting direction from user input
func movement_input():
	input.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	input.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	return input.normalized()

	
func _process(delta):
	# player speed and movement
	input = movement_input()
	velocity = input * SPEED * delta
	move_and_slide()
	# play animations according to direction
	if input == Vector2.ZERO:
		anim.stop()
	elif input == Vector2(0, 1):
		anim.play("down")
	elif input == Vector2(1, 0):
		anim.play("right")
	elif input == Vector2(-1, 0):
		anim.play("left")
	elif input == Vector2(0, -1):
		anim.play("up")
	elif input.x < 0 and input.y < 0:
		anim.play("up left")
	elif input.x < 0 and input.y > 0:
		anim.play("down left")
	elif input.x > 0 and input.y < 0:
		anim.play("up right")
	elif input.x > 0 and input.y > 0:
		anim.play("down right")
	
		
