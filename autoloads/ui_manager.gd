extends Node
signal ui_changed
signal image_slot_moved_now
signal image_slot_deleted_now
signal msg_start
signal msg_ok

enum IN {GAME,MENU, WIN,OPTIONS,NEWGAMEDIALOG,DECK}
var state : IN = IN.MENU
var last_state : IN = IN.GAME
var flips:int =0
var selected_nedes:Array[CardSlot]
var msg_queue: Array[Dictionary]
var deck_list_max:int 
var deck_from:int
var deck_to: int
#var image_slot_moving: ImageSlot
func _ready():
	GM.start_new_turn.connect(reset_turndata)
func emit_msg_ok():msg_ok.emit()
func image_slot_moved(client: ImageSlot):
	deck_from=client.last_list_id
	deck_to = client.list_id
	#image_slot_moving= client
	#await get_tree().create_timer(0.005).timeout
	image_slot_moved_now.emit()
func image_slot_deleted():
	deck_list_max -=1
	image_slot_deleted_now.emit()
func msg_finished():
	msg_queue.remove_at(0)
	if msg_queue.size() >0: msg_start.emit()
func reset_turndata():
	flips=0
	selected_nedes=[]
func try_add_to_selected(ref:CardSlot):
	if ref==null: return #this would not happen as the cardslot is the only client and allways passes itself as ref
	if flips < Settings.cards_in_set:
		var allready_there:int = selected_nedes.find(ref)#we only allow one instance of ref in our array so it wont match with itself
		if allready_there == -1: #try has succeded, now we add
			selected_nedes.append(ref)
			ref.show_card()
			flips +=1
			if flips == Settings.cards_in_set: GM.emit_do(GM.DO.CHECK)
		else: return #we are trying to add a ref allready in the selected array, computer says nooaauh 
func popup(main:String,title:String="Information",button_text:String ="ok"): #entry for sending msg, allways use this when ordering a msgbox!
	var new_msg:Dictionary={"main":main,"title":title, "button_text": button_text}
	msg_queue.append(new_msg)
	msg_start.emit()
func change_state(new_state:IN): # entry for main window change,allways use this, UI fixes it from there
	last_state = state
	state = new_state
	ui_changed.emit()
func state_back():
	match state:
		IN.GAME: change_state(IN.MENU)
		IN.MENU: change_state(IN.GAME)
		IN.WIN: change_state(IN.NEWGAMEDIALOG)
		IN.NEWGAMEDIALOG: change_state(IN.MENU)
		IN.OPTIONS: change_state(IN.MENU)
		IN.DECK: change_state(IN.MENU)
