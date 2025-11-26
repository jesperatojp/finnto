extends Control
var names:Array[String] #set on new game
var score:Array[int] #set in update_visuals
var tot_players: int #set on new game

func _ready() -> void:
	GM.start_new_game.connect(new_game_starts)
	GM.start_new_turn.connect(update_visuals)
	GM.set_found.connect(update_visuals)
	GM.start_new_turn.connect(accentuate_player)
func update_visuals():
	score = GM.score
	%active_player_name_l.text = names[GM.current_player]+"'s turn"
	%player1_name_l.text= names[0]+ ": "+str(score[0])#+"sets"
	%player2_name_l.text= names[1]+ ": "+str(score[1])#+"sets"
	%player3_name_l.text= names[2]+ ": "+str(score[2])#+"sets"
	%player4_name_l.text= names[3]+ ": "+str(score[3])#+"sets"
func accentuate_player():
	var effect = create_tween()
	var original_color = %player1_name_l.modulate
	var blink_color: Color= Color(0.344, 0.029, 0.078, 1.0)
	match GM.current_player:
		0:
			%wow.position= Vector2(123,25)
			%wow.emitting = true
			effect.tween_property(%player1_name_l, "modulate", blink_color, 0.2)
			effect.tween_property(%player1_name_l, "modulate", original_color, 0.3)
			effect.tween_property(%player1_name_l, "modulate", blink_color, 0.2)
			effect.tween_property(%player1_name_l, "modulate", original_color, 0.3)
			effect.tween_property(%player1_name_l, "modulate", blink_color, 0.2)
			effect.tween_property(%player1_name_l, "modulate", original_color, 0.3)
		1:
			%wow.position= Vector2(1805,25)
			%wow.emitting = true
			effect.tween_property(%player2_name_l, "modulate", blink_color, 0.2)
			effect.tween_property(%player2_name_l, "modulate", original_color, 0.3)
			effect.tween_property(%player2_name_l, "modulate", blink_color, 0.2)
			effect.tween_property(%player2_name_l, "modulate", original_color, 0.3)
			effect.tween_property(%player2_name_l, "modulate", blink_color, 0.2)
			effect.tween_property(%player2_name_l, "modulate", original_color, 0.3)
		2:
			%wow.position= Vector2(111,1055)
			%wow.emitting = true
			effect.tween_property(%player3_name_l, "modulate", blink_color, 0.2)
			effect.tween_property(%player3_name_l, "modulate", original_color, 0.3)
			effect.tween_property(%player3_name_l, "modulate", blink_color, 0.2)
			effect.tween_property(%player3_name_l, "modulate", original_color, 0.3)
			effect.tween_property(%player3_name_l, "modulate", blink_color, 0.2)
			effect.tween_property(%player3_name_l, "modulate", original_color, 0.3)
		3:
			%wow.position= Vector2(1805,1055)
			%wow.emitting = true
			effect.tween_property(%player4_name_l, "modulate", blink_color, 0.2)
			effect.tween_property(%player4_name_l, "modulate", original_color, 0.3)
			effect.tween_property(%player4_name_l, "modulate", blink_color, 0.2)
			effect.tween_property(%player4_name_l, "modulate", original_color, 0.3)
			effect.tween_property(%player4_name_l, "modulate", blink_color, 0.2)
			effect.tween_property(%player4_name_l, "modulate", original_color, 0.3)
func new_game_starts():
	names = Settings.player_names
	tot_players = Settings.tot_players
	%active_player_monolog.visible = true
	match tot_players:
		1:
			%player1_monolog.visible =true
			%player2_monolog.visible =false
			%player3_monolog.visible =false
			%player4_monolog.visible =false
		2:
			%player1_monolog.visible =true
			%player2_monolog.visible =true
			%player3_monolog.visible =false
			%player4_monolog.visible =false
		3:
			%player1_monolog.visible =true
			%player2_monolog.visible =true
			%player3_monolog.visible =true
			%player4_monolog.visible =false
		4:
			%player1_monolog.visible =true
			%player2_monolog.visible =true
			%player3_monolog.visible =true
			%player4_monolog.visible =true
		_:push_error("invalid tot_players in player info monolog, i pitty the fool that did this")
	update_visuals()
