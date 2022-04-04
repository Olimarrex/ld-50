extends Node2D


export(String, "Empty", "Ice Burst", "Time Magnet", "Explosion", "Teleport") var activeAbility


func _ready():
	if get_node(activeAbility) == null:
		print("Warn: Abilities does not have an ability set")

func attemptShoot():
	var current = get_node(activeAbility)
	var playerUI = get_tree().get_current_scene().get_node("CanvasLayer/playerUI")
	if current == null:
		print("Warn: Can not use ability, Abilities does not have an ability set")
		return
	if playerUI == null:
		print("Error: Abilities can not find playerUI under CanvasLayer/playerUI")
		return

	if current.cooldown <= 0 and playerUI.currentTime != null and playerUI.currentTime >= current.timeCost:
		var newCooldown = current.abilityCooldown / (1 + get_parent().countPassives("Cooldown-"));
		current.cooldown = newCooldown;
		current.shootAbility()
		get_tree().get_current_scene().get_node("CanvasLayer/playerUI/abilityBar").startCooldown(newCooldown)
		playerUI.currentTime -= current.timeCost

