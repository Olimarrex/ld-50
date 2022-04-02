extends Node2D

export(int, 1, 60) var time = 1
signal add_time

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("add_time", get_parent().get_node("CanvasLayer/playerUI") , "_on_Node2D_add_time")
	pass # Replace with function body.



func _on_Area2D_pick_up():
	emit_signal("add_time", time)

