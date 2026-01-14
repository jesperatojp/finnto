extends Control
const ANIME_1 = preload("uid://bnr4fr7isgaic")
const SANDA = preload("uid://bsgw3j7gg7lny")


var my_sets_in_deck:int = 8
var my_deck_design: DeckDesign = ANIME_1
var my_cards_in_set: int =2
var my_players: int=2
var my_player_names : Array[String] = ["the one", "mr two","dave", "adder"]
var my_peek_time_start:float = 2.5
var my_peek_time_flip:float = 2.5
var my_peek_on_start: bool= true
var my_retry_on_set: bool= false
var all_deckdesigns: Array[DeckDesign]= [ANIME_1, SANDA]
var deckdesign_inx:int=0
var deckdesign_last_inx:int=1 #this will be dynamicly set on _ready
func _ready():
	deckdesign_last_inx = all_deckdesigns.size()-1
	import_consts_from_settings()
func import_consts_from_settings():
	%sets_in_game_slider.max_value = Settings.MAX_SET_IN_DECK
	%cards_in_set_slider.max_value = Settings.MAX_CARDS_IN_SET
	%peek_time_start_slider.max_value = Settings.MAX_PEEK_TIME_START
	%peek_time_flip_slider.max_value= Settings.MAX_PEEK_TIME_FLIP
func copy_to_settings():
	Settings.design= my_deck_design
	Settings.tot_slots =my_cards_in_set*my_sets_in_deck
	Settings.cards_in_set =my_cards_in_set
	Settings.sets_in_deck= my_sets_in_deck
	Settings.tot_players =my_players
	Settings.peek_time_start = my_peek_time_start
	Settings.peek_time_flip = my_peek_time_flip
	Settings.peek_on_start= my_peek_on_start
	Settings.player_names = my_player_names
	Settings.retry_on_set = my_retry_on_set
func update_my_visuals():
	%deck_design_l.text = my_deck_design.deck_name
	%sets_in_game_l.text = str(my_sets_in_deck)
	%cards_in_set_l.text = str(my_cards_in_set)
	%peek_time_start_l.text= str(my_peek_time_start)
	%peek_time_flip_l.text =str(my_peek_time_flip)
	%players_l.text = str(my_players)
	if my_cards_in_set * my_sets_in_deck > Settings.MAX_SLOTS: set_warning(true)
	else: set_warning(false)
func _on_h_slider_drag_ended(_value_changed: bool) -> void: #TODO make this and all sliders update visuals in realtime(not wait for drag ended)
	my_sets_in_deck= int(%sets_in_game_slider.value)
	update_my_visuals()
func set_warning(on:bool):
	%warn1_img.visible =on
	%warn2_img.visible =on
func _on_start_new_game_b_pressed() -> void:#TODO make checks for filled in names
	if %warn1_img.visible == true:
		UIM.popup("I cannot start a game with theese setting please reduse cards in set, sets in deck or both and try again")
		return
	var nn:Array[String]= [%name1_in.text]
	nn.append(%name2_in.text)
	nn.append(%name3_in.text)
	nn.append(%name4_in.text)
	my_player_names =nn
	copy_to_settings()
	GM.prepare_new_game()
	UIM.change_state(UIM.IN.GAME)
func _on_cards_in_set_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		my_cards_in_set = int(%cards_in_set_slider.value)
		update_my_visuals()
func _on_peek_time_start_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		my_peek_time_start = %peek_time_start_slider.value
		update_my_visuals()
func _on_peek_time_flip_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		my_peek_time_flip = %peek_time_flip_slider.value
		update_my_visuals()
func _on_peek_on_start_checkbox_pressed() -> void:my_peek_on_start = %peek_on_start_checkbox.button_pressed
func _on_retry_on_set_checkbox_pressed() -> void:my_retry_on_set = %retry_on_set_checkbox.button_pressed
func show_hide_players():
	match my_players:
		1:
			%player_field_2.visible=false
			%player_field_3.visible=false
			%player_field_4.visible=false
		2:
			%player_field_2.visible=true
			%player_field_3.visible=false
			%player_field_4.visible=false
		3:
			%player_field_2.visible=true
			%player_field_3.visible=true
			%player_field_4.visible=false
		4:
			%player_field_2.visible=true
			%player_field_3.visible=true
			%player_field_4.visible=true
		_: push_error("how did you screw this up, value is stricly clamped to 1-4")
func _on_players_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		my_players = int(%players_slider.value)
		show_hide_players()
		update_my_visuals()


func _on_change_deck_design_b_pressed() -> void:
	deckdesign_inx +=1
	if deckdesign_inx > deckdesign_last_inx: deckdesign_inx =0
	my_deck_design = all_deckdesigns[deckdesign_inx]
	%deck_design_l.text = my_deck_design.deck_name
