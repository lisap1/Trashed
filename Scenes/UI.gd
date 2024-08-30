extends Control
var game_coin_end = 75
var red_strike_tex = preload("res://Final Assets/red_strike.png")
var coin_reward = preload("res://Final Assets/coin_reward.png")
var UI_strikes = [$HBox/Strike1/EmptyStrike, $HBox/Strike2/EmptyStrike, $HBox/Strike3/EmptyStrike]
var coin_reward_queue = []
var num_coins: int = 0
var coin_addition: int = 1
var bin_highlight = ""
@onready var strike_indicator = $StrikeIndicator


# if in practice mode, strikes won't be visible
func _ready():
	if GlobalVars.practice_mode_on == true:
		$"./HBox".visible = false
		$"./CoinDisplay".visible = false


# add red strike to the UI
func _on_bins_items_strike_added():
	for x in range(0, 3):
		if UI_strikes[x].texture == red_strike_tex:
			pass
		else:
			UI_strikes[x].texture = red_strike_tex
			break


# when an item is sorted correctly
func _on_bins_items_correct_sort(bin):
	# coin display
	num_coins += coin_addition
	$CoinDisplay/CoinText.text = str(num_coins)
	var coin_spawn: Vector2 
	# coin reward position based on where player is 
	if bin == 'food scraps':
		coin_spawn = $"../../BinsItems/GreenBin".position + Vector2(0, -15)
	elif bin == 'general waste':
		coin_spawn = $"../../BinsItems/RedBin".position + Vector2(0, -20)
	else:
		coin_spawn = $"../../BinsItems/BlueBin".position + Vector2(0, -30)
	# create coin display
	var coin_disp = Sprite2D.new()
	coin_disp.texture = coin_reward
	coin_disp.position = coin_spawn
	coin_reward_queue.append(coin_disp)
	add_child(coin_disp)
	$CoinRewardTimer.start()
	# when player reaches the coins goal, change to the win screen
	if num_coins >= game_coin_end:
		if GlobalVars.practice_mode_on != true:
			get_tree().change_scene_to_file("res://Scenes/win_screen.tscn")


# after a certain amount of time, remove the coin reward sprite
func _on_coin_reward_timer_timeout():
	coin_reward_queue[0].queue_free()
	coin_reward_queue.remove_at(0)
	

# on incorrect bin sort, show strike animation and bin highlight
func _on_bins_items_incorrect_sort(bin):
	strike_indicate()
	show_correct_bin(bin)


# highlight the correct bin 
func show_correct_bin(bin):
	if bin == "food scraps":
		bin_highlight = $"../../BinsItems/GreenBinHighlight"
	if bin == "general waste":
		bin_highlight = $"../../BinsItems/RedBinHighlight"
	if bin == "recycling":
		bin_highlight = $"../../BinsItems/BlueBin/BlueBinHighlight"
	bin_highlight.visible = true
	$BinHighlightTimer.start()


# hide bin highlight on timeout
func _on_bin_highlight_timer_timeout():
	bin_highlight.visible = false
	
	
# show strike border animation
func strike_indicate():
	strike_indicator.visible = true
	strike_indicator.play()
	

# hide strike animation after finished
func _on_strike_indicator_animation_finished():
	strike_indicator.visible = false
