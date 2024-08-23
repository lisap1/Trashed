extends Control

@onready var w = get_node("W")
@onready var a = get_node("A")
@onready var s = get_node("S")
@onready var d = get_node("D")
@onready var arrow_up = get_node("ArrowUp")
@onready var arrow_left = get_node("ArrowLeft")
@onready var arrow_right = get_node("ArrowRight")
@onready var arrow_down = get_node("ArrowDown")
@onready var space = get_node("Space")
@onready var shift = get_node("Shift")


func _process(_delta):
	if Input.is_action_just_pressed("down"):
		s.play()
		arrow_down.play()
	if Input.is_action_just_pressed("up"):
		w.play()
		arrow_up.play()
	if Input.is_action_just_pressed("left"):
		a.play()
		arrow_left.play()
	if Input.is_action_just_pressed("right"):
		d.play()
		arrow_right.play()
	if Input.is_action_just_pressed("primary action"):
		space.play()
	if Input.is_action_just_pressed("shift"):
		shift.play()

# error here
func _on_back_btn_pressed():
	print("button pressed")
