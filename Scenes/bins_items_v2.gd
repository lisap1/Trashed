extends Node2D

signal strike_added
signal correct_sort

const TOTAL_ITEMS = 15
# item textures
const APPLE = "res://Final Assets/items/apple_item.png"
const BREAD = "res://Final Assets/items/bread_item.png"
const BROKEN_GLASS = "res://Final Assets/items/broken_glass_item.png"
const CAN = "res://Final Assets/items/can_item.png"
const CARDBOARD = "res://Final Assets/items/cardboard_item.png"
const CHEESE = "res://Final Assets/items/cheese_item.png"
const CHICKEN= "res://Final Assets/items/chicken_item.png"
const FISH = "res://Final Assets/items/fish_item.png"
const GLASS_BOTTLE = "res://Final Assets/items/glass_bottle_item.png"
const PAPER = "res://Final Assets/items/paper_item.png"
const PLASTIC_BAG = "res://Final Assets/items/plastic bag_item.png"
const PLASTIC_BOTTLE = "res://Final Assets/items/plastic_bottle_item.png"
const DOGGY_BAG = "res://Final Assets/items/poo_bag_item.png"
const STYROFOAM = "res://Final Assets/items/styrofoam_item.png"
const TISSUES = "res://Final Assets/items/tissues_item.png"

# game variables
var speed: int = 10
var practice_time = 6
var max_time = 1.8
var player_in_item_area: bool = false
var item_bodies_currently_entered = []
var item_held = false
var player_in_bin_area = false
var bin = ''
var items_sorted: int = 0
var strike_limit: int = 3

# conveyor variables
var right_con_list = []
var left_con_list = []
var selected_conveyor = ''

var item_bin_dict = {
	APPLE : "food scraps",
	BREAD : "food scraps",
	CHEESE : "food scraps",
	CHICKEN: "food scraps",
	FISH : "food scraps",
	CAN : "recycling",
	CARDBOARD : "recycling",
	PAPER : "recycling",
	GLASS_BOTTLE : "recycling",
	PLASTIC_BOTTLE : "recycling",
	BROKEN_GLASS : "general waste",
	PLASTIC_BAG : "general waste",
	DOGGY_BAG : "general waste",
	STYROFOAM : "general waste",
	TISSUES : "general waste",
	}

var all_items = [APPLE, BREAD, BROKEN_GLASS, CAN, CARDBOARD, CHEESE,
		CHICKEN, FISH, GLASS_BOTTLE, PAPER, PLASTIC_BAG, PLASTIC_BOTTLE, 
		DOGGY_BAG, STYROFOAM, TISSUES]
		
var item_names = ["apple", "bread", "broken glass", "can", "cardboard", 
		"cheese", "chicken", "fish", "glass bottle", "paper", "plastic bag",
		"plastic bottle", "dog poo bag", "styrofoam", "used tissues"]
		
	
# show instructions when player is in practice mode 
func _ready():
	if GlobalVars.practice_mode_on == true:
		$"../UI/Instructions".show()
	else:
		$"../UI/Instructions".hide()


func _input(event):
	var all_children = $"../Items".get_children()
	# when space bar is pressed: check if player is able to 
	# interact with item
	if event.is_action_pressed("primary action"):
		if player_in_item_area == true and item_held == false:

			# checking all items
			for child in all_children:
				# if the player is in an items area, 
				# change its speed to 0
				if child == item_bodies_currently_entered[0]:
					child.direction = 0
					# change interactability
					child.interacted = true
					# removing the area2d from the item
					var child_area = check_children_type(child, Area2D)
					child_area.queue_free()
					item_held = true
					
		#  sorting attempt by player
		if player_in_bin_area == true and item_held == true:
			for child in all_children:
				if child.interacted == true:
					items_sorted += 1
					# checks if item was sorted into the correct bin
					if child.bin == bin:
						correct_sort.emit(bin)
					else: 
						# if incorrect adds a strike
						add_strike()
					# after sorting, item is removed from the scene
					child.queue_free()
					item_held = false
	
	# when player presses shift in practice mode, while holding an item,
	# show the items label
	if event.is_action_pressed("shift"):
		var child_label = get_active_label()
		if child_label != null:
			child_label.show()
	# when player releases shift hide the items label
	if event.is_action_released("shift"):
		var child_label = get_active_label()
		if child_label != null:
			child_label.hide()


func _process(delta):	
	# movement for items
	if $"../Items" != null and $"../Items".get_children().size() > 0:
		var all_children = $"../Items".get_children()
		for child in all_children:
			# preventing errors by making sure it only affects items
			if child is ItemClass:
				child.position.x += speed * delta * child.direction
				# move item above the player
				if child.interacted == true:
					child.position = GlobalVars.player_pos		
					
	# change to game over screen when strikes = 3
	if GlobalVars.strikes >= strike_limit:
		GlobalVars.strikes = 0
		get_tree().change_scene_to_file("res://Scenes/game_over_screen.tscn")
		
	# conveyor speed 
	var progressing_time = -0.04 * items_sorted + 4.2
	if GlobalVars.practice_mode_on == true:
		$ItemSpawnTimer.set_wait_time(practice_time) 
	elif items_sorted < 60:
		$ItemSpawnTimer.set_wait_time(progressing_time) 
	else:
		$ItemSpawnTimer.set_wait_time(max_time) 


# check an objects type 
func check_children_type(parent, type): 
	for child in parent.get_children():
		if is_instance_of(child, type):
			return child


# Get the item which is being interacted with, to display label
func get_active_label():
	if GlobalVars.practice_mode_on == true and item_held == true:
			for child in $"../Items".get_children():
				if child.interacted == true:
					# make the label visible
					var child_label = check_children_type(child, Label)
					return child_label
	else:
		return null

# chooses conveyor
func choose_conveyor(right_conveyor, left_conveyor, left_list, right_list):
	var conveyors = [right_conveyor, left_conveyor]
	# choosing conveyor with least amount of total items
	if right_list.size() > left_list.size():
		selected_conveyor = left_conveyor
	elif right_con_list.size() < left_con_list.size():
		selected_conveyor = right_conveyor
	else:
		selected_conveyor = conveyors[randi() % 2]
	return selected_conveyor	


func add_strike():
	GlobalVars.strikes += 1
	strike_added.emit()
		
		
# when player enters an item area
func area_entered(item_spawn):
	player_in_item_area = true
	item_bodies_currently_entered.append(item_spawn)


# when player exits an item area
func area_exited(item_spawm):
	# removes data of area player was in
	player_in_item_area = false
	item_bodies_currently_entered.erase(item_spawm)


# these functions are called when player enters/exits a bin area
# states if player is in an area or not, and the type of bin they approached
func _on_green_bin_area_body_entered(_body):
	player_in_bin_area = true
	bin = "food scraps"


func _on_green_bin_area_body_exited(_body):
	player_in_bin_area = false


func _on_blue_bin_area_body_entered(_body):
	player_in_bin_area = true
	bin = "recycling"


func _on_blue_bin_area_body_exited(_body):
	player_in_bin_area = false
	
	
func _on_red_bin_area_body_entered(_body):
	player_in_bin_area = true
	bin = "general waste"


func _on_red_bin_area_body_exited(_body):
	player_in_bin_area = false


# when item reaches the end of the conveyor, a strike is added
# item gets removed
func _on_conveyor_end_area_entered(area):
	add_strike()
	var parent = area.get_parent()
	parent.queue_free()


func _on_item_spawn_timer_timeout():
	print($ItemSpawnTimer.wait_time)
	# choose random item
	var item_spawn = ItemClass.new()	
	var rand_item = item_spawn.random_item(all_items, TOTAL_ITEMS, 
			item_bin_dict)
	# establish the bin that the item belongs to
	item_spawn.bin = rand_item[1]
	item_spawn.item_name = item_names[rand_item[2]]
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
	
	# creating a label to display item name and bin type for practice mode 
	if GlobalVars.practice_mode_on == true:
		var bin_label = Label.new()
		bin_label.set("theme_override_fonts/font", 
				load("res://PixelifySans-VariableFont_wght.ttf"))
		bin_label.set("theme_override_font_sizes/font_size", 9)
		bin_label.set("theme_override_colors/font_color", "526cff")
		bin_label.position = Vector2(15, -10)
		bin_label.text = item_spawn.item_name + "\n" + item_spawn.bin
		item_spawn.add_child(bin_label)
		bin_label.hide()

	# choose spawn point
	var chosen_spawn_point = choose_conveyor($"../SpawnPosRight", 
			$"../SpawnPosLeft", left_con_list, right_con_list)
	# setting direction based on which spawn point is chosen
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
	item_area.body_entered.connect(func(_body): area_entered(item_spawn))
	item_area.body_exited.connect(func(_body): area_exited(item_spawn))
