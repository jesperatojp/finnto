extends PanelContainer
class_name CardSlot

enum IM {SHOWING,HIDDEN,SOLVED}
var state : IM = IM.HIDDEN
var my_front : Texture2D
var my_back:Texture2D
var slot_id: int # address of the slot in fields
var deck_id: int # type of card, used to identfy similar cards just like: "queen of hearts"
var hover: bool = false

func _ready() -> void:
	GM.hide_cards.connect(hide_card)
	GM.solve_cards.connect(solve_card)
func config_slot(front: Texture2D, back:Texture2D, card_slot_num: int, deck_num:int):
	my_front = front
	my_back = back
	slot_id = card_slot_num
	deck_id = deck_num
	match Settings.peek_on_start:
		true:
			state = IM.SHOWING
			%img.texture = my_front
			%show_on_spawn_timer.start(Settings.peek_time_start)
		false:
			_do_hide()
func hide_card():
	if state != IM.SHOWING: return
	_do_hide()
	
func show_card():
	if state == IM.HIDDEN: 
		state = IM.SHOWING
		%flopp.play()
		%img.texture = my_front
func solve_card(): 
	if state == IM.SHOWING: 
		state = IM.SOLVED
		GM.state = GM.NOW.PLAYER
		#GM.go_again= Settings.retry_on_set
func _do_hide(): #internal only, you use hide_card()!!!!!!!!!
	state= IM.HIDDEN
	%flopp.play()
	%img.texture = my_back
	GM.state= GM.NOW.PLAYER
#func _on_show_on_flip_timer_timeout() -> void:
	#print("IM STILL IN USE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
	#_do_hide()
func _on_show_on_spawn_timer_timeout() -> void:#I STOPPED USING _DO_HIDE HERE TO AVOID OVERFLOPPING
	state= IM.HIDDEN
	%img.texture = my_back
	GM.state= GM.NOW.PLAYER
func _on_mouse_entered() -> void:hover = true
func _on_mouse_exited() -> void:hover= false
func _input(event: InputEvent) -> void:if event.is_action_pressed("venstreklikk"):if hover ==true && state== IM.HIDDEN && GM.state == GM.NOW.PLAYER: UIM.try_add_to_selected(self)
