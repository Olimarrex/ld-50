extends KinematicBody2D

export (int) var speed = 200
export (int) var damage = 1
export (int) var maxHealth = 100
export (int) var pickUpTime = 1
export (float) var knockbackRes = 1.0
export (NodePath) var spright = null
export (int) var despawnDistance = 5000

var despawnDistanceSquared = despawnDistance * despawnDistance
var dir = Vector2(1,0)

var velocity = Vector2()
var health
var pickupScene

func _ready():
	pickupScene = load("res://Scenes/Instances/clock.tscn").instance()
	health = maxHealth;
	get_node("enemyHealthBar").max_value = maxHealth;
	get_node("enemyHealthBar").value = maxHealth;
	if spright == null:
		print("Error: Enemy with name '" + get_parent().name + "' is missing reference to its sprite")

func setPower(powerIn):
	speed *= powerIn
	damage *= powerIn
	maxHealth *= powerIn
	set_modulate(Color(1,1.1-(powerIn/5.0),1.1-(powerIn/5.0)))

func _process(_delta):
	if position.distance_squared_to(Vector2.ZERO) > despawnDistanceSquared:
		print("Eyeo despawned from being too far away")
		get_parent().queue_free()
	velocity += ((dir * speed) / 10)
	velocity /= 1.05
	velocity = move_and_slide(velocity)
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.is_in_group("player"):
			inflictDamage(collision)
	get_node(spright).set_flip_h(dir[0] < 0);

func inflictDamage(_entity):
	get_parent().get_parent().get_node("Player/KinematicBody2D").takeDamage(damage)

func takeDamage(dmg):
	health -= dmg;
	var playerUI = get_tree().get_current_scene().get_node("CanvasLayer/playerUI")
	playerUI.get_node('SoundHitHurt').pitch_scale = rand_range(0.8, 1.2);
	playerUI.get_node('SoundHitHurt').play();
	$enemyHealthBar.value = health
	if health <= 0:
		call_deferred("die")

func knockback(dir):
	velocity += dir * knockbackRes;

func die():
	pickupScene.setTime(pickUpTime)
	pickupScene.get_node("Area2D").set_position(position + get_parent().position)
	get_parent().get_parent().add_child(pickupScene)
	get_parent().queue_free()


func _on_Timer_timeout():
	get_parent().queue_free()
