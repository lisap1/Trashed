extends Node2D
const FRONT_ORDER = -3
var exited = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# player is moved to the front of object hierarchy when not behind an object
	if exited == true:
		move_child($Player, FRONT_ORDER)

	
# object moved in front of player when player enters area
func _on_conveyor_left_area_body_entered(_body):
	move_child($Conveyor, FRONT_ORDER)
	exited = false


func _on_conveyor_right_area_body_entered(_body):
	move_child($ConveyorRight, FRONT_ORDER)
	exited = false


# when player exits area 2d, player is returned to front 	
func _on_conveyor_left_area_body_exited(_body):
	exited = true


func _on_conveyor_right_area_body_exited(_body):
	exited = true
