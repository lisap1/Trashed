extends Control
var game_coin_end = 75
var red_strike_tex = preload("res://Final Assets/red_strike.png")
var coin_reward = preload("res://Final Assets/coin_reward.png")
var UI_strikes = [$HBox/Strike1/EmptyStrike, $HBox/Strike2/EmptyStrike, 
		$HBox/Strike3/EmptyStrike]
var coin_reward_queue = []
var num_coins: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


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
	num_coins += 1
	GlobalVars.total_coins += 1
	$CoinDisplay/CoinText.text = str(num_coins)
	var coin_spawn: Vector2 
	# coin reward position based on where player is 
	if bin == 'food scraps':
		coin_spawn = $"../BinsItems/GreenBin".position + Vector2(0, -15)
	elif bin == 'general waste':
		coin_spawn = $"../BinsItems/RedBin".position + Vector2(0, -20)
	else:
		coin_spawn = $"../BinsItems/BlueBin".position + Vector2(0, -30)
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


func _on_coin_reward_timer_timeout():
	coin_reward_queue[0].queue_free()
	coin_reward_queue.remove_at(0)
