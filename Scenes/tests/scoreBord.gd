extends Control

func _ready():
	yield(SilentWolf.Scores.get_high_scores(), "sw_scores_received")
	var i = 0
	for scores in SilentWolf.Scores.scores:
		i += 1
		get_node("HBoxContainer/VBoxContainer/TextureRect/VBoxContainer/score " + str(i)).text = str(i) + " : " + scores["player_name"] + " : " + str(scores["score"])
		print("Scores: " + str(scores))

func _on_acceptButton_pressed():
	print("Reloading Scene")
	get_tree().paused = false
	get_tree().change_scene("res://Scenes/Instances/test.tscn")

func goToMenu():
	get_tree().change_scene("res://Scenes/Main/Menu.tscn")
