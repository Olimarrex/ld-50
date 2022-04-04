extends Node2D

export (float) var abilityCooldown = 1
export (int) var timeCost = 8
export (int) var bulletCount = 25
export (int) var bulletSpeed = 600
export (int) var bulletDamage = 200
export (float) var bulletSpread = 160

var cooldown = 0
var bullet
var player

func _ready():
	bullet = preload("res://Scenes/Instances/bullet.tscn")
	player = get_tree().get_current_scene().get_node("Player/KinematicBody2D")

func _process(delta):
	if cooldown >= 0:
		cooldown -= delta

func shootAbility():
	if bullet == null:
		print("IceBurst can not find bullet")
		return
	if player == null: 
		print("IceBurst can not find player")
		return
	
	for i in range(1, bulletCount):
		var bull = bullet.instance()
		bull.get_child(0).speed = bulletSpeed + randf() * bulletSpeed / 2 # Speed + up to 50% extra to get a spread
		bull.get_child(0).damage = bulletDamage + (1 + float(get_parent().get_parent().countPassives("Damage+")))
		bull.get_child(0).penetration = 6
		bull.get_child(0).derecshon = (get_global_mouse_position() - player.position + Vector2((randf()*2)-1, (randf()*2)-1).normalized() * bulletSpread).normalized() 
		bull.position = self.position
		get_parent().add_child(bull)
		$SoundShoot.pitch_scale = 0.8 + sin(i / 3.0) / 10.0;
		$SoundShoot.play();
