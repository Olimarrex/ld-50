extends Control

var playerUI

func _ready():
	playerUI = get_tree().get_current_scene().get_node("CanvasLayer/playerUI")

func _process(delta):
	if playerUI.currentTime != null and playerUI.currentTime <= 0:
		self.hide()
	
func _input(_event):
	if playerUI.currentTime != null and playerUI.currentTime > 0:
		if Input.is_action_just_released("pause"):
			if get_tree().paused == false:
				self.get_parent().get_node("EnemyCounters/EnemyCounters/EscTooltip").hide()
				self.show()
				get_tree().paused = true
			else:
				self.get_parent().get_node("EnemyCounters/EnemyCounters/EscTooltip").show()
				self.hide()
				get_tree().paused = false
