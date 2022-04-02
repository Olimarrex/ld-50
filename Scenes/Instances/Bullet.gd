extends Area2D


var speed = 750
var damage = 35
var derecshon = Vector2(1,0)

func _physics_process(delta):
	position += transform.x * speed * delta * derecshon[0]
	position += transform.y * speed * delta * derecshon[1]

func _on_Bullet_body_entered(body):
	if body.is_in_group("mobs"):
		body.takeDamage(damage)
		get_parent().queue_free()


func _on_Timer_timeout():
	get_parent().queue_free()
