extends Node2D

export var pathToNode: String = "res://Scenes/Instances/Gobbo.tscn"
var nodeToSpawn


func _ready():
	nodeToSpawn = load(pathToNode);
	if nodeToSpawn == null:
		print("Error: Spawner does not have a reference to the node it is set to spawn")

func _on_Timer_timeout():
	if (nodeToSpawn == null):
		return
		
	var test = get_parent().get_node('Player/KinematicBody2D/Camera2D').get_camera_position();
	for i in range(1, 25):
		var x = rand_range(test.x - 1200, test.x + 1200);
		var y = rand_range(test.y - 800, test.y + 800);
		var instance = nodeToSpawn.instance();
		instance.get_node('KinematicBody2D').set_position(Vector2(x, test.y + 800 * (((i % 2) * 2) - 1)));
		get_parent().add_child(instance);
		var instance2 = nodeToSpawn.instance();
		instance2.get_node('KinematicBody2D').set_position(Vector2(test.x + 1000 * (((i % 2) * 2) - 1), y));
		get_parent().add_child(instance2);
