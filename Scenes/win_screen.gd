extends Node2D


 # on continute button pressed, change scene to start screen
func _on_continue_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/start_screen.tscn")
