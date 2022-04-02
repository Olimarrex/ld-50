extends Control

var startingTime = 10
var currentTime = null
var timer
var minutes
var seconds
var paused = false


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
		currentTime -= 1
		updateTime()
	else:
		currentTime -= 1
		updateTime()

func updateTime():
	minutes = int(currentTime/60)
	seconds = ((float(currentTime)/float(60)) - float(minutes)) * float(60)
	if minutes < 10:
		if seconds < 10:
			$timerBackground/Time.text = "0" + str(minutes) + ":0" + str(seconds)
		else:
			$timerBackground/Time.text = "0" + str(minutes) + ":" + str(seconds)
	else:
		if seconds < 10:
			$timerBackground/Time.text = str(minutes) + ":0" + str(seconds)
		else:
			$timerBackground/Time.text = str(minutes) + ":" + str(seconds)

func chooseOption1():
	print("dmg")


func _input(event):
	if Input.is_action_just_released("pause"):
		paused = not paused
		if paused: 
			self.get_node("Shop").show()
		else:
			self.get_node("Shop").hide()
		get_tree().paused = paused


func _on_Node2D_add_time(time):
	currentTime += time
	$CoinPickupSound.pitch_scale = rand_range(0.9, 1.3);
	$CoinPickupSound.play();
	updateTime()
