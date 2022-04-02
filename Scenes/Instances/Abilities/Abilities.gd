extends Node


export(String, "IceBurst", "TimeSuck") var activeAbility


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
		current.cooldown = current.abilityCooldown
		current.shootAbility()
		playerUI.currentTime -= current.timeCost

func _process(delta):
	var current = get_node(activeAbility)
	if current != null and current.cooldown >= 0:
		current.cooldown -= delta

