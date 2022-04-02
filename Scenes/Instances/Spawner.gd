extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var gobbo;
# Called when the node enters the scene tree for the first time.
func _ready():
	print('test');
	gobbo = preload("res://Scenes/Instances/Gobbo.tscn");


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	print_tree();
	get_parent().add_child(gobbo.instance());
