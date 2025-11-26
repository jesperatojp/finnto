extends Control
var is_displaying = false
#var signal_ok:bool
func _ready() -> void:
	UIM.msg_start.connect(try_add)
func try_add(): 
	if is_displaying:return
	_display_msg(UIM.msg_queue[0])
func _display_msg(msg:Dictionary):
	%popup_header_l.text= msg["title"]
	%popup_main_l.text = msg["main"]
	%popup_main_b.text = msg["button_text"]
	#signal_ok= msg["signal"]
	is_displaying = true
	visible=true
func _on_popup_close_b_pressed() -> void:
	is_displaying = false
	visible = false
	#if signal_ok: UIM.emit_msg_ok()
	UIM.msg_finished()
