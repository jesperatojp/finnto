extends Control
class_name ImageSlot
@onready var display_image_box: TextureRect = %display_image_box
const BACK_BIG = 136
const BACK_SMALL = 68
var image: Texture2D
var in_list: bool = true
var list_id: int
var last_list_id: int

func config_image_slot(img: Texture2D,my_id:int,is_in_list:bool = true):
	#checks?
	image =img
	list_id = my_id
	in_list = is_in_list
	update_visuals()
func update_visuals():
	if image ==null: return
	%display_image_box.texture = image
	%buttons.visible = in_list
	match in_list:
		true:
			%back_panel.size.x = BACK_BIG
			%list_number_l.show()
			%list_number_l.text = " "+str(list_id)+"."
		false:
			%back_panel.size.x = BACK_SMALL
			%list_number_l.hide()
			
func _on_down_b_pressed() -> void:
	if list_id== UIM.deck_list_max: return
	last_list_id = list_id
	list_id+=1
	print("moving down "+ str(list_id))
	UIM.image_slot_moved(self)


func _on_up_b_pressed() -> void:
	if list_id== 0: return
	last_list_id = list_id
	list_id-=1
	print("moving up "+ str(list_id))
	UIM.image_slot_moved(self)




func delete_me():
	print("deleting slot")
	queue_free()
func _on_remove_b_pressed() -> void:
	print("button ok")
	UIM.image_slot_deleted()
	call_deferred("delete_me")
