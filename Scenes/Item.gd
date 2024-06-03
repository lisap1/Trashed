extends Node2D
var speed = 10
signal speed_pos
# setting sprites for items
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
var plastic_bottle = "res://Final Assets/items/plastic_bottle_item.png"
var plastic_bag = "res://Final Assets/items/plastic bag_item.png"
var doggy_bag = "res://Final Assets/items/poo_bag_item.png"
var styrofoam = "res://Final Assets/items/styrofoam_item.png"
var tissues = "res://Final Assets/items/tissues_item.png"
const NUM_ITEMS = 15

# associating items with correct bin
var item_bin_dict = {
	apple : "green",
	bread : "green",
	cheese : "green",
	chicken : "green",
	fish : "green",
	can : "blue",
	glass_bottle : "blue",
	paper : "blue",
	cardboard : "blue",
	plastic_bottle : "blue",
	plastic_bag : "red",
	doggy_bag : "red",
	styrofoam : "red",
	tissues : "red",
	broken_glass : "red",
}
# list of items to generate random item
var all_items = [apple, bread, cheese, chicken, fish, can, glass_bottle, paper, cardboard, 
plastic_bottle, plastic_bag, doggy_bag, styrofoam, tissues, broken_glass]


func _ready():
	#print(speed)
	set_process_input(true)
	#getting random item
	var random_tex = all_items[randi() % NUM_ITEMS]
	# for testing purposes, print item and bin
	print(random_tex)
	print(item_bin_dict[random_tex])
	# changing sprite to the random sprite selected
	var item_tex = load(random_tex)
	$ItemSprite.texture = item_tex
	# checking that the item variables can be found in the dictionary
	if item_bin_dict[random_tex] == "green":
		print('yippee')
	
	speed_pos.emit()
	

func _process(delta):
	# movement
	#position.x += speed * delta
	pass
	
		

