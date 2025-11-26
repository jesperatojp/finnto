extends Control
var names:Array[String] 
var scores:Array[int] 

func _ready() -> void:
	GM.game_end.connect(display_winner)
func display_winner():
	names = Settings.player_names
	scores = GM.score
	sort_players_by_score()
	%winner_name_l.text = names[0]
	match Settings.tot_players:
		1:
			%all_names_l.text = names[0]
			%all_scores_l.text = str(scores[0])
		2:
			%all_names_l.text = names[0] + "\n"+ names[1]
			%all_scores_l.text = str(scores[0])+"\n"+str(scores[1])
		3:
			%all_names_l.text = names[0] + "\n"+ names[1]+ "\n"+ names[2]
			%all_scores_l.text = str(scores[0])+"\n"+str(scores[1])+"\n"+str(scores[2])
		4:
			%all_names_l.text = names[0] + "\n"+ names[1]+ "\n"+ names[2]+ "\n"+ names[3]
			%all_scores_l.text = str(scores[0])+"\n"+str(scores[1])+"\n"+str(scores[2])+"\n"+str(scores[3])
		_:pass
	visible = true
	#print("1: "+names[0]+ " with "+ str(scores[0])+ " sets")
	#print("2: "+names[1]+ " with "+ str(scores[1])+ " sets")
	#print("3: "+names[2]+ " with "+ str(scores[2])+ " sets")
	#print("4: "+names[3]+ " with "+ str(scores[3])+ " sets")
func sort_players_by_score() -> void:
	var working:Array = []
	for i in range(names.size()):
		working.append([scores[i], names[i]])
	working.sort_custom(func(a, b): return a[0] > b[0])
 
	for i in range(working.size()):
		scores[i] = working[i][0]
		names[i] = working[i][1]
#func sort_winners():
	#var en:int =34
