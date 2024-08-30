extends Control

var is_paused: bool = false


# open/close pause screen
func set_paused():
	is_paused = !is_paused
	get_tree().paused = is_paused
	visible = is_paused
	$PauseMenuInstructions.visible = false
	# when pause screen is open, pause button is not visible
	$"../PauseBtn".visible = !is_paused
	
	
# when escape is pressed, pause/unpause the game
func _unhandled_input(event: InputEvent):
	if event.is_action_pressed("pause"):
		set_paused()


# resume game button
func _on_resume_btn_pressed():
	set_paused()
	
	
# quit button, change scene to start scene
func _on_quit_btn_pressed():
	is_paused = false
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/start_screen.tscn")


# instructions button
func _on_instructions_pressed():
	$PauseMenuInstructions.visible = true


# pause button
func _on_pause_btn_pressed():
	set_paused()
