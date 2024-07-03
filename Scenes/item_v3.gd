class_name ItemClass
extends Sprite2D

var bin: String
var direction: int
var interacted: bool

# choosing a random item from list of all items, the number of total items, item+bin dict
# i need to return the name of the item, not png
func random_item(selection_list, selection_num, dict):
	var random_tex = selection_list[randi() % selection_num]
	# changing sprite to the random sprite selected
	var tex = random_tex
	var attribute = dict[random_tex]
	#returns item texture, associated bin
	return[tex, attribute]
