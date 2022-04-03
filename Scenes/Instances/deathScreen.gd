extends Control

func restartGame():
	print("Reloading Scene")
	get_tree().paused = false
	get_tree().change_scene("res://Scenes/Instances/test.tscn")
	
