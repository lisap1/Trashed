extends Node2D
class_name item 

var item_type: String
var bin: String
var direction_left: bool
@onready var texture = $ItemSprite


	
func random_item(selection_list, selection_num, dict):
	var random_tex = selection_list[randi() % selection_num]
	# changing sprite to the random sprite selected
	var texture = random_tex
	var attribute = dict[random_tex]
	return[texture, attribute]

# Called when the node enters the scene tree for the first time.
func _ready():
	$ItemSprite.texture = load("res://Final Assets/trash_pile.png")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
		
