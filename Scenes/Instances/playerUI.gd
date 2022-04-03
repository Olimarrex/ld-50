extends Control

var startingTime = 10
var currentTime = null
var timer
var minutes
var seconds



func _ready():
	$Shop.hide()
	timer = Timer.new()
	self.add_child(timer)
	timer.connect("timeout", self, "countdown")
	timer.set_wait_time(1.0)
	timer.set_one_shot(false)
	timer.start()

func countdown():
	if currentTime == 1:
		self.get_parent().get_parent().call("death")
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
		print('game over goes here.');

func chooseOption1():
	print("dmg")

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
