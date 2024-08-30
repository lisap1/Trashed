extends Node2D
var scroll_speed = 20

func _ready():
	$Welcome/PlayerName.text = str(GlobalVars.player_name + "!")


func _process(delta):
	# parallax background movement
	$ParallaxBackground.scroll_offset.x -= scroll_speed * delta


# when play is pressed
func _on_play_pressed():
	GlobalVars.practice_mode_on = false
	# changing start scene to gameplay scene
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


# when quit button is pressed
func _on_quit_pressed():
	# quitting the game
	get_tree().quit()


# when practice mode button is pressed
func _on_practice_mode_pressed():
	# changing scene to practice mode 
	GlobalVars.practice_mode_on = true
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


# when instruction button is pressed show intructions
func _on_instructions_pressed():
	$PauseMenuInstructions.visible = true
