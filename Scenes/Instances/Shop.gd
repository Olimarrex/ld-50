extends Control

var paused = false
var playerUI

func _ready():
	playerUI = get_tree().get_current_scene().get_node("CanvasLayer/playerUI")


func _process(delta):
	if playerUI.currentTime != null and playerUI.currentTime <= 0:
		self.hide()
	
func _input(_event):
	if playerUI.currentTime != null and playerUI.currentTime > 0:
		if Input.is_action_just_released("pause"):
			paused = not paused
			if paused: 
				self.show()
			else:
				self.hide()
			get_tree().paused = paused
