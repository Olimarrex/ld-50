extends Node

export (float) var abilityCooldown = 15
export (int) var timeCost = 30

var cooldown = 0

func _process(delta):
	if cooldown >= 0:
		cooldown -= delta

func shootAbility():
	$SoundExplosion.play();
	var mobs = get_tree().get_nodes_in_group("mobs")
	for i in mobs:
		i.die()
