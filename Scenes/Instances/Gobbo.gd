extends KinematicBody2D

export (int) var speed = 200

var velocity = Vector2()



func _physics_process(delta):
	var dir = global_position.direction_to(get_parent().get_parent().get_node('Player/KinematicBody2D').get_position());
	velocity  = move_and_slide(dir * speed)
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.is_in_group("player"):
			get_parent().get_parent().get_node("CanvasLayer").get_node("playerUI").get_node("healthBar").value -= 1
			print("I collided with ", collision.collider.name)
