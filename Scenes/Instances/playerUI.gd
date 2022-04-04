extends Control

export (int) var startingTime = 300
export (int) var startingRefreshCost = 5

var currentTime = null
var timer
var minutes
var seconds

var refreshLabel
var upgradesBought = 0

func _ready():
	refreshLabel = get_node("Shop").get_node("HBoxContainer").get_node("Label")
	
	currentTime = startingTime;
	randomize()
	$Shop.hide()
	if Autoload.musicMuted == true:
		$Shop/Toggles2/Toggles/musicToggle.pressed = true
	if Autoload.sfxMuted == true:
		$Shop/Toggles2/Toggles/sfxToggle.pressed = true
	timer = Timer.new()
	self.add_child(timer)
	timer.connect("timeout", self, "countdown")
	timer.set_wait_time(1.0)
	timer.set_one_shot(false)
	timer.start()
	updatePrices()
	generateOption1()
	generateOption2()
	generateOption3()
	var passiveIcons = [get_node("HBoxContainer/VBoxContainer/Movement+"),
	get_node("HBoxContainer/VBoxContainer/Damage+"),get_node("HBoxContainer/VBoxContainer/Cooldown-"),
	get_node("HBoxContainer/VBoxContainer/Attack Speed+"),get_node("HBoxContainer/VBoxContainer/Time Save"),
	get_node("HBoxContainer/VBoxContainer/Pick Up")]
	$bossHealthBar.hide()
	for i in passiveIcons:
		i.hide()

func countdown():
	updateTime(-1);

func updateTime(amount):
	currentTime = max(currentTime + amount, 0);
	minutes = int(currentTime/60)
	seconds = ((float(currentTime)/float(60)) - float(minutes)) * float(60)
	$timerBackground/Time.text = str(minutes).pad_zeros(2) + ":" + str(seconds).pad_zeros(2);

var currentShop = ["Upgrade #1", "Upgrade #2", "Upgrade #3"]
onready var array = self.get_parent().get_parent().get_node("Player/KinematicBody2D/Upgrades").upgrades
var availableUpgrades = []
onready var currentAbility = self.get_parent().get_parent().get_node("Player/KinematicBody2D/Abilities").activeAbility
var currentPassives = []

func generateOption1():
	generateOption($Shop/VBoxContainer/HBoxContainer2/shopOptionBackground1/VBoxContainer/option1Title, $Shop/VBoxContainer/HBoxContainer2/shopOptionBackground1/VBoxContainer/option1Cost, $Shop/VBoxContainer/HBoxContainer2/shopOptionBackground1/VBoxContainer/option1UseCost, $Shop/VBoxContainer/HBoxContainer2/shopOptionBackground1/VBoxContainer/HBoxContainer/option1Sprite);

func generateOption2():
	generateOption($Shop/VBoxContainer/HBoxContainer2/shopOptionBackground2/VBoxContainer/option2Title, $Shop/VBoxContainer/HBoxContainer2/shopOptionBackground2/VBoxContainer/option2Cost, $Shop/VBoxContainer/HBoxContainer2/shopOptionBackground2/VBoxContainer/option2UseCost, $Shop/VBoxContainer/HBoxContainer2/shopOptionBackground2/VBoxContainer/HBoxContainer/option2Sprite);

func generateOption3():
	generateOption($Shop/VBoxContainer/HBoxContainer2/shopOptionBackground3/VBoxContainer/option3Title, $Shop/VBoxContainer/HBoxContainer2/shopOptionBackground3/VBoxContainer/option3Cost, $Shop/VBoxContainer/HBoxContainer2/shopOptionBackground3/VBoxContainer/option3UseCost, $Shop/VBoxContainer/HBoxContainer2/shopOptionBackground3/VBoxContainer/HBoxContainer/option3Sprite);

func regenerateText(optTitle, optCost):
	var name =  optTitle.text
	for i in array:
		if i["name"] == name:
			optCost.text = str(getCost(i["cost"])) + " Seconds";

func generateOption(optTitle, optCost, optUseCost, optSprite):
	availableUpgrades.clear()
	print(array.size());
	for i in array:
		if i["name"] != currentAbility and not currentShop.has(i["name"]):
			availableUpgrades.append(i)
	var chosenUpgrade = availableUpgrades[randi() % availableUpgrades.size()]
	currentShop.erase(optTitle.text)
	currentShop.append(chosenUpgrade["name"])
	optTitle.text = chosenUpgrade["name"]
	var newCost = getCost(chosenUpgrade["cost"]);
	print(chosenUpgrade)
	optCost.text = str(newCost) + " Seconds"
	if chosenUpgrade["type"] == "Ability":
		optUseCost.text = "Use Cost: " + str(chosenUpgrade["useCost"])
	else:
		optUseCost.text = ""
	optSprite.texture = load(chosenUpgrade["resource"])
	
func countPassive(name):
	var count = 0;
	for passive in currentPassives:
		if passive == name:
			count += 1;
	return count;

func getTimeSaveDivision():
	return (1 + countPassive("Time Save") / 10.0)
	
func getCost(currCost):
	var cost = round((currCost + (upgradesBought * Autoload.upgradeCostScale)) / getTimeSaveDivision());
	print("abilityCost = " + str(cost))
	return cost

func getRefreshCost():	
	var cost = round((startingRefreshCost + (Autoload.time / 60 * Autoload.refreshCostScale)) / getTimeSaveDivision())
	print("refreshCost = " + str(cost))
	return cost 


func updatePrices():
	Autoload.time = currentTime
	regenerateText($Shop/VBoxContainer/HBoxContainer2/shopOptionBackground1/VBoxContainer/option1Title, $Shop/VBoxContainer/HBoxContainer2/shopOptionBackground1/VBoxContainer/option1Cost);
	regenerateText($Shop/VBoxContainer/HBoxContainer2/shopOptionBackground2/VBoxContainer/option2Title, $Shop/VBoxContainer/HBoxContainer2/shopOptionBackground2/VBoxContainer/option2Cost);
	regenerateText($Shop/VBoxContainer/HBoxContainer2/shopOptionBackground3/VBoxContainer/option3Title, $Shop/VBoxContainer/HBoxContainer2/shopOptionBackground3/VBoxContainer/option3Cost);
	if getRefreshCost() < 60:
		refreshLabel.text = str(getRefreshCost()) + " Seconds"
	else:
		refreshLabel.text = str(getRefreshCost() / 60) + " Minutes"
		
func refreshShop():
	if currentTime > getRefreshCost():
		generateOption1()
		generateOption2()
		generateOption3()
		updateTime(-getRefreshCost())
		updatePrices()
		print(currentShop)

func chooseOption1():
	chooseOption($Shop/VBoxContainer/HBoxContainer2/shopOptionBackground1/VBoxContainer/option1Title, $Shop/VBoxContainer/HBoxContainer2/shopOptionBackground1/VBoxContainer/option1Cost, $Shop/VBoxContainer/HBoxContainer2/shopOptionBackground1/VBoxContainer/option1UseCost, $Shop/VBoxContainer/HBoxContainer2/shopOptionBackground1/VBoxContainer/HBoxContainer/option1Sprite);

func chooseOption2():
	chooseOption($Shop/VBoxContainer/HBoxContainer2/shopOptionBackground2/VBoxContainer/option2Title, $Shop/VBoxContainer/HBoxContainer2/shopOptionBackground2/VBoxContainer/option2Cost, $Shop/VBoxContainer/HBoxContainer2/shopOptionBackground2/VBoxContainer/option2UseCost, $Shop/VBoxContainer/HBoxContainer2/shopOptionBackground2/VBoxContainer/HBoxContainer/option2Sprite);

func chooseOption3():
	chooseOption($Shop/VBoxContainer/HBoxContainer2/shopOptionBackground3/VBoxContainer/option3Title, $Shop/VBoxContainer/HBoxContainer2/shopOptionBackground3/VBoxContainer/option3Cost, $Shop/VBoxContainer/HBoxContainer2/shopOptionBackground3/VBoxContainer/option3UseCost, $Shop/VBoxContainer/HBoxContainer2/shopOptionBackground3/VBoxContainer/HBoxContainer/option3Sprite);

func chooseOption(optTitle, optCost, optUseCost, optSprite):
	for i in array:
		if i["name"] == optTitle.text:
			var newCost = getCost(i["cost"]);
			print(newCost, i["cost"]);
			if currentTime > newCost:
				updateTime(-newCost)
				if i["type"] == "Ability":
					self.get_parent().get_parent().get_node("Player/KinematicBody2D/Abilities").activeAbility = i["name"]
					currentAbility = i["name"]
					$abilityBar.texture_under = load(i["icon"])
					$abilityBar/abilityCost.text = "Cost: " + str(i["useCost"])
					if $abilityBar.timer != null:
						$abilityBar.timer.stop()
						if self.get_parent().get_parent().get_node("Player/KinematicBody2D/Abilities/" + str(currentAbility)).abilityCooldown > 0:
							$abilityBar.value = (self.get_parent().get_parent().get_node("Player/KinematicBody2D/Abilities/" + str(currentAbility)).abilityCooldown)/(self.get_parent().get_parent().get_node("Player/KinematicBody2D/Abilities/" + str(currentAbility)).abilityCooldown) * 100
				elif i["type"] == "Passive":
					currentPassives.append(i["name"])
					regenerateText($Shop/VBoxContainer/HBoxContainer2/shopOptionBackground1/VBoxContainer/option1Title, $Shop/VBoxContainer/HBoxContainer2/shopOptionBackground1/VBoxContainer/option1Cost);
					regenerateText($Shop/VBoxContainer/HBoxContainer2/shopOptionBackground2/VBoxContainer/option2Title, $Shop/VBoxContainer/HBoxContainer2/shopOptionBackground2/VBoxContainer/option2Cost);
					regenerateText($Shop/VBoxContainer/HBoxContainer2/shopOptionBackground3/VBoxContainer/option3Title, $Shop/VBoxContainer/HBoxContainer2/shopOptionBackground3/VBoxContainer/option3Cost);
					if get_node("HBoxContainer/VBoxContainer/" + str(i["name"])).visible == false:
						get_node("HBoxContainer/VBoxContainer/" + str(i["name"])).show()
						get_node("HBoxContainer/VBoxContainer/" + str(i["name"]) + "/Counter").text = "x1"
					else:
						get_node("HBoxContainer/VBoxContainer/" + str(i["name"]) + "/Counter").text = "x" + str(currentPassives.count(i["name"]))
					if i["name"] == "Pick Up":
						var player = get_tree().get_nodes_in_group("player")[0]
						if player:
							player.get_node("pickup/CollisionShape2D").scale = Vector2(currentPassives.count(i["name"])+1, currentPassives.count(i["name"])+1)
						else:
							print("no player some how: " + str(player))
			generateOption(optTitle, optCost, optUseCost, optSprite);
			break;
	upgradesBought += 1
	updatePrices()

func _process(_delta):
	Autoload.time = currentTime
	var boss = get_tree().get_nodes_in_group("CountBanks")
	if boss:
		$bossHealthBar.max_value = boss[0].get_node("KinematicBody2D/enemyHealthBar").max_value
		$bossHealthBar.value = boss[0].get_node("KinematicBody2D/enemyHealthBar").value

var lastPickup = OS.get_system_time_secs();
var pickupCount = 1;
func _on_Node2D_add_time(time):
	var pickupTime = OS.get_system_time_secs();
	if pickupTime < lastPickup + 1:
		pickupCount += 1;
	else:
		pickupCount = 0;
	$CoinPickupSound.pitch_scale = 1 + (pickupCount % 40 / 30.0) + min(pickupCount / 80.0, 0.6);
	if pickupCount > 1 && pickupCount % 40 == 0:
		$SoundBigupCoin.play();
	$CoinPickupSound.play();
	updateTime(time)
	lastPickup = pickupTime;

func musicToggled(button_pressed):
	if button_pressed == true:
		AudioServer.set_bus_mute(1, true)
	elif button_pressed == false:
		AudioServer.set_bus_mute(1, false)

func sfxToggled(button_pressed):
	if button_pressed == true:
		AudioServer.set_bus_mute(2, true)
	elif button_pressed == false:
		AudioServer.set_bus_mute(2, false)
