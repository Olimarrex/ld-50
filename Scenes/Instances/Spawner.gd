extends Node2D

export (int) var maxAllowedEnemies = 1000
export var currentWave = 0;
export var enemyNodes = {
	"eyeo": "res://Scenes/Instances/Eyeo.tscn",
	"gobbo": "res://Scenes/Instances/Gobbo.tscn",
	"ghost": "res://Scenes/Instances/Ghost.tscn",
	"zombo": "res://Scenes/Instances/Zombie.tscn",
	"skeleto": "res://Scenes/Instances/Skeleto.tscn",
	"countbanks": "res://Scenes/Instances/CountBanks.tscn",
	"eyeboss" : "res://Scenes/Instances/EyeoBoss.tscn"
};

var power = 1
var loadedEnemies = {};

var waves = [
	{
		"ghost": 5,
		"time": 15
	},
	{
		"ghost": 10,
		"time": 15
	},
	{
		"gobbo": 2,
		"ghost": 15,
		"time": 15
	},
	{
		"gobbo": 5,
		"ghost": 15,
		"time": 15
	},
	{
		"gobbo": 5,
		"ghost": 5,
		"zombo": 1,
		"time": 20
	},
	{
		"gobbo": 10,
		"zombo": 5,
		"time": 20
	},
	{
		"gobbo": 5,
		"ghost": 5,
		"zombo": 10,
		"time": 25
	},
	{
		"gobbo": 5,
		"ghost": 5,
		"zombo": 15,
		"time": 25
	},
	{
		"gobbo": 10,
		"ghost": 10,
		"zombo": 10,
		"time": 25
	},
	{
		"gobbo": 5,
		"ghost": 25,
		"zombo": 5,
		"eyeo": 50,
		"time": 25
	},
	{
		"gobbo": 40,
		"ghost": 5,
		"time": 30
	},
	{
		"gobbo": 0,
		"ghost": 5,
		"zombo": 40,
		"time": 30
	},
	{
		"gobbo": 5,
		"ghost": 50,
		"zombo": 5,
		"time": 30
	},
	{
		"gobbo": 30,
		"ghost": 30,
		"zombo": 30,
		"time": 25
	},
	{
		"gobbo": 10,
		"ghost": 50,
		"zombo": 10,
		"eyeo": 100,
		"time": 25
	},
	{
		"gobbo": 10,
		"ghost": 10,
		"zombo": 25,
		"skeleto": 10,
		"time": 25
	},
	{
		"gobbo": 80,
		"ghost": 10,
		"zombo": 80,
		"skeleto": 25,
		"time": 25
	},
	{
		"gobbo": 50,
		"ghost": 40,
		"zombo": 60,
		"skeleto": 25,
		"time": 25
	},
	{
		"gobbo": 90,
		"ghost": 30,
		"zombo": 80,
		"skeleto": 50,
		"time": 30
	},
	{
		"gobbo": 100,
		"ghost": 100,
		"zombo": 100,
		"skeleto": 100,
		"time": 30
	},
	{
		"countbanks": 1,
		"gobbo": 0,
		"ghost": 100,
		"zombo": 10,
		"skeleto": 10,
		"time": 120
	},
	{
		"skeleto": 100,
		"gobbo": 100,
		"ghost": 250,
		"zombo": 100,
		"eyeo": 100,
		"time": 15
	},
	{
		"gobbo": 20,
		"time": 5
	},
	{
		"eyeboss": 1
	},
	{
		"skeleto": 100,
		"gobbo": 100,
		"ghost": 250,
		"zombo": 100,
		"eyeo": 100,
		"time": 15
	},
];

var mobCount

func _ready():
	for key in enemyNodes:
		loadedEnemies[key] = load(enemyNodes[key]);
		if loadedEnemies[key] == null:
			print("Error: Spawner does not have a reference to the node it is set to spawn");

func _process(delta):
	mobCount = len(get_tree().get_nodes_in_group("mobs"))
	if mobCount == 0:
		startNextWave()

func _on_Timer_timeout():
	startNextWave()

func getMobsCountInWave(waveIndex):
	waveIndex = min(waveIndex, waves.size() -1)
	var count = 0
	for key in waves[waveIndex]:
		if key != "time":
			count += waves[waveIndex][key]
	return count
	
func startNextWave():
	if getMobsCountInWave(currentWave) + mobCount > maxAllowedEnemies:
		print("Warn: Can not start next wave since it would exeed maximum allowed enemies. max = " + str(maxAllowedEnemies) + ", current = " + str(mobCount) + ", nextWave = " + str(getMobsCountInWave(currentWave)))
		$Timer.stop()
		$Timer.wait_time = 3
		$Timer.start()
		return
	var wave;
	if(currentWave < waves.size()):
		wave = waves[currentWave];
	else:
		wave = waves[waves.size() - 1];
		power = currentWave - waves.size()
	if "countbanks" in wave or "eyeboss" in wave:
		var name = "COUNT BANKS"
		if("eyeboss" in wave):
			name = "EYEO OF DEATH";
		self.get_parent().get_node("Player/KinematicBody2D/Abilities/Explosion").shootAbility()
		self.get_parent().get_node("CanvasLayer/playerUI/bossHealthBar").show()
		self.get_parent().get_node("CanvasLayer/playerUI/bossHealthBar/bossName").text = name;
		self.get_parent().get_node("CanvasLayer/playerUI/Shop/startingMusic").stop()
		self.get_parent().get_node("CanvasLayer/playerUI/Shop/vampireBossMusic").play()
	for key in wave:
		if key == "time":
			$Timer.stop()
			$Timer.wait_time = wave["time"]
			$Timer.start()
		else:
			spawn(key, wave[key]);
	currentWave += 1;
	var globbo = get_tree().get_nodes_in_group("Globbo")
	var gosts = get_tree().get_nodes_in_group("Ghost")
	var zombos = get_tree().get_nodes_in_group("Zombo")
	var eyeos = get_tree().get_nodes_in_group("Eyeo")

func spawn(key, count):
	var cameraPos = get_parent().get_node('Player/KinematicBody2D/Camera2D').get_camera_position();
	var nodeToSpawn = loadedEnemies[key];
	if key == "eyeo":
		var randRot = deg2rad(rand_range(0, 360));
		var randDis = rand_range(1000, 1200)
		for i in range(0, count):
			var instance = nodeToSpawn.instance();
			instance.get_node('KinematicBody2D').set_position(Vector2(0, (count/2-i)*50).rotated(randRot) + cameraPos + (Vector2(1, 0).rotated(randRot) * randDis));
			instance.get_node('KinematicBody2D').dir = Vector2(1, 0).rotated(randRot+deg2rad(180))
			instance.get_node('KinematicBody2D').setPower(power)
			get_parent().add_child(instance);
	else:
		for _i in range(0, count):
			var rand = deg2rad(rand_range(0, 360));
			var instance = nodeToSpawn.instance();
			instance.get_node('KinematicBody2D').set_position(cameraPos + (Vector2(1, 0).rotated(rand) * rand_range(1000, 2000)));
			instance.get_node('KinematicBody2D').setPower(pow(2, power-1))
			get_parent().add_child(instance);
