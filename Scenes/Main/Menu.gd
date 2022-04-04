extends Control

func _ready():
	$instructionsBackground.hide()

func play():
	get_tree().change_scene("res://Scenes/Instances/test.tscn")

func openInstructions():
	$instructionsBackground.show()

func closeInstructions():
	$instructionsBackground.hide()

func musicToggled(button_pressed):
	if button_pressed == true:
		AudioServer.set_bus_mute(1,true)
		Autoload.musicMuted = true
	elif button_pressed == false:
		AudioServer.set_bus_mute(1,false)
		Autoload.musicMuted = false

func sfxToggled(button_pressed):
	if button_pressed == true:
		AudioServer.set_bus_mute(2,true)
		Autoload.sfxMuted = true
	elif button_pressed == false:
		AudioServer.set_bus_mute(2, false)
		Autoload.sfxMuted = false

func showLeaderBoard():
	get_tree().change_scene("res://Scenes/tests/scoreBord.tscn")
