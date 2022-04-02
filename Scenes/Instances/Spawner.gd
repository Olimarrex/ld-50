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
		
	var cameraPos = get_parent().get_node('Player/KinematicBody2D/Camera2D').get_camera_position();
	for i in range(1, 25):
		var a = deg2rad(rand_range(0, 360));
		var instance = nodeToSpawn.instance();
		instance.get_node('KinematicBody2D').set_position(cameraPos + (Vector2(1, 0).rotated(a) * rand_range(1000, 1200)));
		get_parent().add_child(instance);
