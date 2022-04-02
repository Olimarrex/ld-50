extends KinematicBody2D

export (int) var speed = 200

var velocity = Vector2()

func _physics_process(delta):
	var dir = global_position.direction_to(get_parent().get_parent().get_node('Player/KinematicBody2D').get_position());
	velocity = move_and_slide(dir * speed)
