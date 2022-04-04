extends Node


export (float) var abilityCooldown = 3
export (int) var timeCost = 2 

var cooldown = 0

func _process(delta):
	if cooldown >= 0:
		cooldown -= delta

func shootAbility():
	var pick_ups = get_tree().get_nodes_in_group("pick_up")
	for i in pick_ups:
		i.target = get_parent().get_parent()
