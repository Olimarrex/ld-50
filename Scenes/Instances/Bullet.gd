extends Area2D

var speed = 500		
var damage = 50 	# How much damage the bullet inflicts to an entity upon hitting it.
var penetration = 5 # How many enemies the bullet can hit before it despawns.

var derecshon = Vector2(1,0)
var entetiesHit = 0

func _physics_process(delta):
	position += transform.x * speed * delta * derecshon[0]
	position += transform.y * speed * delta * derecshon[1]

func _on_Bullet_body_entered(body):
	if body.is_in_group("mobs"):
		body.takeDamage(damage);
		body.knockback(Vector2(derecshon[0] * speed / 4.0, derecshon[1] * speed / 4.0))
		entetiesHit += 1
		if entetiesHit == penetration: 
			die()

func die():
	get_parent().queue_free()
	
func _on_Timer_timeout():
	die()

func _on_Timer2_timeout():
	$AnimatedSprite.set_rotation_degrees(rad2deg(derecshon.angle()))
