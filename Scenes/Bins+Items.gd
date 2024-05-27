extends Node2D
var item_scene_resource = preload("res://Scenes/item.tscn")
var right_con_list = []
var left_con_list = []
var selected_conveyor = ''
var speed = 10
#signal RightSpeed


func _ready():
	pass

func _on_item_spawn_timer_timeout():
	#choose conveyor for item to spawn
	var conveyors = [$"../SpawnPosRight", $"../SpawnPosLeft"]
	if right_con_list.size() > left_con_list.size():
		selected_conveyor = $"../SpawnPosLeft"
	elif right_con_list.size() < left_con_list.size():
		selected_conveyor = $"../SpawnPosRight"
	else:
		selected_conveyor = conveyors[randi() % 2]
	print(selected_conveyor)
	
	# speed and direction of the object
	if selected_conveyor == $"../SpawnPosRight":
		#emit_signal("RightSpeed")
		right_con_list.append("item")
	else:
		left_con_list.append("item")
		
	print(right_con_list, left_con_list)
		
	# spawn an item in the world
	var item_scene = item_scene_resource.instantiate()
	print(item_scene.position, selected_conveyor.position)
	var pos = selected_conveyor.position
	print(pos)
	item_scene.position = pos
	$"../Items".add_child(item_scene)
	
func _process(_delta):
	pass
	

