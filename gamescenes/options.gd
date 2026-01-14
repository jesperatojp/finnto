extends Control



func _on_options_music_slider_drag_ended(value_changed: bool) -> void:
	if value_changed== false: return
	Settings.volume_music = %options_music_slider.value
	UIM.change_volume()

func _on_options_effects_slider_drag_ended(value_changed: bool) -> void:
	if value_changed== false: return
	Settings.volume_effects =%options_effects_slider.value
	UIM.change_volume()
