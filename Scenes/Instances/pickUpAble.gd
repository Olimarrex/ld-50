extends Area2D

var target
var speed = 750
var distanceToPickUp = 100
var distanceToPickUpSqared = distanceToPickUp * distanceToPickUp;
var derecshon
signal pick_up

func _process(delta):
	if target:
		var dir = global_position.direction_to(target.get_position())
		if global_position.distance_squared_to(target.get_position()) < distanceToPickUpSqared:
			emit_signal("pick_up")
			#hide()
			#set_process(false)
			get_parent().queue_free()
			
		position += transform.x * speed * delta * dir[0]
		position += transform.y * speed * delta * dir[1]

