extends Control

var is_paused: bool = false
	#set = set_paused

func set_paused():
	is_paused = !is_paused
	get_tree().paused = is_paused
	visible = is_paused
	$PauseMenuInstructions.visible = false
	
func _unhandled_input(event: InputEvent):
	if event.is_action_pressed("pause"):
		set_paused()

func _on_resume_btn_pressed():
	set_paused()
	
func _on_quit_btn_pressed():
	is_paused = false
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/start_screen.tscn")

func _on_instructions_pressed():
	$PauseMenuInstructions.visible = true

func _on_pause_btn_pressed():
	set_paused()
