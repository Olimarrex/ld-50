extends Node

var c1 = 0
var c2 = 0
var flip = false
var cloud1 = get_child(0)
var cloud2 = get_child(1)
var cloud3 = get_child(2)
var cloud4 = get_child(3)

func _ready():
	cloud1 = get_node("Cloude1")
	cloud2 = get_node("Cloude2")
	cloud3 = get_node("Cloude3")
	cloud4 = get_node("Cloude4")

func _process(delta):
	if flip:
		c1 -= 10 * delta
		c2 += 10 * delta
	else:
		c1 += 10 * delta
		c2 -= 10 * delta
	if c1 > 500:
		flip = true
	if c1 < -500:
		flip = false
	cloud1.position.x = c1
	cloud3.position.y = c1
	cloud2.position.x = c2
	cloud4.position.y = c2
