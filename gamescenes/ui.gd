extends CanvasLayer
const ANIME1 = preload("uid://bnr4fr7isgaic")

func _ready() -> void:
	UIM.ui_changed.connect(set_visuals)
	UIM.change_state(UIM.IN.MENU)
func set_visuals():
	%main_menu.hide()
	%options.hide()
	%new_game_dialog.hide()
	%winner_splashscreen.hide()
	%deck_maker.hide()
	match UIM.state:
		UIM.IN.GAME:pass
		UIM.IN.MENU:%main_menu.show()
		UIM.IN.OPTIONS:%options.show()
		UIM.IN.NEWGAMEDIALOG:%new_game_dialog.show()
		UIM.IN.WIN:%winner_splashscreen.show()
		UIM.IN.DECK:%deck_maker.show()
		_: push_error("OUPS!!! someone added new constants in UIM.IN without telling ui, tsk tsk!")
func _on_close_new_dialog_b_pressed() -> void:UIM.state_back()
func _on_quit_game_b_pressed() -> void:get_tree().quit()
func _on_make_a_deck_b_pressed() -> void:UIM.change_state(UIM.IN.DECK)
func _on_start_options_b_pressed() -> void:UIM.change_state(UIM.IN.OPTIONS)
func _on_start_new_game_dialog_b_pressed() -> void:UIM.change_state(UIM.IN.NEWGAMEDIALOG)
func _on_close_options_b_pressed() -> void:UIM.state_back()
func _on_deck_close_b_pressed() -> void:UIM.state_back()
