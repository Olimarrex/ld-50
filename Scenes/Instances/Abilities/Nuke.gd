extends Node


export (float) var abilityCooldown = 3
export (int) var timeCost = 2 

var cooldown = 0

func shootAbility():
	$SoundExplosion.play();
	var mobs = get_tree().get_nodes_in_group("mobs")
	for i in mobs:
		i.takeDamage(1000)
