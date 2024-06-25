extends Node2D

var speed: int = 20
# whether player is in an item area
var body_in_area: bool = false
# item areas that player is currently in
var bodies_cur_entered = []
# if player is currently holding an item
var item_held = false
# if player is in a bin area
var in_bin_area = false
var bin = ''
# item textures, associated bins, list of all items
var apple = "res://Final Assets/items/apple_item.png"
var bread = "res://Final Assets/items/bread_item.png"
var broken_glass = "res://Final Assets/items/broken_glass_item.png"
var can = "res://Final Assets/items/can_item.png"
var cardboard = "res://Final Assets/items/cardboard_item.png"
var cheese = "res://Final Assets/items/cheese_item.png"
var chicken = "res://Final Assets/items/chicken_item.png"
var fish = "res://Final Assets/items/fish_item.png"
var glass_bottle = "res://Final Assets/items/glass_bottle_item.png"
var paper = "res://Final Assets/items/paper_item.png"
var plastic_bag = "res://Final Assets/items/plastic bag_item.png"
var plastic_bottle = "res://Final Assets/items/plastic_bottle_item.png"
var doggy_bag = "res://Final Assets/items/poo_bag_item.png"
var styrofoam = "res://Final Assets/items/styrofoam_item.png"
var tissues = "res://Final Assets/items/tissues_item.png"

var item_bin_dict = {
	apple : "green",
	bread : "green",
	cheese : "green",
	chicken : "green",
	fish : "green",
	can : "blue",
	cardboard : "blue",
	paper : "blue",
	glass_bottle : "blue",
	plastic_bottle : "blue",
	broken_glass : "red",
	plastic_bag : "red",
	doggy_bag : "red",
	styrofoam : "red",
	tissues : "red",
	}

var all_items = [apple, bread, broken_glass, can, cardboard, cheese,
		chicken, fish, glass_bottle, paper, plastic_bag, plastic_bottle, 
		doggy_bag, styrofoam, tissues]
const NUM_ITEMS = 15
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
	# establish the bin that the item belongs to
	item_spawn.bin = rand_item[1]
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
	# maybe the conveyor spawn should just be random?
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
	# connecting signals for when player enters and exits item area
	# when player enters/exits body, function is called
	item_area.body_entered.connect(func(_body): area_entered(item_spawn))
	item_area.body_exited.connect(func(_body): area_exited(item_spawn))
	
	
func area_entered(item_spawn):
	# storing that player is in an item_area, which area
	body_in_area = true
	bodies_cur_entered.append(item_spawn)


func area_exited(item_spawm):
	# removes data of area player was in
	body_in_area = false
	bodies_cur_entered.erase(item_spawm)
	
	
func _input(event):
	var all_children = $"../Items".get_children()
	# when space bar is pressed: check if player is able to interact with item
	if event.is_action_pressed("primary action"):
		if body_in_area == true and item_held == false:

			# checking all items in the scene
			for child in all_children:
				# if the player is in the items area, change its speed to 0
				if child == bodies_cur_entered[0]:
					child.direction = 0
					# the item is currently being held by the player
					child.interacted = true
					# removing the area2d from the item, 
					# it can't interact with anything
					var child_area = child.get_children()
					child_area[0].queue_free()
					item_held = true
		# if player is in a bin area and they are hoding an item
		if in_bin_area == true and item_held == true:
			# for all items in the scene, check if its being held by the player
			for child in all_children:
				if child.interacted == true:
					# checks if item was sorted into the correct bin
					if child.bin == bin:
						print("correct")
					else: 
						# if incorrect adds a strike
						GlobalVars.strikes += 1
						print("Strikes: ", GlobalVars.strikes)
					# after sorting, item is removed from the scene
					child.queue_free()
					item_held = false


func _process(delta):
	# movement for items
	if $"../Items" != null and $"../Items".get_children().size() > 0:
		var all_children = $"../Items".get_children()
		for child in all_children:
			# preventing errors by making sure it only affects items
			if child is item_class:
				# speed, position of items
				child.position.x += speed * delta * child.direction
				# if item is being held by player, move to be above the player
				if child.interacted == true:
					child.position = GlobalVars.player_pos
	if GlobalVars.strikes == 3:
		GlobalVars.strikes = 0
		get_tree().change_scene_to_file("res://Scenes/game_over_screen.tscn")
	
# these functions are called when player enters/exits a bin area
# states if player is in an area or not, and the type of bin they approached
func _on_green_bin_area_body_entered(_body):
	in_bin_area = true
	bin = 'green'


func _on_green_bin_area_body_exited(_body):
	in_bin_area = false


func _on_blue_bin_area_body_entered(_body):
	in_bin_area = true
	bin = 'blue'


func _on_blue_bin_area_body_exited(_body):
	in_bin_area = false
	
	
func _on_red_bin_area_body_entered(_body):
	in_bin_area = true
	bin = 'red'

func _on_red_bin_area_body_exited(_body):
	in_bin_area = false

# when item reaches the end of the conveyor, a strike is added
# item gets removed
func _on_conveyor_end_area_entered(area):
	GlobalVars.strikes += 1
	print("Strikes: ", GlobalVars.strikes)
	var parent = area.get_parent()
	parent.queue_free()
