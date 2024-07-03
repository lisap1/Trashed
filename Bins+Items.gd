extends Node2D

var speed: int = 20
# item textures, associated bins, list of all items
var apple = "res://Final Assets/items/apple_item.png"
var bread = "res://Final Assets/items/bread_item.png"
var item_bin_dict = {
	apple : "green",
	bread : "green",
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
	var item_spawn = item_class.new()	
	var rand_item = item_spawn.random_item(all_items, NUM_ITEMS, item_bin_dict)
	#change sprite texture
	item_spawn.texture = load(rand_item[0])
	#create area 2d
	var item_area = Area2D.new()
	var item_collision = CollisionShape2D.new()
	var collision_shape = RectangleShape2D.new()
	collision_shape.extents = Vector2(20, 30)
	item_collision.shape = collision_shape
	# setting collision layers and masks
	item_area.set_collision_layer_value(3, true)
	item_area.set_collision_layer_value(1, false)
	item_area.set_collision_mask_value(1, true)
	# choose spawn point
	# maybe the conveyor spawn should just be random? as the player still has to keep up the pace
	var chosen_spawn_point = choose_conveyor($"../SpawnPosRight", 
			$"../SpawnPosLeft", left_con_list, right_con_list)
	if chosen_spawn_point == $"../SpawnPosRight":
		right_con_list.append("item")
		item_spawn.direction = -1
	elif chosen_spawn_point == $"../SpawnPosLeft":
		left_con_list.append("item")
		item_spawn.direction = 1
	# setting item position at selected conveyor
	item_spawn.position = chosen_spawn_point.position
	# adding item to main scene
	$"../Items".add_child(item_spawn)
	# adding area2d as children of item
	item_spawn.add_child(item_area)
	item_area.add_child(item_collision)
	# when player enters item area: 
	item_area.body_entered.connect(func(body): test_func(body, item_spawn, item_area))
	#item_area.body_entered.connect(test_func)

#func _input(event):
	#if event.is_action_pressed("primary action"):
		#if area.get_overlapping_bodies().size == 1:
			#print("item selected")
	
func test_func(body, item_spawn, item_area):
	print(item_area.get_overlapping_bodies().size())
	item_spawn.position = $"../Player".position
		
	#item_spawn.queue_free()
	#print("yippee")

func _process(delta):
	# movement for items
	if $"../Items" != null and $"../Items".get_children().size() > 0:
		var all_children = $"../Items".get_children()
		for child in all_children:
			if child is item_class:
				child.position.x += speed * delta * child.direction
				
