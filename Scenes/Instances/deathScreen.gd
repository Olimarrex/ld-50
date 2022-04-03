extends Control

func _ready():
	var label = get_node("HBoxContainer").get_node("VBoxContainer").get_node("Score")
	label.text = "Score: " + str(Autoload.gameScore)

func restartGame():
	print("Reloading Scene")
	get_tree().paused = false
	get_tree().change_scene("res://Scenes/Instances/test.tscn")
	
