extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var gobbo;
# Called when the node enters the scene tree for the first time.
func _ready():
	#print('test');
	gobbo = preload("res://Scenes/Instances/Gobbo.tscn");


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
<<<<<<< Updated upstream
	#print_tree();
	get_parent().add_child(gobbo.instance());
=======
	var test = get_parent().get_node('Player/KinematicBody2D/Camera2D').get_camera_position();
	for i in range(1, 12):
		var x = rand_range(test.x - 1200, test.x + 1200);
		var y = rand_range(test.y - 800, test.y + 800);
		var instance = gobbo.instance();
		instance.get_node('KinematicBody2D').set_position(Vector2(x, test.y + 800 * (((i % 2) * 2) - 1)));
		get_parent().add_child(instance);
		var instance2 = gobbo.instance();
		instance2.get_node('KinematicBody2D').set_position(Vector2(test.x + 1000 * (((i % 2) * 2) - 1), y));
		get_parent().add_child(instance2);
>>>>>>> Stashed changes
