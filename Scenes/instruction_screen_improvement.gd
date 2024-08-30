extends Control


func _on_texture_button_pressed():
	$InstructionsItems.visible = true
	

func _on_back_pressed():
	$InstructionsItems.visible = false


func _on_context_frwd_pressed():
	$PauseMenuInstructions.visible = true
