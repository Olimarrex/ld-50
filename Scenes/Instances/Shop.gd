extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

	if Input.is_action_pressed("pause"):
		self.get_parent().get_parent().get_node("CanvasLayer/playerUI/Shop").show()
		print('boop')
		get_tree().paused = not get_tree().paused
