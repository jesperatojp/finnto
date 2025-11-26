extends Node2D
const CARD_SLOT = preload("uid://bojnaxjajdt4t")

func _ready() -> void:
	GM.start_new_game.connect(set_up_slots)
	GM.check_correct.connect(check_set)
	#UIM.msg_ok.connect(make_cards_hidden_quickly)
	#%background_music.play()
	
func set_up_slots():
	var cards:Array[Card]= GM.the_deck
	var old_card_slots = %field.get_children()
	for old in old_card_slots:
		old.queue_free()
	var x =0
	while x < cards.size():
		var new_card_slot = CARD_SLOT.instantiate()
		%field.add_child(new_card_slot)
		#front: Texture2D, back:Texture2D, card_num: int, deck_num:int #cheatsheet to see what the config_slot expects, if you need something TODO rewrite this to expect a card instead
		new_card_slot.config_slot(cards[x].front_img,cards[x].back_img, x,cards[x].my_deck_id)
		x+=1
	GM.new_round()
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if UIM.state == UIM.IN.MENU:
			UIM.state_back()
		else:
			UIM.change_state(UIM.IN.MENU)
func check_set():
	GM.state =GM.NOW.PC
	var result:Array[int]=[	]
	var good:bool =true
	var target:int
	var slots = %field.get_children()
	for slot in slots:
		if slot.state == CardSlot.IM.SHOWING: 
			result.append(slot.deck_id)
	target=result[0]
	for id in result:
		if id != target: good= false
	match good:
		true:
			await make_cards_solved()
			%matching_set_sound.play()
			if Settings.retry_on_set==true:
				GM.go_again= true
				GM.new_turn()
			else:GM.emit_do(GM.DO.NEWTURN)
				
		false:
			await make_cards_hidden()
			GM.emit_do(GM.DO.NEWTURN)
	#
func make_cards_solved():
	GM.score[GM.current_player]+=1
	GM.emit_do(GM.DO.SOLVE)
func make_cards_hidden():
	await get_tree().create_timer(Settings.peek_time_flip).timeout
	GM.emit_do(GM.DO.HIDE)
#func make_cards_hidden_quickly():
	#GM.emit_do(GM.DO.HIDE)
func make_window_min_size() -> void:
	print("size signal works ")
	var window_size = DisplayServer.window_get_size()
	if window_size < Settings.MIN_SCREEN_SIZE: get_window().size = Settings.MIN_SCREEN_SIZE
