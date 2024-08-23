extends Control

func _ready():
	if GlobalVars.practice_mode_on == true:	
		visible = true
		get_tree().paused = true
	
func _on_texture_button_pressed():
	get_tree().paused = false
	visible = false
	
