extends Control
@onready var backside: Control = %backside_container
@onready var slot_list: GridContainer = %frontsides_container
var slots_in_list=0

var test_img:Array[Texture2D]= [preload("uid://d1qibe60vrsv6"),preload("uid://dp3hvkc5cffkh"),preload("uid://qsyonbveyxp4"),preload("uid://ouu15r8xcxqm"),preload("uid://chrk0ughi0w7j")]
const IMAGE_SLOT = preload("uid://drdqb4fmgsgsm")



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	UIM.image_slot_moved_now.connect(rearrange_list)
	UIM.image_slot_deleted_now.connect(on_removing_slot)
	
func rearrange_list():
	#check if UIM.list_from is a valid child
	var from_child= slot_list.get_child(UIM.deck_from)
	slot_list.move_child(from_child,UIM.deck_to)
	update_list_ids()
	#var slots = slot_list.get_children()
	#slots[UIM.list_from].
func on_removing_slot():
	slots_in_list-=1
	update_list_ids()
func update_list_ids():
	var slots = slot_list.get_children()
	var x: =0
	for slot in slots:
		slot.list_id = x
		slot.update_visuals()
		x+=1
func add_backside(img:Texture2D):
	var slots = backside.get_children()
	for slot in slots:
		slot.queue_free()
	var new_slot = IMAGE_SLOT.instantiate()
	backside.add_child(new_slot)
	new_slot.config_image_slot(img,0,false)
func add_slot(img: Texture2D):
	var new_slot = IMAGE_SLOT.instantiate()
	slot_list.add_child(new_slot)
	new_slot.config_image_slot(img,slots_in_list,true)
	slots_in_list+=1
	
func add_slots_from_deck_design(design:DeckDesign):
	remove_all_slots()
	var images = design.img
	var x=1
	add_backside(images[0])
	while x < images.size()-1:
		add_slot(images[x])
		x+=1
	slots_in_list = x-1 #minus on for backside dont count
	UIM.deck_list_max = slots_in_list-1 #minus one for base1 vs base0 issues
	#for i in test_img.size(): #remnants from testing func
		#add_slot(test_img[i])
	#UIM.deck_list_max = slots_in_list-1
	update_visuals()
func update_visuals():
	%deck_populate_frontsides_l.text = str(slots_in_list)
func remove_all_slots():
	var old_slot = slot_list.get_children()
	for slot in old_slot:
		slot.queue_free()
	slots_in_list=0


func _on_deck_load_b_pressed() -> void:
	add_slots_from_deck_design(load("res://resources/decks/anime1.tres"))
