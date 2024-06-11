extends Sprite2D
class_name item_class

var type = "recycle"
var direction: int

# choosing a random item from list of all items, the number of total items, item+bin dict
# i need to return the name of the item, not png
func random_item(selection_list, selection_num, dict):
	var random_tex = selection_list[randi() % selection_num]
	# changing sprite to the random sprite selected
	var texture = random_tex
	var attribute = dict[random_tex]
	#returns item texture, associated bin
	return[texture, attribute]
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
