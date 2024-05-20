extends Sprite2D

# setting sprites for items
var apple = "res://Final Assets/play_button_pressed.png"
var orange = "res://Final Assets/play_button_unpressed.png"
const NUM_ITEMS = 2
# associating items with correct bin
var dict = {
	apple : "green",
	orange : "blue"
}
# list of items to generate random item
var list = [apple, orange]

func _ready():
	set_process_input(true)
	
# selecting random item from the list and setting texture as the sprite associated
func _on_timer_timeout():
	var char_tex = list[randi() % NUM_ITEMS]
	print(dict[char_tex])
	var text = load(char_tex)
	texture = text
	# checking that the item variables can be found in the dictionary
	if dict[char_tex] == "green":
		print('yippee')
		
