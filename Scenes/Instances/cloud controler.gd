extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var c1 = 0
var c2 = 0
var cloud1 = get_child(0)
var cloud2 = get_child(1)
var cloud3 = get_child(2)
var cloud4 = get_child(3)

# Called when the node enters the scene tree for the first time.
func _ready():
	cloud1 = get_child(0)
	cloud2 = get_child(1)
	cloud1 = get_child(2)
	cloud2 = get_child(3)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	c1 += 1
	c2 -= 1
	if cloud1 and cloud2 and cloud3 and cloud4:
		cloud1.position.x = c1
		cloud3.position.y = c1
		if c1 > 500:
			c1 == 0
		cloud2.position.x = c2
		cloud4.position.y = c2
		if c2 < -500:
			c2 == 0
