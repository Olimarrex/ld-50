extends Control

var paused = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _input(event):
	if Input.is_action_just_released("pause"):
		paused = not paused
		if paused: 
			self.show()
		else:
			self.hide()
		get_tree().paused = paused
