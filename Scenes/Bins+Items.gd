extends Node2D
# call class
# this needs to be in timer function but process function needs access to direction
var test_spawn = test_class.new()
var speed: int = 50
# item textures, associated bins, list of all items
var apple = "res://Final Assets/items/apple_item.png"
var bread = "res://Final Assets/items/bread_item.png"
var item_bin_dict = {
	apple : "green",
	bread : "green"
	}
var all_items = [apple, bread]
const NUM_ITEMS = 2
# conveyor lists
var right_con_list = []
var left_con_list = []
var selected_conveyor = ''

func _ready():
	pass

# chooses conveyor from specified conveyors 
func choose_conveyor(right_conveyor, left_conveyor, left_list, right_list):
	var conveyors = [right_conveyor, left_conveyor]
	if right_list.size() > left_list.size():
		selected_conveyor = left_conveyor
	elif right_con_list.size() < left_con_list.size():
		selected_conveyor = right_conveyor
	else:
		selected_conveyor = conveyors[randi() % 2]
	return selected_conveyor	
		
func _on_item_spawn_timer_timeout():
	# choose random item
	var rand_item = test_spawn.random_item(all_items, NUM_ITEMS, item_bin_dict)
	#change sprite texture
	test_spawn.texture = load(rand_item[0])
	# choose spawn point
	var chosen_spawn_point = choose_conveyor($"../SpawnPosRight", 
	$"../SpawnPosLeft", left_con_list, right_con_list)
	if chosen_spawn_point == $"../SpawnPosRight":
		right_con_list.append("item")
		test_spawn.direction = -1
	elif chosen_spawn_point == $"../SpawnPosLeft":
		left_con_list.append("item")
		test_spawn.direction = 1
	test_spawn.position = chosen_spawn_point.position

	$"../Items".add_child(test_spawn)
	
	
func _process(delta):
	# movement for items
	if $"../Items" != null and $"../Items".get_children().size() > 0:
		var all_children = $"../Items".get_children()
		for child in all_children:
			if child is test_class:
				child.position.x += speed * delta * test_spawn.direction
		
