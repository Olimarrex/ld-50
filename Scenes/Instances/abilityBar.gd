extends TextureProgress

var timer = null
var abilityTime

func startCooldown(time):
	abilityTime = time
	timer = Timer.new()
	self.add_child(timer)
	timer.connect("timeout", self, "finishCooldown")
	timer.set_wait_time(time)
	timer.set_one_shot(true)
	timer.start()

func _physics_process(_delta):
	if timer != null:
		self.value = (timer.time_left/abilityTime)*100

func finishCooldown():
	timer = null
	self.value = 0
