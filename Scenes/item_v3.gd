class_name ItemClass
extends Sprite2D

var bin: String
#var item_name: String
var item_name: String 
var direction: int
var interacted: bool

# choosing a random item from list of all items, the number of total items, 
# item+bin dict
func random_item(selection_list, selection_num, dict):
	var random_index = randi() % selection_num
	var random_tex = selection_list[random_index]
	# changing sprite to the random sprite selected
	var tex = random_tex
	var attribute = dict[random_tex]
	#returns item texture, associated bin
	return[tex, attribute, random_index]
