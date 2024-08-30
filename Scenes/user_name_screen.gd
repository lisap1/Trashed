extends Node2D
var scroll_speed = 20
var invalid_cases = []
var valid_input = ""

# Enter button is disabled while nothing has been inputted
func _ready():
	$EnterBtn.disabled = true


func _process(delta):
	# parallax background movement
	$ParallaxBackground.scroll_offset.x -= scroll_speed * delta


# check text submitted by user
func text_submitted(user_string):
	# if only contains of letters, input is valid
	var contains_not_letters = regex_check(user_string, "[^a-zA-Z]")
	if not contains_not_letters and len(user_string) != 0:
		return true
	# if input is empty, input is invalid
	elif len(user_string) == 0:
		return false
	else:
		# display error messages
		$ColorRect.visible = true
		$Contains.visible = true
		$InvalidName.visible = true
		# check for numbers and add to error message
		var contains_numbers = regex_check(user_string, "[0-9]")
		if contains_numbers:
			invalid_cases.append("numbers,")
		# check for spaces
		var contains_spaces = regex_check(user_string, "[ ]")
		if contains_spaces:
			invalid_cases.append("spaces,")
		# check for symbols 
		var contains_symbols = regex_check(user_string, "[^A-Za-z0-9 ]")
		if contains_symbols:
			invalid_cases.append("symbols,")
		# display error messages
		var cases = ""
		for case in invalid_cases:
			cases += " " + str(case)
		$Contains/InvalidCases.text = str(cases)
		return false
	

# function to check for certain parameters using regex
func regex_check(user_string, search_parameters):
	var regex = RegEx.new()
	# searches for anything that isn't a letter
	regex.compile(search_parameters)
	if regex.search(str(user_string)):
		return true
	else:
		return false


# resetting error messages, checking input again
func check_validity(new_text):
	$ColorRect.visible = false
	$Contains.visible = false
	$InvalidName.visible = false
	invalid_cases = []
	# check input
	valid_input = text_submitted(new_text)
	# if invalid, disable enter button
	if not valid_input:
		$EnterBtn.disabled = true 
	else:
		$EnterBtn.disabled = false


# when user submits valid response
func _on_enter_btn_pressed():
	if valid_input:
		# capitalise name 
		var entered_text = $LineEdit.text
		var structured_text = entered_text.to_lower()
		structured_text = structured_text.capitalize()
		# add player name as global variable
		GlobalVars.player_name = structured_text
		get_tree().change_scene_to_file("res://Scenes/start_screen.tscn")


# when text is changed, check validity
func _on_text_edit_text_changed(new_text):
	check_validity(new_text)
