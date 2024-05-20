extends Node2D
const front_order = -1
var exited = false
var item_scene_resource = preload("res://Scenes/item.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var item_scene = item_scene_resource.instantiate()
	add_child(item_scene)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# player is moved to the front of object hierarchy when not behind an object
	if exited == true:
		move_child($Player, front_order)
		
# object moved in front of player when player enters area
func _on_conveyor_left_area_body_entered(_body):
	move_child($Conveyor, front_order)
	exited = false
	
func _on_conveyor_right_area_body_entered(_body):
	move_child($ConveyorRight, front_order)
	exited = false

# when player exits area 2d, player is returned to front 	
func _on_conveyor_left_area_body_exited(_body):
	exited = true

func _on_conveyor_right_area_body_exited(_body):
	exited = true
	
	
	
