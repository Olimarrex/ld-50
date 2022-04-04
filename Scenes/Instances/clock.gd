extends Node2D

export(int, 1, 60) var time = 1
signal add_time

func _ready():
	connect("add_time", get_parent().get_node("CanvasLayer/playerUI") , "_on_Node2D_add_time")
	$Area2D/Icon.self_modulate = Color(1,1-(time/10),1)

func setTime(timeIn):
	time = timeIn	
	set_modulate(Color(1.1-(time/15.0),1,1.1-(time/15.0)))

func _on_Area2D_pick_up():
	emit_signal("add_time", time)
	Autoload.gameScore += time
