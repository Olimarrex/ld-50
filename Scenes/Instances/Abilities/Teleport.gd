extends Node2D


export (float) var abilityCooldown = 1
export (int) var timeCost = 2 
export (int) var TeleportDis = 350


var cooldown = 0

func shootAbility():
	var der = (get_parent().get_parent().position - get_global_mouse_position()).normalized()
	
	get_parent().get_parent().position -= der * TeleportDis

