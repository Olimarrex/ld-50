extends Control

var startingTime = 64
var currentTime = null
var timer
var minutes
var seconds

func _ready():
	timer = Timer.new()
	self.add_child(timer)
	timer.connect("timeout", self, "countdown")
	timer.set_wait_time(1.0)
	timer.set_one_shot(false)
	timer.start()

func countdown():
	if currentTime == null:
		currentTime = startingTime
		currentTime -= 1
	else:
		currentTime -= 1
	updateTime()

func updateTime():
	minutes = int(currentTime/60)
	seconds = ((float(currentTime)/float(60)) - float(minutes)) * float(60)
	if minutes < 10:
		if seconds < 10:
			$Time.text = "0" + str(minutes) + ":0" + str(seconds)
		else:
			$Time.text = "0" + str(minutes) + ":" + str(seconds)
	else:
		if seconds < 10:
			$Time.text = str(minutes) + ":0" + str(seconds)
		else:
			$Time.text = str(minutes) + ":" + str(seconds)
