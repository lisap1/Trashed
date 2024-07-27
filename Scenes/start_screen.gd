extends Node2D
var scroll_speed = 20


func _process(delta):
	#parallax background movement
	$ParallaxBackground.scroll_offset.x -= scroll_speed * delta


func _on_play_pressed():
	GlobalVars.practice_mode_on = false
	# changing start scene to gameplay scene
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_quit_pressed():
	# quitting the game
	get_tree().quit()


func _on_practice_mode_pressed():
	# changing scene to practice mode 
	GlobalVars.practice_mode_on = true
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
