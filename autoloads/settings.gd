extends Node
const MAX_CHAR_IN_NAME = 8
const MAX_SLOTS =36
const MIN_SCREEN_SIZE = Vector2i(640,360)
const MAX_SET_IN_DECK = 18
const MAX_CARDS_IN_SET = 4
const MAX_PEEK_TIME_START = 10.0
const MAX_PEEK_TIME_FLIP =5.0
var design:DeckDesign
var tot_slots:int=16
var cards_in_set:int=2
var sets_in_deck:int =8
var tot_players:int = 2
var peek_time_start:float = 9.5
var peek_time_flip:float = 9.5
var peek_on_start:bool = true
var player_names: Array[String] 
var retry_on_set:bool = false
