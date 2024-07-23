extends Control
var red_strike_tex = preload("res://Final Assets/red_strike.png")
var coin_reward = preload("res://Final Assets/coin_reward.png")
var UI_strikes = [$HBox/Strike1/EmptyStrike, $HBox/Strike2/EmptyStrike, 
		$HBox/Strike3/EmptyStrike]
var coin_reward_queue = []
var total_coins: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_bins_items_strike_added():
	for x in range(0, 3):
		if UI_strikes[x].texture == red_strike_tex:
			pass
		else:
			UI_strikes[x].texture = red_strike_tex
			break


func _on_bins_items_correct_sort(bin):
	total_coins += 1
	$CoinDisplay/CoinText.text = str(total_coins)
	var coin_spawn: Vector2 
	if bin == 'green':
		coin_spawn = $"../BinsItems/GreenBin".position + Vector2(0, -15)
	elif bin == 'red':
		coin_spawn = $"../BinsItems/RedBin".position + Vector2(0, -20)
	else:
		coin_spawn = $"../BinsItems/BlueBin".position + Vector2(0, -30)
	var coin_disp = Sprite2D.new()
	coin_disp.texture = coin_reward
	coin_disp.position = coin_spawn
	coin_reward_queue.append(coin_disp)
	add_child(coin_disp)
	$CoinRewardTimer.start()
	

func _on_coin_reward_timer_timeout():
	coin_reward_queue[0].queue_free()
	coin_reward_queue.remove_at(0)
