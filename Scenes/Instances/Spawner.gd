extends Node2D

export var currentWave = 0;
export var enemyNodes = {
	"gobbo": "res://Scenes/Instances/Gobbo.tscn",
	"ghost": "res://Scenes/Instances/Ghost.tscn",
};
var loadedEnemies = {};
var waves = [
#	{
#		"gobbo": 5
#	},
#	{
#		"gobbo": 10
#	},
#	{
#		"gobbo": 15,
#		"ghost": 15
#	},
#	{
#		"gobbo": 10
#	},
#	{
#		"gobbo": 70
#	},
#	{
#		"gobbo": 10
#	},
	{
		"gobbo": 500,
		"ghost": 500,
	},
#	{
#		"gobbo": 60,
#		"ghost": 100,
#	}
];

func _ready():
	for key in enemyNodes:
		loadedEnemies[key] = load(enemyNodes[key]);
		if loadedEnemies[key] == null:
			print("Error: Spawner does not have a reference to the node it is set to spawn");


func _on_Timer_timeout():
	var wave;
	if(currentWave < waves.size()):
		wave = waves[currentWave];
	else:
		wave = waves[waves.size() - 1];
		wave["gobbo"] *= 1.1;
	for key in wave:
		spawn(key, wave[key]);
	currentWave += 1;

func spawn(key, count):
	var cameraPos = get_parent().get_node('Player/KinematicBody2D/Camera2D').get_camera_position();
	var nodeToSpawn = loadedEnemies[key];
	for _i in range(1, count):
		var rand = deg2rad(rand_range(0, 360));
		var instance = nodeToSpawn.instance();
		instance.get_node('KinematicBody2D').set_position(cameraPos + (Vector2(1, 0).rotated(rand) * rand_range(1000, 1200)));
		get_parent().add_child(instance);
