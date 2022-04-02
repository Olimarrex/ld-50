extends Area2D


var targit
var speed = 750
var derecshon

func _process(delta):
	if targit:
		var dir = global_position.direction_to(targit.get_position())
		if global_position.distance_to(targit.get_position())<25:
			print("pick up")
			get_parent().queue_free()
		position += transform.x * speed * delta * dir[0]
		position += transform.y * speed * delta * dir[1]
