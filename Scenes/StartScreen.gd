extends Node2D
var scroll_speed = 20


func _ready():
	pass

func _process(delta):
	#parallax background movement
	$ParallaxBackground.scroll_offset.x -= scroll_speed * delta


func _on_play_pressed():
	# changing start scene to gameplay scene
	get_tree().change_scene_to_file("res://Scenes/main.tscn")

func _on_quit_pressed():
	# quitting the game
	get_tree().quit()
