extends Control

func _ready():
	var label = get_node("HBoxContainer").get_node("VBoxContainer").get_node("Score")
	label.text = "Score: " + str(Autoload.gameScore)

func restartGame():
	print("Reloading Scene")
	get_tree().paused = false
	get_tree().change_scene("res://Scenes/Instances/test.tscn")


func _on_submit_pressed():
	var score_id = yield(SilentWolf.Scores.persist_score(get_node("HBoxContainer/VBoxContainer/HBoxContainer/LineEdit").text, Autoload.gameScore), "sw_score_posted")
	if score_id:
		get_tree().change_scene("res://Scenes/tests/scoreBord.tscn")
