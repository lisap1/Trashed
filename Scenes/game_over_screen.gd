extends CanvasLayer
var scroll_speed = 10

func _process(delta):
	#parallax background movement
	$CloudBackground.scroll_offset.x -= scroll_speed * delta


func _on_play_again_button_pressed():
		get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_quit_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/start_screen.tscn")
