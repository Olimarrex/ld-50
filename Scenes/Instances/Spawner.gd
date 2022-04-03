extends Node2D

export var currentWave = 0;
export var enemyNodes = {
	"gobbo": "res://Scenes/Instances/Gobbo.tscn",
	"ghost": "res://Scenes/Instances/Ghost.tscn",
	"zombo": "res://Scenes/Instances/Zombie.tscn"
};
var loadedEnemies = {};
var waves = [
	{
		"gobbo": 2,
		"ghost": 4,
		"zombo": 1
	},
	{
		"gobbo": 2,
		"ghost": 4
	},
	{
		"gobbo": 4,
		"ghost": 6
	},
	{
		"gobbo": 0,
		"ghost": 10
	},
	{
		"gobbo": 0,
		"ghost": 15,
		"zombo": 1
	},
	{
		"gobbo": 10,
		"ghost": 0,
		"zombo": 5
	},
	{
		"gobbo": 3,
		"ghost": 3,
		"zombo": 15
	},
	{
		"gobbo": 4,
		"ghost": 4,
		"zombo": 16
	},
	{
		"gobbo": 5,
		"ghost": 5,
		"zombo": 18
	},
	{
		"gobbo": 20,
		"ghost": 20,
		"zombo": 5
	},
	{
		"gobbo": 40,
		"ghost": 0
	},
	{
		"gobbo": 0,
		"ghost": 0,
		"zombo": 30
	},
	{
		"gobbo": 10,
		"ghost": 0,
		"zombo": 30
	},
	{
		"gobbo": 30,
		"ghost": 30,
		"zombo": 30
	},
	{
		"gobbo": 10,
		"ghost": 50,
		"zombo": 10
	},
	{
		"gobbo": 100,
		"ghost": 0,
		"zombo": 0
	},
	{
		"gobbo": 80,
		"ghost": 0,
		"zombo": 80
	},
	{
		"gobbo": 50,
		"ghost": 40,
		"zombo": 60
	},
	{
		"gobbo": 90,
		"ghost": 30,
		"zombo": 80
	},
	{
		"gobbo": 100,
		"ghost": 100,
		"zombo": 100
	}
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
		#wave["gobbo"] *= 1.1;
	for key in wave:
		spawn(key, wave[key] + 1);
	currentWave += 1;
	var globbo = get_tree().get_nodes_in_group("Globbo")
	var gosts = get_tree().get_nodes_in_group("Ghost")
	var zombos = get_tree().get_nodes_in_group("Zombo")
	print("gobs = " + str(len(globbo)) + ", ghost = " + str(len(gosts)) + ", zombos = " + str(len(zombos)))

func spawn(key, count):
	var cameraPos = get_parent().get_node('Player/KinematicBody2D/Camera2D').get_camera_position();
	var nodeToSpawn = loadedEnemies[key];
	for _i in range(1, count):
		var rand = deg2rad(rand_range(0, 360));
		var instance = nodeToSpawn.instance();
		instance.get_node('KinematicBody2D').set_position(cameraPos + (Vector2(1, 0).rotated(rand) * rand_range(1000, 1200)));
		get_parent().add_child(instance);
