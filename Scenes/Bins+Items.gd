extends Node2D
#@onready var red = $RedBin
#@onready var blue = $BlueBin
#@onready var green = %GreenBin
#var green = {
		#"name" : %GreenBin.get_node,
		#"apple" : "hello",
	#}
#
# Called when the node enters the scene tree for the first time.
#func _ready():
	#print(green["name"])
	#var item_correct_bin = [
	#{"name" : "apple", "bin": %GreenBin},
	#{"name" : "cheese", "bin": %GreenBin},
	#{"name" : "fish", "bin": %GreenBin},
	#{"name" : "chicken", "bin": %GreenBin},
	#{"name" : "bread", "bin": %GreenBin},
	#{"name" : "plastic bottle", "bin": "blue"},
	#{"name" : "cardboard", "bin": "blue"},
	#{"name" : "paper", "bin": "blue"},
	#{"name" : "can", "bin": "blue"},
	#{"name" : "glass", "bin": "blue"},
	#{"name" : "broken glass", "bin": "red"},
	#{"name" : "poo bag", "bin": "red"},
	#{"name" : "tissue", "bin": "red"},
	#{"name" : "styrofoam", "bin": "red"},
	#{"name" : "plastic bag", "bin": "red"},
#]
	#for i in item_correct_bin:
		#print(i["name"], i["bin"])
		##print(get_node("%GreenBin"))
		#print(get_node(i["bin"]))

	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
