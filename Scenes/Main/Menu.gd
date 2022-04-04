extends Control

func _ready():
	$instructionsBackground.hide()

func play():
	get_tree().change_scene("res://Scenes/Instances/test.tscn")

func openInstructions():
	$instructionsBackground.show()

func closeInstructions():
	$instructionsBackground.hide()
