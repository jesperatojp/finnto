extends Node
signal start_new_game
signal start_new_turn
signal start_new_round
signal check_correct
signal set_found
signal hide_cards
signal solve_cards
signal game_end
enum DO{NEWGAME,NEWTURN,NEWROUND,CHECK,SETFOUND,HIDE,SOLVE,END}
enum NOW{PC,PLAYER}
var state: NOW = NOW.PC
var go_again:bool = false
var the_deck:Array[Card]
var current_player:int #index of current player 0-3
var score:Array[int]=[0,0,0,0]
var cards_found:int
												#  GAME MANAGER  #
func _ready() -> void:
	start_new_turn.connect(new_turn)
	start_new_round.connect(new_round)
	
func prepare_new_game():
	state =NOW.PC
	score=[0,0,0,0]
	cards_found =0	
	the_deck=make_the_deck()
	emit_do(DO.NEWGAME)
func emit_do(emitting:DO):
	match emitting:
		DO.NEWGAME: start_new_game.emit()
		DO.NEWTURN: start_new_turn.emit()
		DO.NEWROUND: start_new_round.emit()
		DO.CHECK: check_correct.emit()
		DO.SETFOUND: set_found.emit()
		DO.HIDE: hide_cards.emit()
		DO.SOLVE: 
			solve_cards.emit()
			cards_found += Settings.cards_in_set
		DO.END: 
			game_end.emit()
			UIM.change_state(UIM.IN.WIN)
func make_the_deck()->Array[Card]:
	var deck:Array[Card]
	var x=0
	while x < Settings.sets_in_deck:
		var new_card = Card.new()
		new_card.back_img = Settings.design.img[0]
		new_card.front_img = Settings.design.img[x+1]
		new_card.my_deck_id = x+1
		deck.append(new_card)
		x+=1
	match Settings.cards_in_set:
		2:
			deck.append_array(deck)
		3:
			var copy = the_deck
			deck.append_array(deck)
			deck.append_array(copy)
		4:
			deck.append_array(deck)
			deck.append_array(deck)
		_: push_error("cards_in_set from Settings is not 2,3 or 4!!")
	deck.shuffle()
	print("i have made a deck with "+ str(deck.size())+ " cards!")
	return deck
func new_round():
	current_player=-1
	print("new round starts")
	emit_do(DO.NEWTURN)
func new_turn():
	if cards_found >= Settings.tot_slots:#all cards are found, so the game ends
		emit_do(DO.END) 
		print("all cards found, going to win screen")
		return
	if go_again ==true:
		UIM.reset_turndata()
		go_again = false
		UIM.popup("you found a set! "+ Settings.player_names[current_player]+" get to go again")
		return
	current_player += 1
	if current_player == Settings.tot_players:
		emit_do(DO.NEWROUND) #only signals itself might as well call func directly if self is the only recipiant of signal
		return
	
	
	
	####             testing win #######################
	#score=[6,8,3,10]#giving scores to test winning
	#emit_do(DO.END)#game over allready!
	####################################################
