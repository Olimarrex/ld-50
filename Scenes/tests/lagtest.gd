extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var clock = preload("res://Scenes/Instances/clock.tscn")
	for i in range(1000):
		var rand = deg2rad(rand_range(0, 360));
		var instance = clock.instance();
		instance.get_node('Area2D').set_position((Vector2(1, 0).rotated(rand) * rand_range(100, 120)));
		add_child(instance);

