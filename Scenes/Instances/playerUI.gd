extends Control

export (int) var startingTime = 3
var currentTime = null
var timer
var minutes
var seconds

func _ready():
	randomize()
	$Shop.hide()
	timer = Timer.new()
	self.add_child(timer)
	timer.connect("timeout", self, "countdown")
	timer.set_wait_time(1.0)
	timer.set_one_shot(false)
	timer.start()
	generateOption1()
	generateOption2()
	generateOption3()

func countdown():
	if currentTime == 0:
		timer.stop()
	elif currentTime == null:
		currentTime = startingTime
		updateTime(-1);
	else:
		updateTime(-1);

func updateTime(amount):
	currentTime = max(currentTime + amount, 0);
	minutes = int(currentTime/60)
	seconds = ((float(currentTime)/float(60)) - float(minutes)) * float(60)
	$timerBackground/Time.text = str(minutes).pad_zeros(2) + ":" + str(seconds).pad_zeros(2);
	if currentTime <= 0:
		self.get_parent().get_parent().call("death")
		timer.stop()
		print('game over goes here.');

var currentShop = ["Upgrade #1", "Upgrade #2", "Upgrade #3"]
onready var array = self.get_parent().get_parent().get_node("Player/KinematicBody2D/Upgrades").upgrades
var availableUpgrades = []
onready var currentAbility = self.get_parent().get_parent().get_node("Player/KinematicBody2D/Abilities").activeAbility
var currentPassives = []

func generateOption1():
	availableUpgrades.clear()
	for i in array:
		if i["name"] != currentAbility and not currentShop.has(i["name"]):
			availableUpgrades.append(i)
	var chosenUpgrade = availableUpgrades[randi() % availableUpgrades.size()]
	currentShop.erase($Shop/VBoxContainer/HBoxContainer2/shopOptionBackground1/VBoxContainer/option1Title.text)
	currentShop.append(chosenUpgrade["name"])
	$Shop/VBoxContainer/HBoxContainer2/shopOptionBackground1/VBoxContainer/option1Title.text = chosenUpgrade["name"]
	$Shop/VBoxContainer/HBoxContainer2/shopOptionBackground1/VBoxContainer/option1Cost.text = str(chosenUpgrade["cost"])
	$Shop/VBoxContainer/HBoxContainer2/shopOptionBackground1/VBoxContainer/HBoxContainer/option1Sprite.texture = load(chosenUpgrade["resource"])

func generateOption2():
	availableUpgrades.clear()
	for i in array:
		if i["name"] != currentAbility and not currentShop.has(i["name"]):
			availableUpgrades.append(i)
	var chosenUpgrade = availableUpgrades[randi() % availableUpgrades.size()]
	currentShop.erase($Shop/VBoxContainer/HBoxContainer2/shopOptionBackground2/VBoxContainer/option2Title.text)
	currentShop.append(chosenUpgrade["name"])
	$Shop/VBoxContainer/HBoxContainer2/shopOptionBackground2/VBoxContainer/option2Title.text = chosenUpgrade["name"]
	$Shop/VBoxContainer/HBoxContainer2/shopOptionBackground2/VBoxContainer/option2Cost.text = str(chosenUpgrade["cost"])
	$Shop/VBoxContainer/HBoxContainer2/shopOptionBackground2/VBoxContainer/HBoxContainer/option2Sprite.texture = load(chosenUpgrade["resource"])

func generateOption3():
	availableUpgrades.clear()
	for i in array:
		if i["name"] != currentAbility and not currentShop.has(i["name"]):
			availableUpgrades.append(i)
	var chosenUpgrade = availableUpgrades[randi() % availableUpgrades.size()]
	currentShop.erase($Shop/VBoxContainer/HBoxContainer2/shopOptionBackground3/VBoxContainer/option3Title.text)
	currentShop.append(chosenUpgrade["name"])
	$Shop/VBoxContainer/HBoxContainer2/shopOptionBackground3/VBoxContainer/option3Title.text = chosenUpgrade["name"]
	$Shop/VBoxContainer/HBoxContainer2/shopOptionBackground3/VBoxContainer/option3Cost.text = str(chosenUpgrade["cost"])
	$Shop/VBoxContainer/HBoxContainer2/shopOptionBackground3/VBoxContainer/HBoxContainer/option3Sprite.texture = load(chosenUpgrade["resource"])

func refreshShop():
	if currentTime >= 5:
		generateOption1()
		generateOption2()
		generateOption3()
		updateTime(-5)
		print(currentShop)

func chooseOption1():
	for i in array:
		if i["name"] == $Shop/VBoxContainer/HBoxContainer2/shopOptionBackground1/VBoxContainer/option1Title.text:
			if i["type"] == "Ability":
				self.get_parent().get_parent().get_node("Player/KinematicBody2D/Abilities").activeAbility = i["name"]
				currentAbility = i["name"]
				if $abilityBar.timer != null:
					$abilityBar.timer.stop()
			elif i["type"] == "Passive":
				currentPassives.append(i["name"])
			if currentTime >= i["cost"]:
				updateTime(-i["cost"])
	generateOption1()

func chooseOption2():
	for i in array:
		if i["name"] == $Shop/VBoxContainer/HBoxContainer2/shopOptionBackground2/VBoxContainer/option2Title.text:
			if i["type"] == "Ability":
				self.get_parent().get_parent().get_node("Player/KinematicBody2D/Abilities").activeAbility = i["name"]
				currentAbility = i["name"]
				if $abilityBar.timer != null:
					$abilityBar.timer.stop()
			elif i["type"] == "Passive":
				currentPassives.append(i["name"])
			if currentTime >= i["cost"]:
				updateTime(-i["cost"])
	generateOption2()
	
func chooseOption3():
	for i in array:
		if i["name"] == $Shop/VBoxContainer/HBoxContainer2/shopOptionBackground3/VBoxContainer/option3Title.text:
			if i["type"] == "Ability":
				self.get_parent().get_parent().get_node("Player/KinematicBody2D/Abilities").activeAbility = i["name"]
				currentAbility = i["name"]
				if $abilityBar.timer != null:
					$abilityBar.timer.stop()
			elif i["type"] == "Passive":
				currentPassives.append(i["name"])
			if currentTime >= i["cost"]:
				updateTime(-i["cost"])
	generateOption3()

var lastPickup = OS.get_system_time_secs();
var pickupCount = 1;
func _on_Node2D_add_time(time):
	var pickupTime = OS.get_system_time_secs();
	if pickupTime < lastPickup + 1:
		pickupCount += 1;
	else:
		pickupCount = 0;
	$CoinPickupSound.pitch_scale = 1 + fmod((pickupCount / 30.0), 1.8);
	if pickupCount > 2 && pickupCount % 30 == 0:
		$SoundBigupCoin.play();
	$CoinPickupSound.play();
	updateTime(time)
	lastPickup = pickupTime;
